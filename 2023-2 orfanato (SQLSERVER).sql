CREATE TABLE Huerfano(
IdHuerfano INT PRIMARY KEY,  
Nombres VARCHAR(50),
Apellidos VARCHAR(50),
Cedula VARCHAR(10)unique,
FechaNacimento date,
tiposangre VARCHAR(4),
sexo VARCHAR(2),
)
CREATE TABLE Tio(
IdTio INT PRIMARY KEY,  
Nombres VARCHAR(50),
Apellidos VARCHAR(50),
Cedula VARCHAR(10)unique,
FechaNacimento date,
tiposangre VARCHAR(4),
correoelectronico VARCHAR(50),
sexo VARCHAR(2),
dirección VARCHAR (200),
licencia VARCHAR(3),
)
CREATE TABLE Causa(
IdCausa INT PRIMARY KEY,  
descripción VARCHAR(200),
)
CREATE TABLE Casa(
IdCasa INT PRIMARY Key,
direccíon VARCHAR (200),
valorarriendo float,
estado VARCHAR(20),
telefono VARCHAR(50),
descripción VARCHAR(200),
Ncuarto INT,
)
CREATE TABLE HuerfanoCausa(
IdCausa INT PRIMARY Key, 
IdHuerfano INT,
Observación  VARCHAR (200),
fechacausa date,
CONSTRAINT fk_Causa FOREIGN KEY (IdCausa) REFERENCES Causa(IdCausa),
CONSTRAINT fk_Huerfano FOREIGN KEY (IdHuerfano) REFERENCES Huerfano (IdHuerfano),
)
CREATE TABLE HermanoCasa(
IdCasa INT,
IdTio INT,
IdHermano INT PRIMARY KEY, 
fechaentrada date,
direccíoncasa VARCHAR (200),
fechasalida date,
CONSTRAINT fk_Casa FOREIGN KEY (IdCasa) REFERENCES Casa(IdCasa),
CONSTRAINT fk_Tio FOREIGN KEY (IdTio) REFERENCES Tio (IdTio),
)