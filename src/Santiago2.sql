------------------------------------------------------------
-- GPT ISERTIONS
------------------------------------------------------------


-- ... continúa hasta PE025 ...

INSERT INTO VENTAS VALUES ('V001', '2024-01-03', 'C002', 'R002');
INSERT INTO VENTAS VALUES ('V002', '2024-01-05', 'C003', 'R003');
INSERT INTO VENTAS VALUES ('V003', '2024-01-07', 'C004', 'R004');

INSERT INTO PRODUCTOS_VENDIDOS VALUES ('PV001', 'V002', 2, 'PR002');
INSERT INTO PRODUCTOS_VENDIDOS VALUES ('PV002', 'V003', 3, 'PR003');
INSERT INTO PRODUCTOS_VENDIDOS VALUES ('PV003', 'V004', 4, 'PR004');


-- ... continúa hasta V025 ...


INSERT INTO PAGOS_MEMBRESIA (idPago, fechaPago, valorPago, estadoPago, metodoPago) VALUES ('PM001', TO_DATE('2024-01-04', 'YYYY-MM-DD'), 51000, 'PENDIENTE', 'EFECTIVO');
INSERT INTO PAGOS_MEMBRESIA (idPago, fechaPago, valorPago, estadoPago, metodoPago) VALUES ('PM002', TO_DATE('2024-01-07', 'YYYY-MM-DD'), 52000, 'PAGADO', 'TARJETA');
INSERT INTO PAGOS_MEMBRESIA (idPago, fechaPago, valorPago, estadoPago, metodoPago) VALUES ('PM003', TO_DATE('2024-01-10', 'YYYY-MM-DD'), 53000, 'PENDIENTE', 'TRANSFERENCIA');
-- ... continúa hasta PM025 ...

INSERT INTO CONTRATOS (idContrato, fechaInicio, fechaCierre, idCliente, idPlan) VALUES ('CT001', TO_DATE('2024-01-06', 'YYYY-MM-DD'), TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'C002', 'PL002');
INSERT INTO CONTRATOS (idContrato, fechaInicio, fechaCierre, idCliente, idPlan) VALUES ('CT002', TO_DATE('2024-01-11', 'YYYY-MM-DD'), TO_DATE('2024-04-10', 'YYYY-MM-DD'), 'C003', 'PL003');
INSERT INTO CONTRATOS (idContrato, fechaInicio, fechaCierre, idCliente, idPlan) VALUES ('CT003', TO_DATE('2024-01-16', 'YYYY-MM-DD'), TO_DATE('2024-04-15', 'YYYY-MM-DD'), 'C004', 'PL004');
-- ... continúa hasta CT025 ...
INSERT INTO PRODUCTOS_SURTIDOS (idSurtidos, cantidadProducto, idProducto, idPedido) VALUES ('PS001', 6, 'PR002', 'PE002');
INSERT INTO PRODUCTOS_SURTIDOS (idSurtidos, cantidadProducto, idProducto, idPedido) VALUES ('PS002', 7, 'PR003', 'PE003');
INSERT INTO PRODUCTOS_SURTIDOS (idSurtidos, cantidadProducto, idProducto, idPedido) VALUES ('PS003', 8, 'PR004', 'PE004');
-- ... continúa hasta PS025 ...

-- ... continúa hasta PV025 ...

INSERT INTO EVALUACIONES_FISICAS (idEvaluación, fechaEvaluacion, peso, estatura, IMC, porcentajeGrasa, observaciones, idCliente, idEntrenador)
VALUES ('EV001', TO_DATE('2024-02-02', 'YYYY-MM-DD'), 60.5, 161, 23.34, 15.0, 'Buena forma 1', 'C002', 'E002');

INSERT INTO EVALUACIONES_FISICAS (idEvaluación, fechaEvaluacion, peso, estatura, IMC, porcentajeGrasa, observaciones, idCliente, idEntrenador)
VALUES ('EV002', TO_DATE('2024-02-03', 'YYYY-MM-DD'), 61.0, 162, 23.24, 15.5, 'Buena forma 2', 'C003', 'E003');

INSERT INTO EVALUACIONES_FISICAS (idEvaluación, fechaEvaluacion, peso, estatura, IMC, porcentajeGrasa, observaciones, idCliente, idEntrenador)
VALUES ('EV003', TO_DATE('2024-02-04', 'YYYY-MM-DD'), 61.5, 163, 23.13, 16.0, 'Buena forma 3', 'C004', 'E004');
-- ... hasta EV025 ...

INSERT INTO MANTENIMIENTOS (idMantenimiento, fechaMantenimiento, observacionesMantenimiento, idImplemento, idTecnico)
VALUES ('M001', TO_DATE('2024-03-02', 'YYYY-MM-DD'), 'Revisión 1', 'I002', 'T002');
-- ... hasta M025 ...

INSERT INTO ASISTENCIAS (idAsistencia, fechaAsistencia, horaLlegada, horaSalida, idCliente)
VALUES ('A001', TO_DATE('2024-03-16', 'YYYY-MM-DD'), TO_DATE('2024-03-16 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-03-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C002');
-- ... hasta A025 ...
INSERT INTO ACTIVACIONES_MENSUALES (idActivacion, idContrato, idPago)
VALUES ('AC001', 'CT002', 'PM002');
-- ... hasta AC025 ...















