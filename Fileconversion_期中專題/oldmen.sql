/****** SSMS 中 SelectTopNRows 命令的指令碼  ******/
SELECT TOP (1000) [unit]
      ,[address]
      ,[phone]
      ,[phone2]
      ,[email]
  FROM [courageTopice].[dbo].[OldMen]

delete top(1) OldMen;
go
select * from OldMen