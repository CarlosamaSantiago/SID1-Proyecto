-- Creación Base De Datos CAF
-- DDL
-- Eliminar tablas en orden inverso a su creación (primero las más dependientes)
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE ACTIVACIONES_MENSUALES;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE ASISTENCIAS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE MANTENIMIENTOS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE EVALUACIONES_FISICAS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE PRODUCTOS_VENDIDOS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE PRODUCTOS_SURTIDOS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE CONTRATOS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE PAGOS_MEMBRESIA;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE VENTAS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE PEDIDOS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE IMPLEMENTOS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE PLANES_ENTRENAMIENTO;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE RECEPCIONISTAS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE TECNICOS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE ENTRENADORES;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE PRODUCTOS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE PROVEEDORES;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE CLIENTES CASCADE CONSTRAINTS;
-- Eliminación de tabla si existe para evitar duplicidad en la creación
DROP TABLE HORARIOS_RECEPCIONISTAS;

-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE HORARIOS_RECEPCIONISTAS(
    idHorario VARCHAR2(10 CHAR) NOT NULL,
    horaInicio VARCHAR2(5 CHAR) NOT NULL,
    horaFinal VARCHAR2(5 CHAR) NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE HORARIOS_RECEPCIONISTAS
    ADD CONSTRAINT HORARIOS_RECEPCIONISTAS_PK PRIMARY KEY (idHorario);

-- Crear tabla CLIENTES
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE CLIENTES (
    idCliente VARCHAR2(10 CHAR) NOT NULL,
    nombreCliente VARCHAR2(30 CHAR) NOT NULL,
    telefonoCliente VARCHAR2(10 CHAR) NOT NULL,
    correoCliente VARCHAR2(30 CHAR) NOT NULL,
    sexoCliente VARCHAR2(9 CHAR) NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE CLIENTES
    ADD CONSTRAINT CLIENTE_PK PRIMARY KEY (idCliente);
-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE CLIENTES
ADD CONSTRAINT chk_genero CHECK (sexoCliente IN ('MASCULINO', 'FEMENINO'));


-- Crear tabla PROVEEDORES
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE PROVEEDORES (
    idProveedor VARCHAR2(10 CHAR) NOT NULL,
    condicionesDePago VARCHAR2(30 CHAR) NOT NULL,
    telefonoProveedor VARCHAR2(30 CHAR) NOT NULL,
    correoProveedor VARCHAR2(30 CHAR) NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PROVEEDORES
    ADD CONSTRAINT PROVEEDOR_PK PRIMARY KEY (idProveedor);

-- Crear tabla PRODUCTOS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE PRODUCTOS (
    idProducto VARCHAR2(10) NOT NULL,
    precioProducto NUMBER NOT NULL,
    nombreProducto VARCHAR2(20 CHAR) NOT NULL,
    stock INTEGER NOT NULL,
    marcaProducto VARCHAR2(10),
    descripcionProducto VARCHAR2(10)
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PRODUCTOS
    ADD CONSTRAINT PRODUCTO_PK PRIMARY KEY (idProducto);

-- Crear tabla RECEPCIONISTAS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE RECEPCIONISTAS (
    idRecepcionista VARCHAR2(10 CHAR) NOT NULL,
    nombreRecepcionista VARCHAR2(30 CHAR) NOT NULL,
    horarioTrabajo VARCHAR2(10 CHAR) NOT NULL,
    salario INTEGER NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE RECEPCIONISTAS
    ADD CONSTRAINT RECEPCIONISTA_PK PRIMARY KEY (idRecepcionista);
-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE RECEPCIONISTAS
    ADD CONSTRAINT HORARIO_TRABAJO_FK FOREIGN KEY (horarioTrabajo)
        REFERENCES HORARIOS_RECEPCIONISTAS (idHorario);
    
-- Crear tabla ENTRENADORES
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE ENTRENADORES (
    idEntrenador VARCHAR2(10 CHAR) NOT NULL,
    nombreEntrenador VARCHAR2(30 CHAR) NOT NULL,
    reputacion INTEGER NOT NULL,
    costoHora NUMBER NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE ENTRENADORES
    ADD CONSTRAINT ENTRENADOR_PK PRIMARY KEY (idEntrenador);

-- Crear tabla TECNICOS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE TECNICOS (
    idTecnico VARCHAR2(10 CHAR) NOT NULL,
    nombreTecnico VARCHAR2(10 CHAR) NOT NULL,
    costoHora NUMBER NOT NULL,
    tituloAcademico VARCHAR2(100 CHAR) NOT NULL,
    telefonoTecnico VARCHAR2(10 CHAR) NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE TECNICOS
    ADD CONSTRAINT TECNICO_PK PRIMARY KEY (idTecnico);
    
-- Crear tabla PLANES_ENTRENAMIENTO
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE PLANES_ENTRENAMIENTO (
    idPlan VARCHAR2(10 CHAR) NOT NULL ,
    objetivoPlan VARCHAR2(100 CHAR) NOT NULL,
    duracionPlan INTEGER NOT NULL,
    costoPlan NUMBER NOT NULL,
    observaciones VARCHAR2(100 CHAR)NOT NULL 
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PLANES_ENTRENAMIENTO
    ADD CONSTRAINT PLAN_ENTRENAMIENTO_PK PRIMARY KEY (idPlan);
    
-- Crear tabla IMPLEMENTOS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE IMPLEMENTOS (
    idImplemento VARCHAR2(10 CHAR) NOT NULL,
    nombreImplemento VARCHAR2(20) NOT NULL,
    inicioServicio DATE NOT NULL,
    finServicio DATE 
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE IMPLEMENTOS
    ADD CONSTRAINT IMPLEMENTO_PK PRIMARY KEY (idImplemento);
    
-- Crear tabla PEDIDOS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE PEDIDOS (
    idPedido VARCHAR2(10 CHAR) NOT NULL,
    fechaDePetición DATE NOT NULL,
    estadoPedido VARCHAR2(10 CHAR) NOT NULL,
    fechaEntrega DATE ,
    idProveedor VARCHAR2(10 CHAR)NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PEDIDOS
    ADD CONSTRAINT PEDIDO_PK PRIMARY KEY (idPedido);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PEDIDOS
    ADD CONSTRAINT PEDIDO_PROVEEDOR_FK FOREIGN KEY (idProveedor)
        REFERENCES PROVEEDORES (idProveedor);
-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PEDIDOS
ADD CONSTRAINT chk_estadoPedido CHECK (estadoPedido IN ('SOLICITADO', 'EN CAMINO', 'RECIBIDO'));

        
-- Crear tabla VENTAS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE VENTAS (
    idVenta VARCHAR2(10 CHAR) NOT NULL,
    fechaVenta DATE NOT NULL,
    idCliente VARCHAR2(10 CHAR) NOT NULL,
    idRecepcionista VARCHAR2(10 CHAR) NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE VENTAS
    ADD CONSTRAINT VENTA_PK PRIMARY KEY (idVenta);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE VENTAS
    ADD CONSTRAINT VENTA_CLIENTE_FK FOREIGN KEY (idCliente)
        REFERENCES CLIENTES (idCliente);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE VENTAS
    ADD CONSTRAINT VENTA_RECEPCIONISTA_FK FOREIGN KEY (idRecepcionista)
        REFERENCES RECEPCIONISTAS (idRecepcionista);
        
-- Crear tabla PAGOS_MEMBRESIA
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE PAGOS_MEMBRESIA (
    idPago VARCHAR2(10 CHAR) NOT NULL,
    fechaPago DATE NOT NULL, 
    valorPago NUMBER NOT NULL,
    estadoPago VARCHAR2(10 CHAR)NOT NULL,
    metodoPago VARCHAR2(10 CHAR)NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PAGOS_MEMBRESIA
    ADD CONSTRAINT PAGO_MEMBRESIA_PK PRIMARY KEY (idPago);
    
-- Crear tabla CONTRATOS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE CONTRATOS (
    idContrato VARCHAR2(10) NOT NULL,
    fechaInicio DATE NOT NULL, 
    fechaCierre DATE NOT NULL,
    idCliente VARCHAR2(10 CHAR) NOT NULL,
    idPlan VARCHAR2(10 CHAR) NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE CONTRATOS
    ADD CONSTRAINT CONTRATO_PK PRIMARY KEY (idContrato);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE CONTRATOS
    ADD CONSTRAINT CONTRATO_CLIENTE_FK FOREIGN KEY (idCliente)
        REFERENCES CLIENTES (idCliente);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE CONTRATOS
    ADD CONSTRAINT CONTRATO_PLAN_ENTRENAMIENTO_FK FOREIGN KEY (idPlan)
        REFERENCES PLANES_ENTRENAMIENTO (idPlan);
        
-- Crear tabla PRODUCTOS_SURTIDOS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE PRODUCTOS_SURTIDOS (
    idSurtidos VARCHAR2(10) NOT NULL,
    cantidadProducto INTEGER NOT NULL,
    idProducto VARCHAR2(10) NOT NULL,
    idPedido VARCHAR2(10 CHAR)NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PRODUCTOS_SURTIDOS
    ADD CONSTRAINT PRODUCTO_SURTIDO_PK PRIMARY KEY (idSurtidos);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PRODUCTOS_SURTIDOS
    ADD CONSTRAINT PRODUCTO_SURTIDO_PRODUCTO_FK FOREIGN KEY (idProducto)
        REFERENCES PRODUCTOS (idProducto);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PRODUCTOS_SURTIDOS
    ADD CONSTRAINT PRODUCTO_SURTIDO_PEDIDO_FK FOREIGN KEY (idPedido)
        REFERENCES PEDIDOS (idPedido);

-- Crear tabla PRODUCTOS_VENDIDOS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE PRODUCTOS_VENDIDOS (
    idVendidos VARCHAR2(10) NOT NULL,
    idVenta VARCHAR2(10 CHAR) NOT NULL,
    cantidadTotal INTEGER NOT NULL,
    idProducto VARCHAR2(10) NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PRODUCTOS_VENDIDOS
    ADD CONSTRAINT PRODUCTO_VENDIDO_PK PRIMARY KEY (idVendidos);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PRODUCTOS_VENDIDOS
    ADD CONSTRAINT PRODUCTO_VENDIDO_VENTA_FK FOREIGN KEY (idVenta)
        REFERENCES VENTAS (idVenta);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE PRODUCTOS_VENDIDOS
    ADD CONSTRAINT PRODUCTO_VENDIDO_PRODUCTO_FK FOREIGN KEY (idProducto)
        REFERENCES PRODUCTOS (idProducto);
        
-- Crear tabla EVALUACIONES_FISICAS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
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

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE EVALUACIONES_FISICAS
    ADD CONSTRAINT EVALUACION_FISICA_PK PRIMARY KEY (idEvaluación);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE EVALUACIONES_FISICAS
    ADD CONSTRAINT EVALUACION_FISICA_CLIENTE_FK FOREIGN KEY (idCliente)
        REFERENCES CLIENTES (idCliente);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE EVALUACIONES_FISICAS
    ADD CONSTRAINT EVALUACION_FISICA_ENTRENADOR_FK FOREIGN KEY (idEntrenador)
        REFERENCES ENTRENADORES (idEntrenador);

-- Crear tabla MANTENIMIENTOS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE MANTENIMIENTOS (
    idMantenimiento VARCHAR2(10 CHAR) NOT NULL,
    fechaMantenimiento DATE NOT NULL,
    observacionesMantenimiento VARCHAR2(100 CHAR),
    idImplemento VARCHAR2(10 CHAR)NOT NULL,
    idTecnico VARCHAR2(10 CHAR) NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE MANTENIMIENTOS
    ADD CONSTRAINT MANTENIMIENTO_PK PRIMARY KEY (idMantenimiento);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE MANTENIMIENTOS
    ADD CONSTRAINT MANTENIMIENTO_IMPLEMENTO_FK FOREIGN KEY (idImplemento)
        REFERENCES IMPLEMENTOS (idImplemento);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE MANTENIMIENTOS
    ADD CONSTRAINT MANTENIMIENTO_TECNICO_FK FOREIGN KEY (idTecnico)
        REFERENCES TECNICOS (idTecnico);

-- Crear tabla ASISTENCIAS
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE ASISTENCIAS (
    idAsistencia VARCHAR2(10 CHAR) NOT NULL ,
    fechaAsistencia DATE NOT NULL,
    horaLlegada DATE NOT NULL,
    horaSalida DATE,
    idCliente VARCHAR2(10 CHAR) NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE ASISTENCIAS
    ADD CONSTRAINT ASISTENCIA_PK PRIMARY KEY (idAsistencia);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE ASISTENCIAS
    ADD CONSTRAINT ASISTENCIA_CLIENTE_FK FOREIGN KEY (idCliente)
        REFERENCES CLIENTES (idCliente);
    
-- Crear tabla ACTIVACIONES_MENSUALES
-- ==============================================
-- Definición de una nueva tabla en la base de datos
CREATE TABLE ACTIVACIONES_MENSUALES (
    idActivacion VARCHAR2(10 CHAR) NOT NULL,
    idContrato VARCHAR2(10) NOT NULL,
    idPago VARCHAR2(10 CHAR) NOT NULL
);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE ACTIVACIONES_MENSUALES
    ADD CONSTRAINT ACTIVACION_MENSUAL_PK PRIMARY KEY (idActivacion);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE ACTIVACIONES_MENSUALES
    ADD CONSTRAINT ACTIVACION_MENSUAL_CONTRATO_FK FOREIGN KEY (idContrato)
        REFERENCES CONTRATOS (idContrato);

-- Alteración de una tabla existente para agregar restricciones o llaves foráneas
ALTER TABLE ACTIVACIONES_MENSUALES
    ADD CONSTRAINT ACTIVACION_MENSUAL_PAGO_MEMBRESIA_FK FOREIGN KEY (idPago)
        REFERENCES PAGOS_MEMBRESIA (idPago);
