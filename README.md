# Sistema de predicción y análisis de riesgos de eventos asegurados

## Descripción del Proyecto
Este sistema es una aplicación de escritorio integral orientada a la **industria de seguros**, diseñada con el objetivo de automatizar el registro, consulta y análisis de riesgos sobre bienes y clientes asegurados. 

El núcleo del proyecto combina el desarrollo de software con la **ciencia actuarial**, incorporando métodos matemáticos y consultas relacionales para calcular de forma dinámica indicadores clave como el **riesgo esperado de siniestros, la frecuencia y la severidad** de los eventos. El sistema procesa la información de manera ágil y confiable, facilitando la toma de decisiones estratégicas, la mitigación de pérdidas y la elaboración de reportes actuariales.

---

## Objetivos de Negocio y Técnicos
* **Automatización Actuarial:** Optimizar el cálculo manual de la frecuencia y severidad de siniestros por tipo de riesgo.
* **Gestión de Datos:** Administrar de forma relacional y consistente la información de aseguradoras, clientes, bienes y siniestros.
* **Inteligencia de Negocio:** Generar reportes automáticos basados en consultas complejas para identificar patrones de riesgo dominantes (ej. qué riesgos afectan más a un bien específico).

---

## Tecnologías Utilizadas
* **Lenguaje de Programación:** Java (utilizando Swing para el desarrollo de la interfaz gráfica y navegación por ventanas/Frames).
* **Base de Datos:** MySQL (gestionado mediante XAMPP y phpMyAdmin para la administración del entorno relacional).
* **Conectividad:** JDBC (Java Database Connectivity) para la comunicación en tiempo real y persistencia de datos.

---

## Modelo de Base de Datos (Estructura Relacional)
La base de datos se diseñó bajo una arquitectura relacional sólida, implementando restricciones de integridad mediante claves primarias (PK) y claves foráneas (FK) para modelar con precisión las entidades del negocio asegurador.

### Entidades Principales:
* **`aseguradoras`**: Registro de las compañías que emiten las pólizas. *(PK: idAseguradora)*.
* **`clientes`**: Información general de las personas aseguradas. *(PK: idCliente)*.
* **`bienes`**: Objetos protegidos (viviendas, autos, etc.) vinculados a su respectivo dueño. *(PK: idBien | FK: idCliente)*.
* **`tiposRiesgo`**: Catálogo de coberturas o eventos de riesgo (Incendio, Robo, Inundación, etc.). *(PK: idRiesgo)*.
* **`siniestros`**: Tabla transaccional central que concentra los eventos ocurridos. Relaciona qué bien fue afectado, bajo qué tipo de riesgo y con qué aseguradora mediante llaves foráneas. *(PK: idSiniestro | FK: idBien, idRiesgo, idAseguradora)*.


---

## Lógica Actuarial e Inteligencia de Datos (Queries Destacadas)

El sistema destaca por procesar consultas complejas de agregación, uniones (`JOIN`) y agrupaciones (`GROUP BY`) para resolver preguntas de negocio críticas:

### 1. Análisis de Riesgos Dominantes por Tipo de Bien
Permite identificar estadísticamente qué coberturas experimentan mayor siniestralidad según la naturaleza del bien (por ejemplo, para el tipo de bien 'Casa').
```sql
SELECT tr.nombreRiesgo, COUNT(*) AS numero_siniestros
FROM siniestros s
JOIN bienes b ON s.idBien = b.idBien
JOIN tiposRiesgo tr ON s.idRiesgo = tr.idRiesgo
WHERE b.tipoBien = 'Casa'
GROUP BY tr.nombreRiesgo
ORDER BY numero_siniestros DESC;

###2. Cuadro de Mando Actuarial (Frecuencia, Severidad y Riesgo Esperado)
Este módulo automatiza en el backend una de las fórmulas fundamentales de la teoría del riesgo:

Riesgo Esperado=Frecuencia×Severidad Promedio

La siguiente consulta calcula de manera consolidada las métricas actuariales para cada riesgo en el universo de la base de datos (haciendo un casteo numérico de los montos para un procesamiento financiero óptimo):
SELECT 
    tr.nombreRiesgo AS Riesgo,
    -- Frecuencia relativa: siniestros del riesgo / total de siniestros en la base
    (COUNT(s.idSiniestro) / (SELECT COUNT(*) FROM `siniestros/eventos`)) AS Frecuencia,
    -- Severidad promedio: promedio del impacto monetario de los siniestros de este riesgo
    AVG(CAST(s.monto AS DECIMAL(10,2))) AS Severidad_Promedio,
    -- Riesgo Esperado: Frecuencia * Severidad Promedio
    ((COUNT(s.idSiniestro) / (SELECT COUNT(*) FROM `siniestros/eventos`)) * AVG(CAST(s.monto AS DECIMAL(10,2)))) AS Riesgo_Esperado
FROM `siniestros/eventos` s
JOIN tiposRiesgo tr ON s.idRiesgo = tr.idRiesgo
GROUP BY tr.idRiesgo, tr.nombreRiesgo
ORDER BY Riesgo_Esperado DESC;

## Módulos de la Interfaz de Usuario (UI)
La aplicación cuenta con una interfaz gráfica modular diseñada para perfiles analíticos u operativos del sector asegurador:

1. **Menú Principal:** Panel central de navegación interactivo para acceder a los módulos.
2. **Módulo de Consulta:** Tablas dinámicas (`JTable`) conectadas a la base de datos que reflejan en tiempo real la información de Clientes, Bienes, Aseguradoras y Siniestros.
3. **Módulo de Reportes Analíticos:** Ventanas que ejecutan las consultas actuariales agregadas y presentan las alertas de siniestralidad de mayor impacto (ej. Aseguradora con más siniestros registrados) mediante cuadros de diálogo (`JOptionPane`).
4. **Módulo de Registro Inteligente:** Formulario con validación lógica de datos para capturar nuevos eventos asegurados. Cuenta con una función que evalúa si el bien ya existe para el cliente (lo reutiliza) o calcula de manera dinámica un nuevo identificador secuencial para mantener la integridad relacional de la base de datos.

---

##  Conclusiones del Desarrollo
Este proyecto demuestra habilidades sólidas y transversales en:
* **Diseño e Integridad de Bases de Datos Relacionales:** Estructuración robusta, normalización y aplicación de restricciones lógicas.
* **Pensamiento Actuarial Aplicado:** Capacidad de traducir modelos cuantitativos teóricos en soluciones de software automatizadas y funcionales para el negocio financiero.
* **Desarrollo de Software:** Dominio de la arquitectura orientada a objetos en Java, manejo de persistencia de datos (JDBC) y diseño de interfaces de usuario.


