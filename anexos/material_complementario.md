# Anexo Técnico y Material Complementario

**Proyecto:** Sistema RAG para Consulta de Documentación Técnica  
**Integrantes:** Andrea Ferenaz, Mauro Virgilio Blanc, Juan Pablo Imbrogno  

---

## 1. Justificación de Decisiones de Arquitectura

### 1.1 ¿Por qué PostgreSQL + pgvector frente a una Vector DB dedicada?
Para este proyecto se evaluó el uso de bases de datos vectoriales nativas (como Pinecone, Qdrant o ChromaDB) versus la extensión `pgvector` en PostgreSQL. Se optó por **PostgreSQL + pgvector** debido a:
* **Consistencia ACID:** Permite actualizar documentos y sus embeddings dentro de la misma transacción.
* **Consultas Híbridas Atómicas:** Se pueden aplicar filtros relacionales duros (`area_id`, `nivel_acceso`, `estado = 'vigente'`) en la misma consulta SQL que la búsqueda por distancia coseno, garantizando seguridad y rendimiento sin desincronización de índices.
* **Simplicidad Operativa:** Mantiene la infraestructura en un solo motor de base de datos conocido y robusto.

### 1.2 Estrategia de Fragmentación (Chunking)
* **Tamaño de ventana:** 512 tokens (~1500 a 2000 caracteres) con un solapamiento (*overlap*) del 10% (50 tokens).
* **Metadatos adjuntos por Chunk:** Se extrae dinámicamente la página del PDF, sección y encabezado para almacenarlos en la columna `metadatos` (JSONB).

---

## 2. Prompts de Prueba del Sistema RAG

### Prompt del Sistema (System Prompt)
```text
Sos un asistente técnico experto en normativa e instructivos de planta.
Tu objetivo es responder únicamente basándote en los fragmentos de contexto provistos.
Si la información no está en el contexto, respondé: "No dispongo de información en la documentación autorizada para responder esta consulta."
Citá siempre el documento y la página de origen.
