-- 2. Projeto Físico (DDL)

CREATE TABLE Cliente (
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
email VARCHAR(100),
telefone VARCHAR(20)
);
CREATE TABLE Loja (
id_loja INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
cidade VARCHAR(100),
aeroporto BOOLEAN
);
CREATE TABLE Carro (
id_carro INT PRIMARY KEY AUTO_INCREMENT,
placa VARCHAR(10),
modelo VARCHAR(100),
ano INT,
status ENUM('livre', 'alugado', 'reservado', 'manutencao'),
id_loja_atual INT,
FOREIGN KEY (id_loja_atual) REFERENCES Loja(id_loja)
);
CREATE TABLE Reserva (
id_reserva INT PRIMARY KEY AUTO_INCREMENT,
id_cliente INT,
id_carro INT,
id_loja_retirada INT,
id_loja_devolucao INT,
data_retirada DATE,
data_devolucao DATE,
inclui_motorista BOOLEAN,
valor DECIMAL(10, 2),
status ENUM('ativa', 'concluida', 'cancelada'),
FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
FOREIGN KEY (id_carro) REFERENCES Carro(id_carro),
FOREIGN KEY (id_loja_retirada) REFERENCES Loja(id_loja),
FOREIGN KEY (id_loja_devolucao) REFERENCES Loja(id_loja)
);
CREATE TABLE Pagamento (
id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
id_reserva INT,
data_pagamento DATE,
valor_pago DECIMAL(10, 2),
bandeira_cartao VARCHAR(20),
FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva)
);

-- 3. Scripts de INSERT, UPDATE e DELETE

INSERT INTO Cliente (nome, email, telefone) VALUES ('João Silva', 'joao@email.com', '11999998888');
UPDATE Cliente SET telefone = '11988887777' WHERE id_cliente = 1;
DELETE FROM Cliente WHERE id_cliente = 1;
INSERT INTO Carro (placa, modelo, ano, status, id_loja_atual) VALUES ('ABC1234', 'Fiat Uno', 2020, 'livre', 2);
UPDATE Carro SET status = 'manutencao' WHERE id_carro = 1;
DELETE FROM Carro WHERE id_carro = 1;
INSERT INTO Loja (nome, cidade, aeroporto) VALUES ('Loja Congonhas', 'São Paulo', true);
UPDATE Loja SET cidade = 'Guarulhos' WHERE id_loja = 1;
DELETE FROM Loja WHERE id_loja = 1;

-- 4. Scripts de SELECT

SELECT * FROM Cliente;
SELECT * FROM Carro;
SELECT * FROM Loja;
SELECT * FROM Reserva;
SELECT * FROM Pagamento;
SELECT * FROM Cliente WHERE id_cliente = 1;

-- 5. Consulta de Carros Disponíveis e Reservados

-- Carros disponíveis
SELECT * FROM Carro
WHERE status = 'livre'
AND id_carro NOT IN (
SELECT id_carro FROM Reserva
WHERE '2025-06-25' BETWEEN data_retirada AND data_devolucao
AND status = 'ativa'
);
-- Carros reservados
SELECT * FROM Carro
WHERE id_carro IN (
SELECT id_carro FROM Reserva
WHERE '2025-06-25' BETWEEN data_retirada AND data_devolucao
AND status = 'ativa'
);



