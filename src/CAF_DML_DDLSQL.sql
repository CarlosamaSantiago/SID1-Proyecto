-- Creación Base De Datos del Gymnasio
-- DDL
SET SERVEROUTPUT ON
-- Eliminar tablas en orden inverso a su creación (primero las más dependientes)
DROP TABLE ACTIVACIONES_MENSUALES;
DROP TABLE ASISTENCIAS;
DROP TABLE MANTENIMIENTOS;
DROP TABLE EVALUACIONES_FISICAS;
DROP TABLE PRODUCTOS_VENDIDOS;
DROP TABLE PRODUCTOS_SURTIDOS;
DROP TABLE CONTRATOS;
DROP TABLE PAGOS_MEMBRESIA;
DROP TABLE VENTAS;
DROP TABLE PEDIDOS;
DROP TABLE IMPLEMENTOS;
DROP TABLE PLANES_ENTRENAMIENTO;
DROP TABLE RECEPCIONISTAS;
DROP TABLE TECNICOS;
DROP TABLE ENTRENADORES;
DROP TABLE PRODUCTOS;
DROP TABLE PROVEEDORES;
DROP TABLE CLIENTES CASCADE CONSTRAINTS;
DROP TABLE HORARIOS_RECEPCIONISTAS;

CREATE TABLE HORARIOS_RECEPCIONISTAS(
    idHorario VARCHAR2(10 CHAR) NOT NULL,
    horaInicio VARCHAR2(5 CHAR) NOT NULL,
    horaFinal VARCHAR2(5 CHAR) NOT NULL
);

ALTER TABLE HORARIOS_RECEPCIONISTAS
    ADD CONSTRAINT HORARIOS_RECEPCIONISTAS_PK PRIMARY KEY (idHorario);

-- Crear tabla CLIENTES
CREATE TABLE CLIENTES (
    idCliente VARCHAR2(10 CHAR) NOT NULL,
    nombreCliente VARCHAR2(30 CHAR) NOT NULL,
    telefonoCliente VARCHAR2(10 CHAR) NOT NULL,
    correoCliente VARCHAR2(30 CHAR) NOT NULL,
    sexoCliente VARCHAR2(9 CHAR) NOT NULL
);

ALTER TABLE CLIENTES
    ADD CONSTRAINT CLIENTE_PK PRIMARY KEY (idCliente);
ALTER TABLE CLIENTES
ADD CONSTRAINT chk_genero CHECK (sexoCliente IN ('MASCULINO', 'FEMENINO'));


