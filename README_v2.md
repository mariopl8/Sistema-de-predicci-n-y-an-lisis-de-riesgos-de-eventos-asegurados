<div align="center">

# Sistema de Predicción y Análisis de Riesgos de Eventos Asegurados

[![Java](https://img.shields.io/badge/Java-Swing-ED8B00?style=flat-square&logo=openjdk&logoColor=white)](https://www.java.com/)
[![MySQL](https://img.shields.io/badge/MariaDB-10.4-003545?style=flat-square&logo=mariadb&logoColor=white)](https://mariadb.org/)
[![JDBC](https://img.shields.io/badge/Conectividad-JDBC-007396?style=flat-square)](https://docs.oracle.com/javase/tutorial/jdbc/)
[![XAMPP](https://img.shields.io/badge/Entorno-XAMPP-FB7A24?style=flat-square&logo=apache&logoColor=white)](https://www.apachefriends.org/)
[![Licencia MIT](https://img.shields.io/badge/Licencia-MIT-green?style=flat-square)](LICENSE)

*Aplicación de escritorio para la automatización de análisis actuarial y gestión de siniestros en la industria aseguradora.*

</div>

---

## Descripción General

Este sistema es una **aplicación de escritorio integral** orientada a la industria de seguros. Su objetivo es automatizar el registro, la consulta y el análisis de riesgos sobre bienes y clientes asegurados.

El núcleo del proyecto combina el desarrollo de software con la **ciencia actuarial**, incorporando métodos matemáticos y consultas relacionales para calcular dinámicamente indicadores clave como el **riesgo esperado**, la **frecuencia** y la **severidad** de los siniestros. El sistema facilita la toma de decisiones estratégicas, la mitigación de pérdidas y la elaboración de reportes actuariales.

---

## Objetivos

| Objetivo | Descripción |
|---|---|
| **Automatización Actuarial** | Optimizar el cálculo manual de frecuencia y severidad de siniestros por tipo de riesgo. |
| **Gestión de Datos** | Administrar relacionalmente la información de aseguradoras, clientes, bienes y siniestros. |
| **Inteligencia de Negocio** | Generar reportes automáticos que identifiquen patrones de riesgo dominantes. |

---

## Tecnologías Utilizadas

| Capa | Tecnología | Propósito |
|---|---|---|
| **Backend / Lógica** | Java (JDK 11+) | Lógica de negocio y procesamiento actuarial |
| **Interfaz Gráfica** | Java Swing | Desarrollo de ventanas y formularios (GUI) |
| **Base de Datos** | MariaDB 10.4 / MySQL | Almacenamiento relacional (gestionado con XAMPP) |
| **Conectividad** | JDBC | Comunicación en tiempo real entre Java y la BD |
| **Administración** | phpMyAdmin 5.2 | Gestión visual del servidor de base de datos |

---

## Modelo de Base de Datos

La base de datos `Proyecto_final` se diseñó bajo una **arquitectura relacional** con integridad referencial completa mediante `ON DELETE CASCADE / ON UPDATE CASCADE`.

### Diagrama Entidad-Relación

```
┌────────────────────┐        ┌─────────────────────────────┐
│    aseguradoras    │        │          clientes            │
│────────────────────│        │─────────────────────────────│
│ PK idAseguradora   │        │ PK idCliente  VARCHAR(5)     │
│    nombre          │        │    nombre     VARCHAR(60)    │
│    contacto        │        │    fechaNac.  DATE           │
└─────────┬──────────┘        │    direccion  VARCHAR(120)   │
          │                   └──────────────┬──────────────┘
          │                                  │ 1
          │                                  │
          │                           ┌──────▼───────────────┐
          │                           │        bienes         │
          │                           │──────────────────────│
          │                           │ PK idBien  VARCHAR(8) │
          │                           │ FK idCliente          │
          │                           │    descripcion        │
          │                           │    valorAsegurado     │
          │                           │    tipoBien           │
          │                           └──────────┬───────────┘
          │                                      │
          │  ┌───────────────────────────────────▼────────────────────┐
          └──►              siniestros/eventos                         │
             │──────────────────────────────────────────────────────── │
             │ PK idSiniestro  VARCHAR(7)                              │
             │ FK idBien       VARCHAR(8)  → bienes                   │
             │ FK idRiesgo     VARCHAR(3)  → tiposRiesgo              │
             │ FK idAseguradora VARCHAR(3) → aseguradoras             │
             │    fecha        DATE                                    │
             │    monto        VARCHAR(10)                             │
             │    zona         VARCHAR(40)                             │
             │    descripcion  VARCHAR(100)                            │
             └─────────────────────────────┬──────────────────────────┘
                                           │ FK idRiesgo
                                    ┌──────▼──────────┐
                                    │   tiposRiesgo   │
                                    │─────────────────│
                                    │ PK idRiesgo     │
                                    │    nombreRiesgo │
                                    │    descripcion  │
                                    └─────────────────┘
```

### Estructura de Tablas

**`aseguradoras`** — 5 registros de ejemplo

| Campo | Tipo | Descripción |
|---|---|---|
| `idAseguradora` | `VARCHAR(3)` PK | Clave única (A01–A05) |
| `nombre` | `VARCHAR(60)` | Nombre comercial de la aseguradora |
| `contacto` | `VARCHAR(20)` | Número telefónico de contacto |

> Ejemplos: *Seguros Norte*, *Solidez MX*, *Mega Seguros*

---

**`clientes`** — 5 registros de ejemplo

| Campo | Tipo | Descripción |
|---|---|---|
| `idCliente` | `VARCHAR(5)` PK | Clave única (C001–C005) |
| `nombre` | `VARCHAR(60)` | Nombre completo del asegurado |
| `fechaNacimiento` | `DATE` | Fecha de nacimiento |
| `direccion` | `VARCHAR(120)` | Domicilio del cliente |

---

**`bienes`** — 10 registros de ejemplo

| Campo | Tipo | Descripción |
|---|---|---|
| `idBien` | `VARCHAR(8)` PK | Clave única (B0000001–B0000010) |
| `idCliente` | `VARCHAR(5)` FK | Dueño del bien |
| `descripcion` | `VARCHAR(100)` | Descripción del bien asegurado |
| `valorAsegurado` | `VARCHAR(10)` | Valor declarado para cobertura |
| `tipoBien` | `VARCHAR(40)` | Categoría: Auto, Casa, Negocio, Moto, Departamento |

---

**`tiposRiesgo`** — 5 coberturas registradas

| `idRiesgo` | `nombreRiesgo` | Descripción |
|---|---|---|
| R01 | Incendio | Daños por fuego |
| R02 | Robo | Pérdida por robo |
| R03 | Accidente | Daños por accidente automovilístico |
| R04 | Inundación | Daños por agua |
| R05 | Vandalismo | Daños materiales por actos vandálicos |

---

**`siniestros/eventos`** — Tabla transaccional central (19 registros de ejemplo)

| Campo | Tipo | Descripción |
|---|---|---|
| `idSiniestro` | `VARCHAR(7)` PK | Identificador del evento (S000001…) |
| `idBien` | `VARCHAR(8)` FK | Bien afectado |
| `idRiesgo` | `VARCHAR(3)` FK | Tipo de cobertura activada |
| `idAseguradora` | `VARCHAR(3)` FK | Aseguradora responsable |
| `fecha` | `DATE` | Fecha del siniestro |
| `monto` | `VARCHAR(10)` | Monto del siniestro |
| `zona` | `VARCHAR(40)` | Zona geográfica del evento |
| `descripcion` | `VARCHAR(100)` | Detalle del evento |

> **Nota técnica:** Los campos `valorAsegurado` y `monto` se almacenan como `VARCHAR` y se castean a `DECIMAL(10,2)` en las consultas actuariales para garantizar precisión financiera.

---

## Lógica Actuarial — Queries del Sistema

### 1. Riesgos Dominantes por Tipo de Bien

Identifica qué cobertura genera mayor siniestralidad según la categoría del bien (p. ej., 'Casa').

```sql
SELECT
    tr.nombreRiesgo,
    COUNT(*) AS numero_siniestros
FROM `siniestros/eventos` s
JOIN bienes      b  ON s.idBien   = b.idBien
JOIN tiposRiesgo tr ON s.idRiesgo = tr.idRiesgo
WHERE b.tipoBien = 'Casa'
GROUP BY tr.nombreRiesgo
ORDER BY numero_siniestros DESC;
```

### 2. Cuadro de Mando Actuarial — Frecuencia, Severidad y Riesgo Esperado

Automatiza la fórmula fundamental de la **Teoría del Riesgo**:

$$\text{Riesgo Esperado} = \text{Frecuencia} \times \text{Severidad Promedio}$$

```sql
SELECT
    tr.nombreRiesgo AS Riesgo,

    -- Frecuencia relativa: siniestros del riesgo / total de siniestros
    ROUND(
        COUNT(s.idSiniestro) / (SELECT COUNT(*) FROM `siniestros/eventos`),
        4
    ) AS Frecuencia,

    -- Severidad promedio: impacto económico promedio por evento
    ROUND(
        AVG(CAST(s.monto AS DECIMAL(10,2))),
        2
    ) AS Severidad_Promedio,

    -- Riesgo Esperado = Frecuencia × Severidad Promedio
    ROUND(
        (COUNT(s.idSiniestro) / (SELECT COUNT(*) FROM `siniestros/eventos`))
        * AVG(CAST(s.monto AS DECIMAL(10,2))),
        2
    ) AS Riesgo_Esperado

FROM `siniestros/eventos` s
JOIN tiposRiesgo tr ON s.idRiesgo = tr.idRiesgo
GROUP BY tr.idRiesgo, tr.nombreRiesgo
ORDER BY Riesgo_Esperado DESC;
```

### 3. Aseguradora con Mayor Siniestralidad

```sql
SELECT
    a.nombre AS Aseguradora,
    COUNT(s.idSiniestro) AS total_siniestros,
    SUM(CAST(s.monto AS DECIMAL(10,2))) AS monto_total
FROM `siniestros/eventos` s
JOIN aseguradoras a ON s.idAseguradora = a.idAseguradora
GROUP BY a.idAseguradora, a.nombre
ORDER BY total_siniestros DESC
LIMIT 1;
```

---

## Módulos de la Interfaz (GUI)

La aplicación cuenta con una interfaz gráfica modular desarrollada en **Java Swing**:

1. **Menú Principal** — Panel central de navegación interactivo hacia todos los módulos.
2. **Módulo de Consulta** — Tablas dinámicas (`JTable`) conectadas en tiempo real a la base de datos; muestra Clientes, Bienes, Aseguradoras y Siniestros.
3. **Módulo de Reportes Analíticos** — Ejecuta las consultas actuariales agregadas y presenta alertas de alto impacto (p. ej., aseguradora con más siniestros) mediante cuadros de diálogo (`JOptionPane`).
4. **Módulo de Registro Inteligente** — Formulario con validación lógica para capturar nuevos eventos. Evalúa si el bien ya existe para el cliente (reutilización) o genera dinámicamente un nuevo `idBien` secuencial para mantener la integridad referencial.

---

## Instalación y Configuración

### Prerrequisitos

- [JDK 11+](https://adoptium.net/)
- [XAMPP](https://www.apachefriends.org/) con **Apache** y **MySQL/MariaDB** activos
- IDE Java: IntelliJ IDEA, Eclipse o NetBeans
- [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/) (driver JDBC)

### Pasos

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/tu-usuario/sistema-riesgos-seguros.git
   cd sistema-riesgos-seguros
   ```

2. **Importar la base de datos**  
   Abre phpMyAdmin → crea la base `Proyecto_final` → importa `database/Proyecto_final-2.sql`.

3. **Configurar la conexión JDBC**  
   Edita `src/config/DatabaseConfig.java`:
   ```java
   private static final String URL  = "jdbc:mysql://localhost:3306/Proyecto_final";
   private static final String USER = "root";
   private static final String PASS = "";   // ajusta según tu entorno XAMPP
   ```
   > ⚠️ El nombre de la tabla `siniestros/eventos` contiene una barra diagonal. Siempre escápala con backticks en las consultas: `` `siniestros/eventos` ``

4. **Agregar el driver JDBC al classpath**  
   Incluye `mysql-connector-j-x.x.x.jar` en las dependencias del proyecto (Build Path en Eclipse / Libraries en IntelliJ).

5. **Compilar y ejecutar**  
   Lanza la clase principal `Main.java` desde tu IDE.

---

## ⚠️ Consideraciones Técnicas

- **Nombre de tabla con `/`:** La tabla `siniestros/eventos` requiere backticks en cada consulta SQL. Si el proyecto escala, se recomienda renombrarla a `siniestros_eventos` para mayor compatibilidad.
- **Tipos de datos numéricos:** `valorAsegurado` y `monto` se definen como `VARCHAR` en el esquema actual. Para producción se recomienda migrarlos a `DECIMAL(12,2)` y eliminar el `CAST` en cada query.
- **Motor de BD:** El dump fue generado en **MariaDB 10.4** (incluido en XAMPP). Es compatible con MySQL 8.0 con mínimas diferencias de sintaxis.

---

## Competencias Demostradas

- **Diseño Relacional** — Normalización, integridad referencial (`CASCADE`), índices compuestos y claves foráneas múltiples.
- **Pensamiento Actuarial Aplicado** — Traducción de los modelos de frecuencia-severidad a queries SQL automatizadas y funcionales.
- **Desarrollo OO en Java** — Arquitectura por capas, persistencia JDBC y diseño de GUI con Swing.
- **Análisis de Datos** — Consultas con `JOIN`, `GROUP BY`, subconsultas correlacionadas y funciones de agregación financiera.

---

## Licencia

Distribuido bajo la licencia **MIT**. Consulta el archivo [`LICENSE`](LICENSE) para más detalles.

---

<div align="center">
  Desarrollado por <strong>Mario Pérez</strong> · Ciencias Actuariales · CDMX
</div>
