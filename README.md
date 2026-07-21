# Sistema RAG para Consulta de Documentación Técnica

**Trabajo Práctico Integrador - Bases de Datos para Inteligencia Artificial**  
**Docente:** Martín Lacheski  
**Año:** 2026  

---

## 👥 Integrantes del Grupo
* Andrea Ferenaz
* Mauro Virgilio Blanc
* Juan Pablo Imbrogno

---

## 📌 Resumen del Proyecto
Este proyecto consiste en el diseño e implementación de la capa de datos para un sistema de **Generación Aumentada por Recuperación (RAG - *Retrieval-Augmented Generation*)**. La solución permite ingestar, organizar, fragmentar (*chunking*) y vectorizar documentación técnica interna (manuales de procedimiento, normas de seguridad e instructivos operativos) para ser consultada mediante Inteligencia Artificial (LLM) en lenguaje natural.

La arquitectura de datos implementa una **solución híbrida unificada utilizando PostgreSQL y la extensión `pgvector`**, lo que permite combinar la búsqueda vectorial semántica de baja latencia con el control relacional estricto de accesos por área, control de vigencia documental y trazabilidad completa de las fuentes utilizadas en cada respuesta.

---

## 🏗️ Alcance y Decisiones de Diseño Clave
* **Unificación Tecnológica (PostgreSQL + pgvector):** Evita la complejidad operacional de sincronizar dos bases de datos independientes (relacional + vectorial), permitiendo ejecutar la búsqueda por distancia coseno y los filtros relacionales en una sola consulta atómica.
* **Seguridad y Aislamiento por Área:** Implementación de filtrado obligatorio (`WHERE area_id = ...` / Row Level Security) para evitar la filtración de información confidencial entre áreas o roles.
* **Trazabilidad M:N (Auditoría RAG):** Registro explícito de la relación entre cada consulta realizada por el usuario, la respuesta de la IA y los fragmentos (*chunks*) y versiones exactas de los documentos fuente recuperados.
* **Manejo de Metadatos Semiestructurados:** Uso del tipo de dato `JSONB` para indexar metadatos cambiantes de cada fragmento (página de PDF, párrafo, sección) mediante índices GIN.

---

## 📂 Estructura del Repositorio
El repositorio sigue la organización solicitada por la cátedra:

```text
tp_integrador/
├── README.md                          # Presentación general del proyecto
├── docs/                              # Documentación técnica y diagramas
│   ├── informe.pdf                    # Informe técnico completo
│   ├── modelo_conceptual.png          # Diagrama Entidad-Relación (DER)
│   └── arquitectura.png               # Diagrama de arquitectura de datos
├── data/
│   └── ejemplos/                      # Datos estructurados en JSON y archivos fuente
│       ├── documentos.json
│       ├── fragmentos.json
│       ├── consultas.json
│       └── archivos_fuente/           # Documentos PDF reales de prueba
│           ├── MN-TURB-001.pdf
│           ├── NR-SEG-015.pdf
│           └── IT-ELEC-042.pdf
├── db/                                # Implementación relacional y vectorial en SQL
│   ├── estructura/
│   │   └── 01_schema.sql              # Creación de tablas, FKs y extensión pgvector
│   ├── datos/
│   │   └── 02_seed.sql                # Populación de datos de prueba (Seed)
│   ├── indices_vistas/
│   │   └── 03_indices.sql             # Índices vectoriales HNSW, GIN y B-Tree
│   └── consultas/
│       └── 04_consultas.sql           # 5 consultas representativas de evaluación
└── anexos/
    └── material_complementario.md