-- Crear tabla PROVEEDORES
CREATE TABLE PROVEEDORES (
    idProveedor VARCHAR2(10 CHAR) NOT NULL,
    condicionesDePago VARCHAR2(30 CHAR) NOT NULL,
    telefonoProveedor VARCHAR2(30 CHAR) NOT NULL,
    correoProveedor VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE PROVEEDORES
    ADD CONSTRAINT PROVEEDOR_PK PRIMARY KEY (idProveedor);

-- Crear tabla PRODUCTOS
CREATE TABLE PRODUCTOS (
    idProducto VARCHAR2(10) NOT NULL,
    precioProducto NUMBER(2) NOT NULL,
    nombreProducto VARCHAR2(20 CHAR) NOT NULL,
    stock INTEGER NOT NULL,
    marcaProducto VARCHAR2(10),
    descripcionProducto VARCHAR2(10)
);

ALTER TABLE PRODUCTOS
    ADD CONSTRAINT PRODUCTO_PK PRIMARY KEY (idProducto);

-- Crear tabla RECEPCIONISTAS
CREATE TABLE RECEPCIONISTAS (
    idRecepcionista VARCHAR2(10 CHAR) NOT NULL,
    nombreRecepcionista VARCHAR2(30 CHAR) NOT NULL,
    horarioTrabajo VARCHAR2(10 CHAR) NOT NULL,
    salario INTEGER NOT NULL
);

ALTER TABLE RECEPCIONISTAS
    ADD CONSTRAINT RECEPCIONISTA_PK PRIMARY KEY (idRecepcionista);
ALTER TABLE RECEPCIONISTAS
    ADD CONSTRAINT HORARIO_TRABAJO_FK FOREIGN KEY (horarioTrabajo)
        REFERENCES HORARIOS_RECEPCIONISTAS (idHorario);
    
-- Crear tabla ENTRENADORES
CREATE TABLE ENTRENADORES (
    idEntrenador VARCHAR2(10 CHAR) NOT NULL,
    nombreEntrenador VARCHAR2(30 CHAR) NOT NULL,
    reputacion INTEGER NOT NULL,
    costoHora NUMBER NOT NULL
);

ALTER TABLE ENTRENADORES
    ADD CONSTRAINT ENTRENADOR_PK PRIMARY KEY (idEntrenador);

-- Crear tabla TECNICOS
CREATE TABLE TECNICOS (
    idTecnico VARCHAR2(10 CHAR) NOT NULL,
    nombreTecnico VARCHAR2(10 CHAR) NOT NULL,
    costoHora NUMBER NOT NULL,
    tituloAcademico BLOB NOT NULL,
    telefonoTecnico VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE TECNICOS
    ADD CONSTRAINT TECNICO_PK PRIMARY KEY (idTecnico);
    
-- Crear tabla PLANES_ENTRENAMIENTO
CREATE TABLE PLANES_ENTRENAMIENTO (
    idPlan VARCHAR2(10 CHAR) NOT NULL ,
    objetivoPlan VARCHAR2(100 CHAR) NOT NULL,
    duracionPlan INTEGER NOT NULL,
    costoPlan NUMBER NOT NULL,
    observaciones VARCHAR2(100 CHAR)NOT NULL 
);

ALTER TABLE PLANES_ENTRENAMIENTO
    ADD CONSTRAINT PLAN_ENTRENAMIENTO_PK PRIMARY KEY (idPlan);
    
-- Crear tabla IMPLEMENTOS
CREATE TABLE IMPLEMENTOS (
    idImplemento VARCHAR2(10 CHAR) NOT NULL,
    nombreImplemento VARCHAR2(20) NOT NULL,
    inicioServicio DATE NOT NULL,
    finServicio DATE 
);

ALTER TABLE IMPLEMENTOS
    ADD CONSTRAINT IMPLEMENTO_PK PRIMARY KEY (idImplemento);
    
-- Crear tabla PEDIDOS
CREATE TABLE PEDIDOS (
    idPedido VARCHAR2(10 CHAR) NOT NULL,
    fechaDePetición DATE NOT NULL,
    estadoPedido VARCHAR2(10 CHAR) NOT NULL,
    fechaEntrega DATE ,
    idProveedor VARCHAR2(10 CHAR)NOT NULL
);

ALTER TABLE PEDIDOS
    ADD CONSTRAINT PEDIDO_PK PRIMARY KEY (idPedido);

ALTER TABLE PEDIDOS
    ADD CONSTRAINT PEDIDO_PROVEEDOR_FK FOREIGN KEY (idProveedor)
        REFERENCES PROVEEDORES (idProveedor);
ALTER TABLE PEDIDOS
ADD CONSTRAINT chk_estadoPedido CHECK (estadoPedido IN ('SOLICITADO', 'EN CAMINO', 'RECIBIDO'));

        
-- Crear tabla VENTAS
CREATE TABLE VENTAS (
    idVenta VARCHAR2(10 CHAR) NOT NULL,
    fechaVenta VARCHAR2(10 CHAR) NOT NULL,
    idCliente VARCHAR2(10 CHAR) NOT NULL,
    idRecepcionista VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE VENTAS
    ADD CONSTRAINT VENTA_PK PRIMARY KEY (idVenta);

ALTER TABLE VENTAS
    ADD CONSTRAINT VENTA_CLIENTE_FK FOREIGN KEY (idCliente)
        REFERENCES CLIENTES (idCliente);

ALTER TABLE VENTAS
    ADD CONSTRAINT VENTA_RECEPCIONISTA_FK FOREIGN KEY (idRecepcionista)
        REFERENCES RECEPCIONISTAS (idRecepcionista);
        
-- Crear tabla PAGOS_MEMBRESIA
CREATE TABLE PAGOS_MEMBRESIA (
    idPago VARCHAR2(10 CHAR) NOT NULL,
    fechaPago DATE NOT NULL, 
    valorPago NUMBER NOT NULL,
    estadoPago VARCHAR2(10 CHAR)NOT NULL,
    metodoPago VARCHAR2(10 CHAR)NOT NULL
);

ALTER TABLE PAGOS_MEMBRESIA
    ADD CONSTRAINT PAGO_MEMBRESIA_PK PRIMARY KEY (idPago);
    
-- Crear tabla CONTRATOS
CREATE TABLE CONTRATOS (
    idContrato VARCHAR2(10) NOT NULL,
    fechaInicio DATE NOT NULL, 
    fechaCierre DATE NOT NULL,
    idCliente VARCHAR2(10 CHAR) NOT NULL,
    idPlan VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE CONTRATOS
    ADD CONSTRAINT CONTRATO_PK PRIMARY KEY (idContrato);

ALTER TABLE CONTRATOS
    ADD CONSTRAINT CONTRATO_CLIENTE_FK FOREIGN KEY (idCliente)
        REFERENCES CLIENTES (idCliente);

ALTER TABLE CONTRATOS
    ADD CONSTRAINT CONTRATO_PLAN_ENTRENAMIENTO_FK FOREIGN KEY (idPlan)
        REFERENCES PLANES_ENTRENAMIENTO (idPlan);
        
-- Crear tabla PRODUCTOS_SURTIDOS
CREATE TABLE PRODUCTOS_SURTIDOS (
    idSurtidos VARCHAR2(10) NOT NULL,
    cantidadProducto INTEGER NOT NULL,
    idProducto VARCHAR2(10) NOT NULL,
    idPedido VARCHAR2(10 CHAR)NOT NULL
);

ALTER TABLE PRODUCTOS_SURTIDOS
    ADD CONSTRAINT PRODUCTO_SURTIDO_PK PRIMARY KEY (idSurtidos);

ALTER TABLE PRODUCTOS_SURTIDOS
    ADD CONSTRAINT PRODUCTO_SURTIDO_PRODUCTO_FK FOREIGN KEY (idProducto)
        REFERENCES PRODUCTOS (idProducto);

ALTER TABLE PRODUCTOS_SURTIDOS
    ADD CONSTRAINT PRODUCTO_SURTIDO_PEDIDO_FK FOREIGN KEY (idPedido)
        REFERENCES PEDIDOS (idPedido);

-- Crear tabla PRODUCTOS_VENDIDOS
CREATE TABLE PRODUCTOS_VENDIDOS (
    idVendidos VARCHAR2(10) NOT NULL,
    idVenta VARCHAR2(10 CHAR) NOT NULL,
    cantidadTotal INTEGER NOT NULL,
    idProducto VARCHAR2(10) NOT NULL
);

ALTER TABLE PRODUCTOS_VENDIDOS
    ADD CONSTRAINT PRODUCTO_VENDIDO_PK PRIMARY KEY (idVendidos);

ALTER TABLE PRODUCTOS_VENDIDOS
    ADD CONSTRAINT PRODUCTO_VENDIDO_VENTA_FK FOREIGN KEY (idVenta)
        REFERENCES VENTAS (idVenta);

ALTER TABLE PRODUCTOS_VENDIDOS
    ADD CONSTRAINT PRODUCTO_VENDIDO_PRODUCTO_FK FOREIGN KEY (idProducto)
        REFERENCES PRODUCTOS (idProducto);
        
-- Crear tabla EVALUACIONES_FISICAS
CREATE TABLE EVALUACIONES_FISICAS (
    idEvaluación VARCHAR2(10 CHAR) NOT NULL,
    fechaEvaluacion DATE NOT NULL,
    peso FLOAT NOT NULL,
    estatura NUMBER NOT NULL,
    IMC FLOAT NOT NULL,
    porcentajeGrasa FLOAT ,
    observaciones VARCHAR2(100),
    idCliente VARCHAR2(10 CHAR) NOT NULL,
    idEntrenador VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE EVALUACIONES_FISICAS
    ADD CONSTRAINT EVALUACION_FISICA_PK PRIMARY KEY (idEvaluación);

ALTER TABLE EVALUACIONES_FISICAS
    ADD CONSTRAINT EVALUACION_FISICA_CLIENTE_FK FOREIGN KEY (idCliente)
        REFERENCES CLIENTES (idCliente);

ALTER TABLE EVALUACIONES_FISICAS
    ADD CONSTRAINT EVALUACION_FISICA_ENTRENADOR_FK FOREIGN KEY (idEntrenador)
        REFERENCES ENTRENADORES (idEntrenador);

-- Crear tabla MANTENIMIENTOS
CREATE TABLE MANTENIMIENTOS (
    idMantenimiento VARCHAR2(10 CHAR) NOT NULL,
    fechaMantenimiento DATE NOT NULL,
    observacionesMantenimiento VARCHAR2(100 CHAR),
    idImplemento VARCHAR2(10 CHAR)NOT NULL,
    idTecnico VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE MANTENIMIENTOS
    ADD CONSTRAINT MANTENIMIENTO_PK PRIMARY KEY (idMantenimiento);

ALTER TABLE MANTENIMIENTOS
    ADD CONSTRAINT MANTENIMIENTO_IMPLEMENTO_FK FOREIGN KEY (idImplemento)
        REFERENCES IMPLEMENTOS (idImplemento);

ALTER TABLE MANTENIMIENTOS
    ADD CONSTRAINT MANTENIMIENTO_TECNICO_FK FOREIGN KEY (idTecnico)
        REFERENCES TECNICOS (idTecnico);

-- Crear tabla ASISTENCIAS
CREATE TABLE ASISTENCIAS (
    idAsistencia VARCHAR2(10 CHAR) NOT NULL ,
    fechaAsistencia DATE NOT NULL,
    horaLlegada DATE NOT NULL,
    horaSalida DATE,
    idCliente VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE ASISTENCIAS
    ADD CONSTRAINT ASISTENCIA_PK PRIMARY KEY (idAsistencia);

ALTER TABLE ASISTENCIAS
    ADD CONSTRAINT ASISTENCIA_CLIENTE_FK FOREIGN KEY (idCliente)
        REFERENCES CLIENTES (idCliente);
    
-- Crear tabla ACTIVACIONES_MENSUALES
CREATE TABLE ACTIVACIONES_MENSUALES (
    idActivacion VARCHAR2(10 CHAR) NOT NULL,
    idContrato VARCHAR2(10) NOT NULL,
    idPago VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE ACTIVACIONES_MENSUALES
    ADD CONSTRAINT ACTIVACION_MENSUAL_PK PRIMARY KEY (idActivacion);

ALTER TABLE ACTIVACIONES_MENSUALES
    ADD CONSTRAINT ACTIVACION_MENSUAL_CONTRATO_FK FOREIGN KEY (idContrato)
        REFERENCES CONTRATOS (idContrato);

ALTER TABLE ACTIVACIONES_MENSUALES
    ADD CONSTRAINT ACTIVACION_MENSUAL_PAGO_MEMBRESIA_FK FOREIGN KEY (idPago)
        REFERENCES PAGOS_MEMBRESIA (idPago);

-- Inserción de Datos
-- DML:
-- CLIENTES
INSERT INTO CLIENTES VALUES ('CLI001', 'María González', '5551234567', 'maria.g@email.com', 'FEMENINO');
INSERT INTO CLIENTES VALUES ('CLI002', 'Carlos Mendoza', '5552345678', 'carlos.m@email.com', 'MASCULINO');
INSERT INTO CLIENTES VALUES ('CLI003', 'Ana López', '5553456789', 'ana.l@email.com', 'FEMENINO');
INSERT INTO CLIENTES VALUES ('CLI004', 'Jorge Ramírez', '5554567890', 'jorge.r@email.com', 'MASCULINO');
INSERT INTO CLIENTES VALUES ('CLI005', 'Luisa Fernández', '5555678901', 'luisa.f@email.com', 'FEMENINO');
INSERT INTO CLIENTES VALUES ('CLI006', 'Juliana Martinez', '5553214567', 'juliii@email.com', 'FEMENINO');
INSERT INTO CLIENTES VALUES ('CLI007', 'Andres Rodriguez', '5552344578', 'andrrz@email.com', 'MASCULINO');
INSERT INTO CLIENTES VALUES ('CLI008', 'Marta Castillo', '5553458369', 'macar@email.com', 'FEMENINO');
INSERT INTO CLIENTES VALUES ('CLI009', 'Felipe Ñandu', '5554456789', 'felipee.ñ@email.com', 'MASCULINO');
INSERT INTO CLIENTES VALUES ('CLI010', 'Salome Fernández', '5555633301', 'soe@email.com', 'FEMENINO');
-- PROVEEDORES
INSERT INTO PROVEEDORES VALUES ('PROV001', '30 días neto', '5559876543', 'contacto@suplementos.com');
INSERT INTO PROVEEDORES VALUES ('PROV002', 'Pago contra entrega', '5558765432', 'ventas@equiposgym.com');
INSERT INTO PROVEEDORES VALUES ('PROV003', '15 días neto', '5557654321', 'info@bebidasenergia.com');
-- PRODUCTOS
INSERT INTO PRODUCTOS VALUES ('PROD001', 25, 'Proteína Whey', 50, 'Optimum', 'Suplemento');
INSERT INTO PRODUCTOS VALUES ('PROD002', 15, 'Creatina', 30, 'MuscleTech', 'Suplemento');
INSERT INTO PRODUCTOS VALUES ('PROD003', 10, 'Shaker', 100, 'Generic', 'Accesorio');
INSERT INTO PRODUCTOS VALUES ('PROD004', 5, 'Toalla', 75, 'Generic', 'Accesorio');
INSERT INTO PRODUCTOS VALUES ('PROD005', 3, 'Botella Agua', 120, 'Sport', 'Accesorio');
-- HORARIOS_RECEPCIONISTAS
INSERT INTO HORARIOS_RECEPCIONISTAS VALUES ('H001','05:00','13:00');
INSERT INTO HORARIOS_RECEPCIONISTAS VALUES ('H002','13:00','21:00');
INSERT INTO HORARIOS_RECEPCIONISTAS VALUES ('H003','21:00','05:00');
-- RECEPCIONISTAS
INSERT INTO RECEPCIONISTAS VALUES ('REC001', 'Sofía Jiménez', 'H001' , 164750000);
INSERT INTO RECEPCIONISTAS VALUES ('REC002', 'Pedro Vargas', 'H002', 164750000);
INSERT INTO RECEPCIONISTAS VALUES ('REC003', 'Matias Vasquez', 'H003', 164750000);
-- ENTRENADORES
INSERT INTO ENTRENADORES VALUES ('ENT001', 'Roberto Castro', 5, 30);
INSERT INTO ENTRENADORES VALUES ('ENT002', 'Laura Méndez', 4, 25);
INSERT INTO ENTRENADORES VALUES ('ENT003', 'Miguel Ángel Soto', 3, 20);
-- TECNICOS
INSERT INTO TECNICOS VALUES ('TEC001', 'Juan Pérez', 15, EMPTY_BLOB(), '5551112233');
INSERT INTO TECNICOS VALUES ('TEC002', 'Ana Ruiz', 18, EMPTY_BLOB(), '5552223344');
-- PLANES_ENTRENAMIENTO
INSERT INTO PLANES_ENTRENAMIENTO VALUES ('PLAN001', 'Pérdida de peso', 12 , 150, '3 sesiones semanales');
INSERT INTO PLANES_ENTRENAMIENTO VALUES ('PLAN002', 'Ganancia muscular', 12, 200, '4 sesiones semanales');
INSERT INTO PLANES_ENTRENAMIENTO VALUES ('PLAN003', 'Mantenimiento', 6, 100, '2 sesiones semanales');
-- IMPLEMENTOS
INSERT INTO IMPLEMENTOS VALUES ('IMP001', 'Mancuernas', TO_DATE('01/01/2022', 'DD/MM/YYYY'), TO_DATE('31/12/2025', 'DD/MM/YYYY'));
INSERT INTO IMPLEMENTOS VALUES ('IMP002', 'Bicicleta estática', TO_DATE('15/03/2022', 'DD/MM/YYYY'), TO_DATE('14/03/2027', 'DD/MM/YYYY'));
INSERT INTO IMPLEMENTOS VALUES ('IMP003', 'Banco de pesas', TO_DATE('10/05/2021', 'DD/MM/YYYY'), TO_DATE('09/05/2026', 'DD/MM/YYYY'));
-- PEDIDOS
INSERT INTO PEDIDOS VALUES ('PED001', TO_DATE('10/01/2023', 'DD/MM/YYYY'), 'RECIBIDO', TO_DATE('15/01/2023', 'DD/MM/YYYY'), 'PROV001');
INSERT INTO PEDIDOS VALUES ('PED002', TO_DATE('05/02/2023', 'DD/MM/YYYY'), 'SOLICITADO', NULL, 'PROV002');
-- VENTAS
INSERT INTO VENTAS VALUES ('VEN001', '10/01/2023', 'CLI001', 'REC001');
INSERT INTO VENTAS VALUES ('VEN002', '15/01/2023', 'CLI003', 'REC002');
-- PAGOS_MEMBRESIA
INSERT INTO PAGOS_MEMBRESIA VALUES ('PAG001', TO_DATE('05/01/2023', 'DD/MM/YYYY'), 150, 'Completo', 'Tarjeta');
INSERT INTO PAGOS_MEMBRESIA VALUES ('PAG002', TO_DATE('10/01/2023', 'DD/MM/YYYY'), 200, 'Completo', 'Efectivo');
-- CONTRATOS
INSERT INTO CONTRATOS VALUES ('CONT001', TO_DATE('01/01/2023', 'DD/MM/YYYY'), TO_DATE('30/06/2023', 'DD/MM/YYYY'), 'CLI001', 'PLAN001');
INSERT INTO CONTRATOS VALUES ('CONT002', TO_DATE('10/01/2023', 'DD/MM/YYYY'), TO_DATE('31/12/2023', 'DD/MM/YYYY'), 'CLI002', 'PLAN002');
-- PRODUCTOS_SURTIDOS
INSERT INTO PRODUCTOS_SURTIDOS VALUES ('SUR001', 20, 'PROD001', 'PED001');
INSERT INTO PRODUCTOS_SURTIDOS VALUES ('SUR002', 50, 'PROD003', 'PED001');
-- PRODUCTOS_VENDIDOS
INSERT INTO PRODUCTOS_VENDIDOS VALUES ('VEND001', 'VEN001', 2, 'PROD001');
INSERT INTO PRODUCTOS_VENDIDOS VALUES ('VEND002', 'VEN002', 1, 'PROD003');
-- EVALUACIONES_FISICAS
INSERT INTO EVALUACIONES_FISICAS VALUES ('EVAL001', TO_DATE('15/01/2023', 'DD/MM/YYYY'), 68.5, 165, 25.2, 22.5, 'Buen estado físico', 'CLI001', 'ENT001');
INSERT INTO EVALUACIONES_FISICAS VALUES ('EVAL002', TO_DATE('20/01/2023', 'DD/MM/YYYY'), 75.0, 170, 25.9, 24.0, 'Necesita mejorar resistencia', 'CLI002', 'ENT002');
-- MANTENIMIENTOS
INSERT INTO MANTENIMIENTOS VALUES ('MANT001', TO_DATE('05/01/2023', 'DD/MM/YYYY'), 'Lubricación y ajuste', 'IMP002', 'TEC001');
INSERT INTO MANTENIMIENTOS VALUES ('MANT002', TO_DATE('12/01/2023', 'DD/MM/YYYY'), 'Cambio de piezas gastadas', 'IMP003', 'TEC002');
-- ASISTENCIAS
INSERT INTO ASISTENCIAS VALUES ('ASIS001', TO_DATE('05/01/2023', 'DD/MM/YYYY'), TO_DATE('05/01/2023 09:00:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('05/01/2023 10:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI004');
INSERT INTO ASISTENCIAS VALUES ('ASIS002', TO_DATE('07/01/2023', 'DD/MM/YYYY'), TO_DATE('07/01/2023 14:15:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('07/01/2023 15:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI002');
INSERT INTO ASISTENCIAS VALUES ('ASIS003', TO_DATE('09/01/2023', 'DD/MM/YYYY'), TO_DATE('09/01/2023 08:45:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('09/01/2023 10:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI007');
INSERT INTO ASISTENCIAS VALUES ('ASIS004', TO_DATE('10/01/2023', 'DD/MM/YYYY'), TO_DATE('10/01/2023 10:00:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('10/01/2023 11:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI005');
INSERT INTO ASISTENCIAS VALUES ('ASIS005', TO_DATE('11/01/2023', 'DD/MM/YYYY'), TO_DATE('11/01/2023 13:00:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('11/01/2023 14:15:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI008');
INSERT INTO ASISTENCIAS VALUES ('ASIS006', TO_DATE('13/01/2023', 'DD/MM/YYYY'), TO_DATE('13/01/2023 16:30:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('13/01/2023 17:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI003');
INSERT INTO ASISTENCIAS VALUES ('ASIS007', TO_DATE('15/01/2023', 'DD/MM/YYYY'), TO_DATE('15/01/2023 07:30:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('15/01/2023 09:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI001');
INSERT INTO ASISTENCIAS VALUES ('ASIS008', TO_DATE('18/01/2023', 'DD/MM/YYYY'), TO_DATE('18/01/2023 12:00:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('18/01/2023 13:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI010');
INSERT INTO ASISTENCIAS VALUES ('ASIS009', TO_DATE('21/01/2023', 'DD/MM/YYYY'), TO_DATE('21/01/2023 10:15:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('21/01/2023 11:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI006');
INSERT INTO ASISTENCIAS VALUES ('ASIS010', TO_DATE('25/01/2023', 'DD/MM/YYYY'), TO_DATE('25/01/2023 15:30:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('25/01/2023 16:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI009');
INSERT INTO ASISTENCIAS VALUES ('ASIS011', TO_DATE('28/01/2023', 'DD/MM/YYYY'), TO_DATE('28/01/2023 08:00:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('28/01/2023 09:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI002');
INSERT INTO ASISTENCIAS VALUES ('ASIS012', TO_DATE('30/01/2023', 'DD/MM/YYYY'), TO_DATE('30/01/2023 17:00:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('30/01/2023 18:15:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI004');
INSERT INTO ASISTENCIAS VALUES ('ASIS013', TO_DATE('01/02/2023', 'DD/MM/YYYY'), TO_DATE('01/02/2023 09:45:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('01/02/2023 11:15:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI006');
INSERT INTO ASISTENCIAS VALUES ('ASIS014', TO_DATE('03/02/2023', 'DD/MM/YYYY'), TO_DATE('03/02/2023 13:30:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('03/02/2023 15:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI007');
INSERT INTO ASISTENCIAS VALUES ('ASIS015', TO_DATE('05/02/2023', 'DD/MM/YYYY'), TO_DATE('05/02/2023 11:00:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('05/02/2023 12:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI001');
INSERT INTO ASISTENCIAS VALUES ('ASIS016', TO_DATE('06/02/2023', 'DD/MM/YYYY'), TO_DATE('06/02/2023 10:30:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('06/02/2023 11:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI009');
INSERT INTO ASISTENCIAS VALUES ('ASIS017', TO_DATE('07/02/2023', 'DD/MM/YYYY'), TO_DATE('07/02/2023 16:00:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('07/02/2023 17:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI003');
INSERT INTO ASISTENCIAS VALUES ('ASIS018', TO_DATE('09/02/2023', 'DD/MM/YYYY'), TO_DATE('09/02/2023 14:00:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('09/02/2023 15:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI010');
INSERT INTO ASISTENCIAS VALUES ('ASIS019', TO_DATE('11/02/2023', 'DD/MM/YYYY'), TO_DATE('11/02/2023 08:15:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('11/02/2023 09:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI008');
INSERT INTO ASISTENCIAS VALUES ('ASIS020', TO_DATE('13/02/2023', 'DD/MM/YYYY'), TO_DATE('13/02/2023 09:30:00', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('13/02/2023 10:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'CLI005');



-- ACTIVACIONES_MENSUALES
INSERT INTO ACTIVACIONES_MENSUALES VALUES ('ACT001', 'CONT001', 'PAG001');
INSERT INTO ACTIVACIONES_MENSUALES VALUES ('ACT002', 'CONT002', 'PAG002');

--2.Consultas:
-- Lista de clientes con membresía vigente, incluyendo su tipo de plan y fecha de vencimiento.
SELECT c.idCliente, c.nombreCliente, pe.objetivoPlan AS tipoPlan, ct.fechaCierre AS fechaVencimiento
FROM CLIENTES c
JOIN CONTRATOS ct ON c.idCliente = ct.idCliente
JOIN PLANES_ENTRENAMIENTO pe ON ct.idPlan = pe.idPlan
WHERE SYSDATE BETWEEN ct.fechaInicio AND ct.fechaCierre;

-- Registro de los implementos a los cuales no se les hace mantenimiento desde hace más de un mes incluyendo información del tiempo que llevan sin mantenimiento

SELECT i.idImplemento, i.nombreImplemento, MAX(m.fechaMantenimiento) AS ultima_fecha,
CASE 
WHEN MAX(m.fechaMantenimiento) IS NULL THEN 'Nunca'
ELSE TO_CHAR(TRUNC(MONTHS_BETWEEN(SYSDATE, MAX(m.fechaMantenimiento)))) || ' meses'
END AS tiempo_sin_mantenimiento
FROM IMPLEMENTOS i
LEFT JOIN MANTENIMIENTOS m ON i.idImplemento = m.idImplemento
GROUP BY i.idImplemento, i.nombreImplemento
HAVING MAX(m.fechaMantenimiento) < ADD_MONTHS(SYSDATE, -1)
   OR MAX(m.fechaMantenimiento) IS NULL
ORDER BY NVL(MAX(m.fechaMantenimiento), TO_DATE('01-01-1900', 'DD-MM-YYYY'));


-- Recepcionista que más vende junto a su cantidad
SELECT r.idRecepcionista, r.nombreRecepcionista AS nombre_completo, COUNT(v.idVenta) AS total_ventas
FROM VENTAS v
JOIN RECEPCIONISTAS r ON v.idRecepcionista = r.idRecepcionista
GROUP BY r.idRecepcionista, r.nombreRecepcionista
ORDER BY total_ventas DESC
FETCH FIRST 1 ROWS ONLY;


-- Ingresos del último mes
SELECT SUM(p.precioProducto * pv.cantidadTotal) AS ingresos_ultimo_mes
FROM VENTAS v
JOIN PRODUCTOS_VENDIDOS pv ON v.idVenta = pv.idVenta
JOIN PRODUCTOS p ON pv.idProducto = p.idProducto
WHERE TO_DATE(v.fechaVenta, 'DD/MM/YYYY') >= ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -1) 
  AND TO_DATE(v.fechaVenta, 'DD/MM/YYYY') < TRUNC(SYSDATE, 'MM');

-- Lista los productos más vendidos en un período determinado, agrupados por categoría y cantidad total vendida. 

SELECT p.descripcionProducto AS categoria, p.nombreProducto AS producto, SUM(pv.cantidadTotal) AS cantidad_total_vendida, SUM(pv.cantidadTotal * p.precioProducto) AS ingresos_totales
FROM PRODUCTOS_VENDIDOS pv
JOIN PRODUCTOS p ON pv.idProducto = p.idProducto
JOIN VENTAS v ON pv.idVenta = v.idVenta
WHERE TO_DATE(v.fechaVenta, 'DD/MM/YYYY') BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/01/2023', 'DD/MM/YYYY')
GROUP BY p.descripcionProducto, p.nombreProducto
ORDER BY cantidad_total_vendida DESC;


-- contabilizar las ventas realizadas por cada recepcionista junto con el precio total

SELECT r.idRecepcionista, r.nombreRecepcionista, COUNT(v.idVenta) AS cantidad_ventas, SUM(p.precioProducto * pv.cantidadTotal) AS total_ingresos
FROM RECEPCIONISTAS r
JOIN VENTAS v ON r.idRecepcionista = v.idRecepcionista
JOIN PRODUCTOS_VENDIDOS pv ON v.idVenta = pv.idVenta
JOIN PRODUCTOS p ON pv.idProducto = p.idProducto
GROUP BY r.idRecepcionista, r.nombreRecepcionista
ORDER BY total_ingresos DESC;


-- evolución del peso de cada cliente entre su primera y última evaluación física
WITH EvaluacionesOrdenadas AS (
SELECT ef.idCliente, c.nombreCliente, ef.fechaEvaluacion, ef.peso, ROW_NUMBER() OVER (PARTITION BY ef.idCliente ORDER BY ef.fechaEvaluacion ASC) AS primera_evaluacion, ROW_NUMBER() OVER (PARTITION BY ef.idCliente ORDER BY ef.fechaEvaluacion DESC) AS ultima_evaluacion
FROM EVALUACIONES_FISICAS ef
JOIN CLIENTES c ON ef.idCliente = c.idCliente
)
SELECT e1.idCliente, e1.nombreCliente, e1.fechaEvaluacion AS fecha_primera_evaluacion, e1.peso AS peso_inicial, e2.fechaEvaluacion AS fecha_ultima_evaluacion, e2.peso AS peso_final, ROUND(e2.peso - e1.peso, 2) AS cambio_peso,
CASE 
WHEN e2.peso - e1.peso > 0 THEN 'Aumento'
WHEN e2.peso - e1.peso < 0 THEN 'Disminución'
ELSE 'Sin cambio'
END AS tendencia
FROM EvaluacionesOrdenadas e1
JOIN EvaluacionesOrdenadas e2 ON e1.idCliente = e2.idCliente
WHERE e1.primera_evaluacion = 1 AND e2.ultima_evaluacion = 1
ORDER BY ABS(e2.peso - e1.peso) DESC;



-- PL_SQL_PROCEDIMIENTO_FUNCIÓN_TRIGGER

-- Trigger: tr_valida_pago_membresia
--Función: Valida que el monto del pago coincida con el costo del plan asociado al contrato antes de insertar una activación mensual.

CREATE OR REPLACE TRIGGER tr_valida_pago_membresia
BEFORE INSERT ON ACTIVACIONES_MENSUALES
FOR EACH ROW
DECLARE v_costo_plan NUMBER; v_valor_pago NUMBER;
BEGIN
-- Obtener el costo del plan del contrato
SELECT pe.costoPlan INTO v_costo_plan
FROM CONTRATOS c
JOIN PLANES_ENTRENAMIENTO pe ON c.idPlan = pe.idPlan
WHERE c.idContrato = :NEW.idContrato;
    
-- Obtener el valor del pago
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

CREATE OR REPLACE FUNCTION fn_cliente_tiene_contrato_activo (
    p_id_cliente IN VARCHAR2
) RETURN VARCHAR2
IS
    v_contador NUMBER;
    v_resultado VARCHAR2(100);
BEGIN
    -- Verificar si el cliente existe
    SELECT COUNT(*) INTO v_contador 
    FROM CLIENTES 
    WHERE idCliente = p_id_cliente;
    
    IF v_contador = 0 THEN
        RETURN 'Cliente no existe';
    END IF;
    
    -- Contar contratos activos (donde SYSDATE está entre fechaInicio y fechaCierre)
    SELECT COUNT(*) INTO v_contador
    FROM CONTRATOS
    WHERE idCliente = p_id_cliente
    AND SYSDATE BETWEEN fechaInicio AND fechaCierre;
    
    -- Determinar el resultado
    IF v_contador > 0 THEN
        v_resultado := 'SI';
    ELSE
        -- Verificar si tiene contratos pero no activos
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
SELECT fn_cliente_tiene_contrato_activo('CLI001') AS estado_contrato FROM dual;

-- Ejemplo 2: Listar todos los clientes con su estado de contrato
SELECT idCliente, nombreCliente, fn_cliente_tiene_contrato_activo(idCliente) AS contrato_activo
FROM CLIENTES;

-- Procedimiento Almacenado: sp_activar_membresia
-- Función: Activa una membresía mensual creando registros en ACTIVACIONES_MENSUALES y PAGOS_MEMBRESIA para un contrato específico.

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
    SELECT COUNT(*) INTO v_contador FROM CONTRATOS WHERE idContrato = p_id_contrato;
    
    IF v_contador = 0 THEN
        p_resultado := 'Error: El contrato no existe';
        RETURN;
    END IF;
    
    -- Obtener el costo del plan asociado al contrato
    SELECT pe.costoPlan INTO v_costo_plan
    FROM CONTRATOS c
    JOIN PLANES_ENTRENAMIENTO pe ON c.idPlan = pe.idPlan
    WHERE c.idContrato = p_id_contrato;
    
    -- Generar ID para el pago
    SELECT 'PAG'||LPAD(NVL(MAX(TO_NUMBER(SUBSTR(idPago, 4))), 0)+1, 3, '0')
    INTO v_id_pago FROM PAGOS_MEMBRESIA;
    
    -- Insertar el pago
    INSERT INTO PAGOS_MEMBRESIA (idPago, fechaPago, valorPago, estadoPago, metodoPago)
    VALUES (v_id_pago, SYSDATE, v_costo_plan, 'Completo', p_metodo_pago);
    
    -- Generar ID para la activación
    SELECT 'ACT'||LPAD(NVL(MAX(TO_NUMBER(SUBSTR(idActivacion, 4))), 0)+1, 3, '0')
    INTO v_id_activacion FROM ACTIVACIONES_MENSUALES;
    
    -- Insertar la activación mensual
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

DECLARE
    v_resultado VARCHAR2(200);
BEGIN
    sp_activar_membresia('CONT001', 'Tarjeta', v_resultado);
    DBMS_OUTPUT.PUT_LINE(v_resultado);
END;
/

