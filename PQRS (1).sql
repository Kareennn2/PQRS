-- Asegúrate de seleccionar la base de datos correcta
USE DB_PQRS;

-- Eliminar las tablas si existen para evitar conflictos
DROP TABLE IF EXISTS PQRS;
DROP TABLE IF EXISTS Administradores;
DROP TABLE IF EXISTS Usuarios;

-- Creación de la tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    correo_electronico VARCHAR(255) NOT NULL UNIQUE,
    telefono VARCHAR(50),
    contrasena_hash VARCHAR(255) NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    rol ENUM('admin', 'usuario') DEFAULT 'usuario'
);

-- Creación de la tabla PQRS
CREATE TABLE PQRS (
    id_pqrs INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo ENUM('Peticion', 'Queja', 'Reclamo', 'Sugerencia') NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('Abierto', 'En proceso', 'Cerrado') NOT NULL DEFAULT 'Abierto',
    pdf MEDIUMBLOB, -- Nueva columna para almacenar el PDF
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- Creación de la tabla Administradores
CREATE TABLE Administradores (
    id_administrador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    correo_electronico VARCHAR(255) NOT NULL UNIQUE,
    contrasena_hash VARCHAR(255) NOT NULL
);

-- Insertar un único administrador si la tabla está vacía
INSERT INTO Administradores (nombre, correo_electronico, contrasena_hash)
VALUES ('Administrador Principal', 'vanime@admin.com', 'administracion');

-- Crear un trigger para asegurar que solo haya un administrador
DELIMITER //
CREATE TRIGGER trg_one_admin BEFORE INSERT ON Administradores
FOR EACH ROW
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt FROM Administradores;
    IF cnt >= 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede insertar más de un administrador.';
    END IF;
END;
//
DELIMITER ;

-- Creación del procedimiento almacenado para agregar usuarios
DROP PROCEDURE IF EXISTS AgregarUsuario;
DELIMITER //
CREATE PROCEDURE AgregarUsuario(
    IN _nombre VARCHAR(255),
    IN _correo_electronico VARCHAR(255),
    IN _telefono VARCHAR(50),
    IN _contrasena_hash VARCHAR(255)
)
BEGIN
    INSERT INTO Usuarios (nombre, correo_electronico, telefono, contrasena_hash)
    VALUES (_nombre, _correo_electronico, _telefono, _contrasena_hash);
END;
//
DELIMITER ;
