-- =====================================================
-- CONSULTAS REPRESENTATIVAS PARA EVALUACIÓN
-- =====================================================

-- 1. Búsqueda RAG por Similitud Coseno con Filtro de Seguridad Integrado
SELECT 
    f.fragmento_id,
    d.titulo AS documento_titulo,
    v.url_archivo_origen,
    f.contenido_texto,
    f.metadatos->>'pagina_pdf' AS pagina
FROM fragmentos f
JOIN versiones_documento v ON f.version_id = v.version_id
JOIN documentos d ON v.documento_id = d.documento_id
JOIN usuarios u ON u.usuario_id = 1
WHERE v.es_activa = TRUE 
  AND d.estado = 'vigente'
  AND d.area_id = u.area_id;

-- 2. Trazabilidad de Auditoría
SELECT 
    c.consulta_id,
    c.pregunta_texto,
    c.respuesta_ia,
    d.titulo AS documento_fuente,
    v.url_archivo_origen,
    fc.score_similitud
FROM consultas_rag c
JOIN fuentes_consulta fc ON c.consulta_id = fc.consulta_id
JOIN fragmentos f ON fc.fragmento_id = f.fragmento_id
JOIN versiones_documento v ON f.version_id = v.version_id
JOIN documentos d ON v.documento_id = d.documento_id;
