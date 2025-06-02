-- ==============================================
-- Definición de un trigger para validar o automatizar operaciones
-- PL_SQL_PROCEDIMIENTO_FUNCIÓN_TRIGGER

-- ==============================================
-- Definición de un trigger para validar o automatizar operaciones
-- Trigger: tr_valida_pago_membresia
--Función: Valida que el monto del pago coincida con el costo del plan asociado al contrato antes de insertar una activación mensual.

-- ==============================================
-- Definición de un trigger para validar o automatizar operaciones
CREATE OR REPLACE TRIGGER tr_valida_pago_membresia
BEFORE INSERT ON ACTIVACIONES_MENSUALES
FOR EACH ROW
-- Declaración de variables para bloque anónimo o ejemplo de uso de procedimientos
DECLARE v_costo_plan NUMBER; v_valor_pago NUMBER;
BEGIN
-- Obtener el costo del plan del contrato
-- Consulta de datos desde la base de datos
SELECT pe.costoPlan INTO v_costo_plan
FROM CONTRATOS c
JOIN PLANES_ENTRENAMIENTO pe ON c.idPlan = pe.idPlan
WHERE c.idContrato = :NEW.idContrato;

-- Obtener el valor del pago
-- Consulta de datos desde la base de datos
SELECT valorPago INTO v_valor_pago
FROM PAGOS_MEMBRESIA
WHERE idPago = :NEW.idPago;

-- Validar que coincidan
IF v_valor_pago != v_costo_plan THEN
RAISE_APPLICATION_ERROR(-20001, 'El monto del pago ('||v_valor_pago||') no coincide con el costo del plan ('||v_costo_plan||')');
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RAISE_APPLICATION_ERROR(-20002, 'No se encontró el contrato o el pago especificado');
END tr_valida_pago_membresia;
/


-- Función para Determinar si un Cliente tiene Contrato Activo

-- ==============================================
-- Definición de una función PL/SQL personalizada
CREATE OR REPLACE FUNCTION fn_cliente_tiene_contrato_activo (
    p_id_cliente IN VARCHAR2
) RETURN VARCHAR2
IS
    v_contador NUMBER;
    v_resultado VARCHAR2(100);
BEGIN
    -- Verificar si el cliente existe
-- Consulta de datos desde la base de datos
    SELECT COUNT(*) INTO v_contador
    FROM CLIENTES
    WHERE idCliente = p_id_cliente;

    IF v_contador = 0 THEN
        RETURN 'Cliente no existe';
    END IF;

    -- Contar contratos activos (donde SYSDATE está entre fechaInicio y fechaCierre)
-- Consulta de datos desde la base de datos
    SELECT COUNT(*) INTO v_contador
    FROM CONTRATOS
    WHERE idCliente = p_id_cliente
    AND SYSDATE BETWEEN fechaInicio AND fechaCierre;

    -- Determinar el resultado
    IF v_contador > 0 THEN
        v_resultado := 'SI';
    ELSE
        -- Verificar si tiene contratos pero no activos
-- Consulta de datos desde la base de datos
        SELECT COUNT(*) INTO v_contador
        FROM CONTRATOS
        WHERE idCliente = p_id_cliente;

        IF v_contador > 0 THEN
            v_resultado := 'NO (pero tiene contratos inactivos)';
        ELSE
            v_resultado := 'NO (sin contratos)';
        END IF;
    END IF;

    RETURN v_resultado;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Error al verificar: ' || SQLERRM;
END fn_cliente_tiene_contrato_activo;
/

-- EJEMPLOS DE APLICACIÓN

-- Ejemplo 1: Verificar estado de un cliente
-- Consulta de datos desde la base de datos
SELECT fn_cliente_tiene_contrato_activo('CLI001') AS estado_contrato FROM dual;

-- Ejemplo 2: Listar todos los clientes con su estado de contrato
-- Consulta de datos desde la base de datos
SELECT idCliente, nombreCliente, fn_cliente_tiene_contrato_activo(idCliente) AS contrato_activo
FROM CLIENTES;

-- Procedimiento Almacenado: sp_activar_membresia
-- Función: Activa una membresía mensual creando registros en ACTIVACIONES_MENSUALES y PAGOS_MEMBRESIA para un contrato específico.

-- ==============================================
-- Creación de un procedimiento almacenado
CREATE OR REPLACE PROCEDURE sp_activar_membresia (
    p_id_contrato IN VARCHAR2,
    p_metodo_pago IN VARCHAR2,
    p_resultado OUT VARCHAR2
)
IS
    v_id_pago VARCHAR2(10);
    v_id_activacion VARCHAR2(10);
    v_costo_plan NUMBER;
    v_contador NUMBER;
BEGIN
    -- Verificar si el contrato existe
-- Consulta de datos desde la base de datos
    SELECT COUNT(*) INTO v_contador FROM CONTRATOS WHERE idContrato = p_id_contrato;

    IF v_contador = 0 THEN
        p_resultado := 'Error: El contrato no existe';
        RETURN;
    END IF;

    -- Obtener el costo del plan asociado al contrato
-- Consulta de datos desde la base de datos
    SELECT pe.costoPlan INTO v_costo_plan
    FROM CONTRATOS c
    JOIN PLANES_ENTRENAMIENTO pe ON c.idPlan = pe.idPlan
    WHERE c.idContrato = p_id_contrato;

    -- Generar ID para el pago
-- Consulta de datos desde la base de datos
    SELECT 'PAG'||LPAD(NVL(MAX(TO_NUMBER(SUBSTR(idPago, 4))), 0)+1, 3, '0')
    INTO v_id_pago FROM PAGOS_MEMBRESIA;

    -- Insertar el pago
-- Inserción de datos en la tabla correspondiente
    INSERT INTO PAGOS_MEMBRESIA (idPago, fechaPago, valorPago, estadoPago, metodoPago)
    VALUES (v_id_pago, SYSDATE, v_costo_plan, 'Completo', p_metodo_pago);

    -- Generar ID para la activación
-- Consulta de datos desde la base de datos
    SELECT 'ACT'||LPAD(NVL(MAX(TO_NUMBER(SUBSTR(idActivacion, 4))), 0)+1, 3, '0')
    INTO v_id_activacion FROM ACTIVACIONES_MENSUALES;

    -- Insertar la activación mensual
-- Inserción de datos en la tabla correspondiente
    INSERT INTO ACTIVACIONES_MENSUALES (idActivacion, idContrato, idPago)
    VALUES (v_id_activacion, p_id_contrato, v_id_pago);

    p_resultado := 'Membresía activada correctamente para el contrato '||p_id_contrato;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_resultado := 'Error al activar membresía: '||SQLERRM;
END sp_activar_membresia;
/

-- EJEMPLO DE APLICACION

-- Declaración de variables para bloque anónimo o ejemplo de uso de procedimientos
DECLARE
    v_resultado VARCHAR2(200);
BEGIN
    sp_activar_membresia('CONT001', 'Tarjeta', v_resultado);
    DBMS_OUTPUT.PUT_LINE(v_resultado);
END;
/
