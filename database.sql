-- Generado por Tecnopraxis — Diseñador de BD

CREATE TABLE `roles` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50),
  `descripcion` TEXT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `usuarios` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100),
  `email` VARCHAR(255),
  `password_hash` TEXT,
  `rol_id` INT,
  `estado` BOOLEAN,
  `verificado` BOOLEAN,
  `ultimo_acceso` TIMESTAMP,
  `creado_en` TIMESTAMP,
  `actualizado_en` TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_usuarios_username` (`username`)
);

CREATE TABLE `ciudadanos` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `usuario_id` BIGINT,
  `cedula` VARCHAR(20),
  `nombres` VARCHAR(150),
  `apellidos` VARCHAR(150),
  `fecha_nacimiento` DATE,
  `genero` VARCHAR(1),
  `direccion` TEXT,
  `parroquia` VARCHAR(100),
  `telefono` VARCHAR(20),
  `foto_perfil` TEXT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ciudadanos_usuario_id` (`usuario_id`),
  UNIQUE KEY `uq_ciudadanos_cedula` (`cedula`)
);

CREATE TABLE `empresas` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `usuario_id` BIGINT,
  `rif` VARCHAR(20),
  `razon_social` VARCHAR(255),
  `nombre_comercial` VARCHAR(255),
  `actividad_economica` TEXT,
  `direccion_fiscal` TEXT,
  `parroquia` VARCHAR(100),
  `telefono` VARCHAR(20),
  `representante_legal` VARCHAR(200),
  `cedula_representante` VARCHAR(20),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_empresas_usuario_id` (`usuario_id`),
  UNIQUE KEY `uq_empresas_rif` (`rif`)
);

CREATE TABLE `funcionarios` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `usuario_id` BIGINT,
  `cedula` VARCHAR(20),
  `nombres` VARCHAR(150),
  `apellidos` VARCHAR(150),
  `departamento` VARCHAR(150),
  `foto_perfil` TEXT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_funcionarios_usuario_id` (`usuario_id`),
  UNIQUE KEY `uq_funcionarios_cedula` (`cedula`)
);

CREATE TABLE `tramites` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(50),
  `nombre` VARCHAR(255),
  `descripcion` TEXT,
  `categoria` VARCHAR(100),
  `costo` DECIMAL(12,2),
  `requiere_documentos` BOOLEAN,
  `tiempo_estimado_dias` INT,
  `activo` BOOLEAN,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tramites_codigo` (`codigo`)
);

CREATE TABLE `solicitudes_tramite` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(50),
  `usuario_id` BIGINT,
  `tramite_id` BIGINT,
  `tipo_usuario` VARCHAR(20),
  `estado` VARCHAR(50),
  `fecha_solicitud` TIMESTAMP,
  `fecha_actualizacion` TIMESTAMP,
  `observaciones` TEXT,
  `prioridad` VARCHAR(20),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_solicitudes_tramite_codigo` (`codigo`)
);

CREATE TABLE `expedientes` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `solicitud_id` BIGINT,
  `numero_expediente` VARCHAR(50),
  `usuario_id` BIGINT,
  `estado_actual` VARCHAR(50),
  `fecha_creacion` TIMESTAMP,
  `fecha_cierre` TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_expedientes_numero_expediente` (`numero_expediente`)
);

CREATE TABLE `documentos` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `solicitud_id` BIGINT,
  `expediente_id` BIGINT DEFAULT 'ref: > expedientes.id',
  `nombre_archivo` VARCHAR(255),
  `url_archivo` TEXT,
  `tipo_documento` VARCHAR(100),
  `tamano_kb` INT,
  `subido_por` BIGINT,
  `verificado` BOOLEAN,
  PRIMARY KEY (`id`)
);

CREATE TABLE `pagos` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `solicitud_id` BIGINT,
  `monto` DECIMAL(12,2),
  `metodo_pago` VARCHAR(50),
  `referencia_pago` VARCHAR(100),
  `estado` VARCHAR(30),
  `fecha_pago` TIMESTAMP,
  `pagado_por` BIGINT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `historial_estados` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `solicitud_id` BIGINT,
  `estado_anterior` VARCHAR(50),
  `estado_nuevo` VARCHAR(50),
  `comentario` TEXT,
  `realizado_por` BIGINT,
  `fecha_cambio` TIMESTAMP,
  PRIMARY KEY (`id`)
);

CREATE TABLE `notificaciones` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `usuario_id` BIGINT,
  `titulo` VARCHAR(150),
  `mensaje` TEXT,
  `leida` BOOLEAN,
  `tipo` VARCHAR(50),
  `solicitud_id` BIGINT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `auditoria` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `usuario_id` BIGINT,
  `accion` VARCHAR(100),
  `tabla_afectada` VARCHAR(100),
  `registro_id` BIGINT,
  `ip_address` VARCHAR(45),
  `detalles` TEXT,
  `creado_en` TIMESTAMP,
  PRIMARY KEY (`id`)
);