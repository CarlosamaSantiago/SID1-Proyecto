--Consultas:


--#1
-- Lista de clientes con Contrato vigente, incluyendo su tipo de plan y fecha de vencimiento, incluyendo los días restantes
-- Consulta de datos desde la base de datos
SELECT c.idCliente, c.nombreCliente, pe.objetivoPlan AS tipoPlan, ct.fechaCierre AS fechaVencimiento, (ct.fechaCierre - TRUNC(SYSDATE)) AS dias_restantes,
CASE
WHEN (ct.fechaCierre - TRUNC(SYSDATE)) <= 7 THEN 'Vence Pronto'
WHEN (ct.fechaCierre - TRUNC(SYSDATE)) <= 30 THEN 'Vence este Mes'
ELSE 'Vigente'
END AS estado_membresía
FROM CLIENTES c
JOIN CONTRATOS ct ON c.idCliente = ct.idCliente
JOIN PLANES_ENTRENAMIENTO pe ON ct.idPlan = pe.idPlan
WHERE TRUNC(SYSDATE) BETWEEN ct.fechaInicio AND ct.fechaCierre
ORDER BY dias_restantes ASC;


--#2
-- Registro de los implementos a los cuales no se les hace mantenimiento desde hace más de un mes incluyendo información del tiempo que llevan sin mantenimiento
-- Consulta de datos desde la base de datos
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

--#3
-- Recepcionista que más vende junto a su cantidad
-- Consulta de datos desde la base de datos
SELECT r.idRecepcionista, r.nombreRecepcionista AS nombre_completo, COUNT(v.idVenta) AS total_ventas
FROM VENTAS v
JOIN RECEPCIONISTAS r ON v.idRecepcionista = r.idRecepcionista
GROUP BY r.idRecepcionista, r.nombreRecepcionista
ORDER BY total_ventas DESC
FETCH FIRST 1 ROWS ONLY;

--#4
-- Ingresos del último mes
-- Consulta de datos desde la base de datos
SELECT SUM(p.precioProducto * pv.cantidadTotal) AS ingresos_ultimo_mes
FROM VENTAS v
JOIN PRODUCTOS_VENDIDOS pv ON v.idVenta = pv.idVenta
JOIN PRODUCTOS p ON pv.idProducto = p.idProducto
WHERE TO_DATE(v.fechaVenta, 'DD/MM/YYYY') >= ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -1)
  AND TO_DATE(v.fechaVenta, 'DD/MM/YYYY') < TRUNC(SYSDATE, 'MM');

--#5
-- Lista los productos más vendidos, agrupados por categoría y cantidad total vendida. 
-- Consulta de datos desde la base de datos
SELECT p.descripcionProducto AS categoria, p.nombreProducto AS producto, SUM(pv.cantidadTotal) AS cantidad_total_vendida, SUM(pv.cantidadTotal * p.precioProducto) AS ingresos_totales
FROM PRODUCTOS_VENDIDOS pv
JOIN PRODUCTOS p ON pv.idProducto = p.idProducto
JOIN VENTAS v ON pv.idVenta = v.idVenta
GROUP BY p.descripcionProducto, p.nombreProducto
ORDER BY cantidad_total_vendida DESC;

--#6
-- contabilizar las ventas realizadas por cada recepcionista junto con el precio total
-- Consulta de datos desde la base de datos
SELECT r.idRecepcionista, r.nombreRecepcionista, COUNT(v.idVenta) AS cantidad_ventas, SUM(p.precioProducto * pv.cantidadTotal) AS total_ingresos
FROM RECEPCIONISTAS r
JOIN VENTAS v ON r.idRecepcionista = v.idRecepcionista
JOIN PRODUCTOS_VENDIDOS pv ON v.idVenta = pv.idVenta
JOIN PRODUCTOS p ON pv.idProducto = p.idProducto
GROUP BY r.idRecepcionista, r.nombreRecepcionista
ORDER BY total_ingresos DESC;

--#6
-- evolución del peso de cada cliente entre su primera y última evaluación física
-- Uso de CTE (Common Table Expression) para estructurar consultas complejas
WITH EvaluacionesOrdenadas AS (
-- Consulta de datos desde la base de datos
SELECT ef.idCliente, c.nombreCliente, ef.fechaEvaluacion, ef.peso, ROW_NUMBER() OVER (PARTITION BY ef.idCliente ORDER BY ef.fechaEvaluacion ASC) AS primera_evaluacion, ROW_NUMBER() OVER (PARTITION BY ef.idCliente ORDER BY ef.fechaEvaluacion DESC) AS ultima_evaluacion
FROM EVALUACIONES_FISICAS ef
JOIN CLIENTES c ON ef.idCliente = c.idCliente
)
-- Consulta de datos desde la base de datos
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
