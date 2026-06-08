<div align="center">

# 🛡️ Sistema de Predicción y Análisis de Riesgos de Eventos Asegurados

[![Java](https://img.shields.io/badge/Java-Swing-ED8B00?style=flat-square&logo=openjdk&logoColor=white)](https://www.java.com/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat-square&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![JDBC](https://img.shields.io/badge/Conectividad-JDBC-007396?style=flat-square)](https://docs.oracle.com/javase/tutorial/jdbc/)
[![XAMPP](https://img.shields.io/badge/Entorno-XAMPP-FB7A24?style=flat-square&logo=apache&logoColor=white)](https://www.apachefriends.org/)
[![Licencia MIT](https://img.shields.io/badge/Licencia-MIT-green?style=flat-square)](LICENSE)

*Aplicación de escritorio para la automatización de análisis actuarial y gestión de siniestros en la industria aseguradora.*

</div>

---

## 📋 Descripción General

Este sistema es una **aplicación de escritorio integral** orientada a la industria de seguros. Su objetivo principal es automatizar el registro, la consulta y el análisis de riesgos sobre bienes y clientes asegurados.

El núcleo del proyecto combina el desarrollo de software con la **ciencia actuarial**, incorporando métodos matemáticos y consultas relacionales para calcular dinámicamente indicadores clave como el **riesgo esperado**, la **frecuencia** y la **severidad** de los siniestros. El sistema facilita la toma de decisiones estratégicas, la mitigación de pérdidas y la elaboración de reportes actuariales.

---

## 🎯 Objetivos

| Objetivo | Descripción |
|---|---|
| **Automatización Actuarial** | Optimizar el cálculo manual de frecuencia y severidad de siniestros por tipo de riesgo. |
| **Gestión de Datos** | Administrar de forma relacional y consistente la información de aseguradoras, clientes, bienes y siniestros. |
| **Inteligencia de Negocio** | Generar reportes automáticos basados en consultas complejas para identificar patrones de riesgo dominantes. |

---

## 🛠️ Tecnologías Utilizadas

| Capa | Tecnología | Propósito |
|---|---|---|
| **Backend / Lógica** | Java (JDK 11+) | Lógica de negocio y procesamiento actuarial |
| **Interfaz Gráfica** | Java Swing | Desarrollo de ventanas y formularios (GUI) |
| **Base de Datos** | MySQL 8.0 | Almacenamiento relacional de datos |
| **Conectividad** | JDBC | Comunicación en tiempo real entre Java y MySQL |
| **Entorno Local** | XAMPP + phpMyAdmin | Administración del servidor de base de datos |

---

## 🗄️ Modelo de Base de Datos

La base de datos se diseñó bajo una **arquitectura relacional sólida**, implementando restricciones de integridad mediante claves primarias (`PK`) y claves foráneas (`FK`) para modelar con precisión las entidades del negocio asegurador.

### Diagrama Entidad-Relación (simplificado)

```
┌─────────────┐       ┌──────────────┐       ┌───────────────┐
│ aseguradoras│       │   clientes   │       │  tiposRiesgo  │
│─────────────│       │──────────────│       │───────────────│
│ PK idAseg.  │       │ PK idCliente │       │ PK idRiesgo   │
│ nombre      │       │ nombre       │       │ nombreRiesgo  │
│ ...         │       │ ...          │       │ ...           │
└──────┬──────┘       └──────┬───────┘       └───────┬───────┘
       │                     │                       │
       │              ┌──────▼───────┐               │
       │              │    bienes    │               │
       │              │──────────────│               │
       │              │ PK idBien    │               │
       │              │ FK idCliente │               │
       │              │ tipoBien     │               │
       │              │ valorAseg.   │               │
       │              └──────┬───────┘               │
       │                     │                       │
       │              ┌──────▼───────────────────────▼──────┐
       └──────────────►         siniestros / eventos         │
                      │──────────────────────────────────────│
                      │ PK idSiniestro                       │
                      │ FK idBien   · FK idRiesgo            │
                      │ FK idAseguradora                     │
                      │ monto       · fecha                  │
                      └──────────────────────────────────────┘
```

### Entidades Principales

| Tabla | PK | FK | Descripción |
|---|---|---|---|
| `aseguradoras` | `idAseguradora` | — | Compañías que emiten las pólizas. |
| `clientes` | `idCliente` | — | Personas físicas o morales aseguradas. |
| `bienes` | `idBien` | `idCliente` | Objetos protegidos (viviendas, autos, etc.) vinculados a su dueño. |
| `tiposRiesgo` | `idRiesgo` | — | Catálogo de coberturas (Incendio, Robo, Inundación, etc.). |
| `siniestros` | `idSiniestro` | `idBien`, `idRiesgo`, `idAseguradora` | Tabla transaccional central; registra cada evento ocurrido. |

---

## 📊 Lógica Actuarial — Queries Destacadas

El sistema procesa consultas complejas de **agregación**, **uniones** (`JOIN`) y **agrupaciones** (`GROUP BY`) para resolver preguntas de negocio críticas.

### 1. Análisis de Riesgos Dominantes por Tipo de Bien

Identifica estadísticamente qué coberturas experimentan mayor siniestralidad según la naturaleza del bien asegurado.

```sql
SELECT
    tr.nombreRiesgo,
    COUNT(*) AS numero_siniestros
FROM siniestros s
JOIN bienes       b  ON s.idBien    = b.idBien
JOIN tiposRiesgo  tr ON s.idRiesgo  = tr.idRiesgo
WHERE b.tipoBien = 'Casa'
GROUP BY tr.nombreRiesgo
ORDER BY numero_siniestros DESC;
```

### 2. Cuadro de Mando Actuarial — Frecuencia, Severidad y Riesgo Esperado

Automatiza en el backend una de las fórmulas fundamentales de la **Teoría del Riesgo**:

$$\text{Riesgo Esperado} = \text{Frecuencia} \times \text{Severidad Promedio}$$

```sql
SELECT
    tr.nombreRiesgo AS Riesgo,

    -- Frecuencia relativa: siniestros del riesgo / total de siniestros
    (COUNT(s.idSiniestro) /
        (SELECT COUNT(*) FROM siniestros)) AS Frecuencia,

    -- Severidad promedio: impacto monetario promedio
    AVG(CAST(s.monto AS DECIMAL(10,2))) AS Severidad_Promedio,

    -- Riesgo Esperado = Frecuencia × Severidad Promedio
    ((COUNT(s.idSiniestro) /
        (SELECT COUNT(*) FROM siniestros))
      * AVG(CAST(s.monto AS DECIMAL(10,2)))) AS Riesgo_Esperado

FROM siniestros s
JOIN tiposRiesgo tr ON s.idRiesgo = tr.idRiesgo
GROUP BY tr.idRiesgo, tr.nombreRiesgo
ORDER BY Riesgo_Esperado DESC;
```

---

## 🖥️ Módulos de la Interfaz (GUI)

La aplicación cuenta con una interfaz gráfica modular diseñada para perfiles analíticos y operativos del sector asegurador:

1. **Menú Principal** — Panel central de navegación interactivo hacia todos los módulos.
2. **Módulo de Consulta** — Tablas dinámicas (`JTable`) conectadas a la base de datos que reflejan en tiempo real la información de Clientes, Bienes, Aseguradoras y Siniestros.
3. **Módulo de Reportes Analíticos** — Ejecuta las consultas actuariales agregadas y presenta alertas de siniestralidad de alto impacto (p. ej., la aseguradora con más siniestros registrados) mediante cuadros de diálogo (`JOptionPane`).
4. **Módulo de Registro Inteligente** — Formulario con validación lógica para capturar nuevos eventos asegurados. Evalúa si el bien ya existe para un cliente (reutilización) o genera un nuevo identificador secuencial para mantener la integridad referencial.

---

## 🚀 Instalación y Configuración

### Prerrequisitos

- [JDK 11+](https://adoptium.net/)
- [XAMPP](https://www.apachefriends.org/) con MySQL activo
- IDE Java (IntelliJ IDEA, Eclipse o NetBeans)
- Conector [MySQL JDBC Driver](https://dev.mysql.com/downloads/connector/j/)

### Pasos

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/tu-usuario/sistema-riesgos-seguros.git
   cd sistema-riesgos-seguros
   ```

2. **Importar la base de datos**  
   Abre phpMyAdmin, crea una base de datos llamada `seguros_db` e importa el archivo `database/schema.sql`.

3. **Configurar la conexión JDBC**  
   Edita el archivo `src/config/DatabaseConfig.java` con tus credenciales:
   ```java
   private static final String URL  = "jdbc:mysql://localhost:3306/seguros_db";
   private static final String USER = "root";
   private static final String PASS = "";
   ```

4. **Agregar el conector JDBC al classpath**  
   Incluye `mysql-connector-j-x.x.x.jar` en las dependencias del proyecto.

5. **Compilar y ejecutar**  
   Ejecuta la clase principal `Main.java` desde tu IDE.

---

## 🧠 Conclusiones del Desarrollo

Este proyecto demuestra habilidades sólidas y transversales en:

- **Diseño e Integridad de Bases de Datos Relacionales** — Estructuración robusta, normalización y aplicación de restricciones de integridad referencial.
- **Pensamiento Actuarial Aplicado** — Capacidad de traducir modelos cuantitativos teóricos (frecuencia, severidad, riesgo esperado) en soluciones de software automatizadas y funcionales.
- **Desarrollo de Software Orientado a Objetos** — Dominio de la arquitectura OO en Java, manejo de persistencia (JDBC) y diseño de interfaces de usuario con Swing.

---

## 📄 Licencia

Distribuido bajo la licencia **MIT**. Consulta el archivo [`LICENSE`](LICENSE) para más detalles.

---

<div align="center">
  Desarrollado por <strong>Mario Pérez</strong> · Ciencias Actuariales
</div>
