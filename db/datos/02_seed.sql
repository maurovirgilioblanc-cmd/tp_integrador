-- =====================================================
-- POPULACIÓN DE DATOS (SEED) CON RUTAS A PDFS REALES
-- =====================================================

INSERT INTO areas (nombre_area, codigo_interno) VALUES
('Operaciones e Ingeniería', 'ING-OPS'),
('Seguridad Higiene y Medio Ambiente', 'SHMA'),
('Mantenimiento Eléctrico', 'MANT-ELEC');

INSERT INTO categorias (nombre_categoria, descripcion) VALUES
('Manual Técnico', 'Manuales operativos de maquinaria e infraestructura'),
('Normativa Interna', 'Reglamentos y directivas de seguridad en planta'),
('Instructivo de Trabajo', 'Guías paso a paso para tareas específicas');

INSERT INTO usuarios (nombre, email, area_id, nivel_acceso) VALUES
('Mauro Blanc', 'mauro.blanc@empresa.com', 1, 'Tecnico_Avanzado'),
('Ana Gomez', 'ana.gomez@empresa.com', 2, 'Supervisor_SHMA'),
('Carlos Perez', 'carlos.perez@empresa.com', 3, 'Tecnico_Basico');

INSERT INTO documentos (titulo, estado, nivel_acceso_requerido, area_id, categoria_id) VALUES
('Manual Técnico: Turbinas de Gas Serie X100', 'vigente', 'Tecnico_Avanzado', 1, 1),
('Norma Interna de Seguridad en Planta', 'vigente', 'Tecnico_Basico', 2, 2),
('Instructivo Técnico: Rearmado de Tableros Eléctricos', 'vigente', 'Tecnico_Basico', 3, 3);

-- Rutas vinculadas directamente a la carpeta data/ejemplos/archivos_fuente/
INSERT INTO versiones_documento (documento_id, numero_version, url_archivo_origen, es_activa) VALUES
(1, '2.4', 'data/ejemplos/archivos_fuente/MN-TURB-001.pdf', true),
(2, '1.0', 'data/ejemplos/archivos_fuente/NR-SEG-015.pdf', true),
(3, '3.1', 'data/ejemplos/archivos_fuente/IT-ELEC-042.pdf', true);

INSERT INTO fragmentos (version_id, numero_secuencia, contenido_texto, metadatos) VALUES
(1, 1, 'En caso de detectar una vibración superior a los 4.5 mm/s en el eje principal de la turbina, el operador deberá iniciar el protocolo de parada de emergencia inmediata. No se debe intentar un reinicio manual sin antes purgar el sistema de combustible.', '{"seccion": "4", "pagina_pdf": 1}'),
(1, 2, 'El cambio de filtros de aceite de la caja reductora debe realizarse cada 1.500 horas de operación continua o cada 6 meses, lo que ocurra primero.', '{"seccion": "5", "pagina_pdf": 1}'),
(2, 1, 'Es obligatorio el uso de casco de protección auditiva de doble copa (mínimo 28 dB de atenuación) para todo personal que ingrese a la sala de compresores y turbinas.', '{"seccion": "1", "pagina_pdf": 1}'),
(3, 1, 'Antes de intervenir cualquier interruptor principal de media tensión, se debe aplicar el candado personal de bloqueo y verificar la ausencia de tensión con un multímetro calibrado.', '{"seccion": "2", "pagina_pdf": 1}');
