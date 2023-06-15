USE bdRecursosHumanos


--A)Criar uma view para exibir a quantidade de funcionários por nome de departamento;
CREATE VIEW vwExibir_Funcionarios AS
	SELECT nomeDepartamento AS 'Departamentos:', COUNT (codFuncionario) 'Quantidade de funcionarios:' FROM tbDepartamento
		INNER JOIN tbFuncionario 
			ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento
				GROUP BY nomeDepartamento
					--Apresentanado view--
								SELECT * FROM vwExibir_Funcionarios

--B)Usando a view anterior, exibir somente o nome do departamento que possui o menor número de funcionários;
SELECT [Departamentos:],[Quantidade de funcionarios:] FROM vwExibir_Funcionario
	WHERE [Quantidade de funcionarios:] = (SELECT MIN([Quantidade de funcionarios:]) FROM vwExibir_Funcionario)

--C)Criar uma view para exibir a soma dos salários por nome de departamento
CREATE VIEW vwSoma_Salarios AS
	SELECT nomeDepartamento AS 'Departamentos:', SUM (salarioFuncionario) 'Soma dos salarios:' FROM tbDepartamento
		INNER JOIN tbFuncionario
			ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento
				GROUP BY nomeDepartamento
					--Apresentanado view--
								SELECT * FROM vwSoma_Salarios

--D)Utilizando a view do exercício anterior, mostrar somente a maior soma dentre os departamentos;
SELECT [Departamentos:],[Soma dos salarios:] FROM vwSoma_Salario
	WHERE [Soma dos salarios:] = (SELECT MAX([Soma dos salarios:]) FROM vwSoma_Salario)


--E)Criar uma view para exibir somente o nome dos funcionários e o nome dos departamentos daqueles  funcionários que não possuem dependentes;
CREATE VIEW vwExibir_Dependentes AS
	SELECT nomeFuncionario AS 'Nome dos Funcionarios:', nomeDepartamento 'Departamentos:' FROM tbFuncionario
		JOIN tbDepartamento 
			ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento
				WHERE tbFuncionario.codFuncionario NOT IN (SELECT codFuncionario FROM tbDependente)
						GROUP BY nomeFuncionario, nomeDepartamento
							--Apresentanado view--
								SELECT * FROM vwExibir_Dependentes


--f)Criar uma view que exiba a quantidade de dependentes por nome de funcionário;
ALTER VIEW vwExibir AS 
	SELECT nomeFuncionario AS 'Funcionarios:', COUNT(codDependente) 'Quantidade de Dependentes:' FROM tbFuncionario
		INNER JOIN tbDependente 
			ON tbDependente.codFuncionario = TbFuncionario.codFuncionario
				GROUP BY nomeFuncionario
					--Apresentanado view--
						SELECT * FROM vwExibir

--g)Utilizando a view anterior, mostrar somente o nome do funcionário que possui mais dependentes
SELECT [Funcionarios:],[Quantidade de Dependentes:] FROM vwExibir
	WHERE [Quantidade de Dependentes:] = (SELECT MAX([Quantidade de Dependentes:]) FROM vwExibir)


--h)Criar uma view para exibir a quantidade de dependentes por departamento
CREATE VIEW vwExibir_Dependentes AS 
	SELECT nomeDepartamento AS'Departamento:' , COUNT(codDependente) AS 'Quantidade dependente:' FROM tbDepartamento
		LEFT JOIN tbFuncionario 
			ON tbDepartamento.codDepartamento = tbFuncionario.codDepartamento
				LEFT JOIN tbDependente ON tbFuncionario.codFuncionario = tbDependente.codFuncionario
					GROUP BY nomeDepartamento
						--Apresentanado view--
							SELECT * FROM vwExibir_Dependentes

--i)Utilizando a view do exercício anterior, apresentar a soma geral dos dependentes
SELECT SUM([Quantidade dependente:]) AS 'Soma geral de dependentes:' FROM vwExibir_Dependentes