drop Table [dbo].[CuentaBancaria]
go
SET ANSI_PADDING OFF
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaBancaria](
	[CuentaID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[NumeroCuenta] [nvarchar](20) COLLATE Modern_Spanish_CI_AS NOT NULL,
	[NombreTitular] [nvarchar](100) COLLATE Modern_Spanish_CI_AS NOT NULL,
	[Saldo] [decimal](18, 2) NOT NULL,
	[FechaApertura] [date] NOT NULL,
	[TipoCuenta] [nvarchar](50) COLLATE Modern_Spanish_CI_AS NOT NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboCuentaBancaria]', 'P') > 0
    drop proc [sp_MSins_dboCuentaBancaria]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboCuentaBancaria'
go
create procedure [sp_MSins_dboCuentaBancaria]
    @c1 int,
    @c2 nvarchar(20),
    @c3 nvarchar(100),
    @c4 decimal(18,2),
    @c5 date,
    @c6 nvarchar(50)
as
begin  
	insert into [dbo].[CuentaBancaria] (
		[CuentaID],
		[NumeroCuenta],
		[NombreTitular],
		[Saldo],
		[FechaApertura],
		[TipoCuenta]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6	) 
end  
go
if columnproperty(object_id(N'dbo.MSreplication_objects'), N'article', 'AllowsNull') is not null
exec sp_executesql 
    @statement = 
        N'insert dbo.MSreplication_objects (object_name, publisher, publisher_db, publication, article, object_type) 
            values 
        (@object_name, @publisher, @publisher_db, @publication, @article, ''P'')',
    @parameters = 
        N'@object_name sysname, @publisher sysname, @publisher_db sysname, @publication sysname, @article sysname',
    @object_name = N'sp_MSins_dboCuentaBancaria',
    @publisher = N'DESKTOP-DBKHB40',
    @publisher_db = N'BancoDB',
    @publication = N'copiaBancoDB',
    @article = N'CuentaBancaria'
go
if object_id(N'[dbo].[sp_MSins_dboCuentaBancaria_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboCuentaBancaria_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboCuentaBancaria_msrepl_ccs]
		@c1 int,
		@c2 nvarchar(20),
		@c3 nvarchar(100),
		@c4 decimal(18,2),
		@c5 date,
		@c6 nvarchar(50)
as
begin
if exists (select * 
             from [dbo].[CuentaBancaria]
            where [CuentaID] = @c1)
begin
update [dbo].[CuentaBancaria] set
		[NumeroCuenta] = @c2,
		[NombreTitular] = @c3,
		[Saldo] = @c4,
		[FechaApertura] = @c5,
		[TipoCuenta] = @c6
	where [CuentaID] = @c1
end
else
begin
	insert into [dbo].[CuentaBancaria] (
		[CuentaID],
		[NumeroCuenta],
		[NombreTitular],
		[Saldo],
		[FechaApertura],
		[TipoCuenta]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6	) 
end
end
go
if object_id(N'[sp_MSupd_dboCuentaBancaria]', 'P') > 0
    drop proc [sp_MSupd_dboCuentaBancaria]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboCuentaBancaria'
go
create procedure [sp_MSupd_dboCuentaBancaria]
		@c1 int = NULL,
		@c2 nvarchar(20) = NULL,
		@c3 nvarchar(100) = NULL,
		@c4 decimal(18,2) = NULL,
		@c5 date = NULL,
		@c6 nvarchar(50) = NULL,
		@pkc1 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''

update [dbo].[CuentaBancaria] set
		[NumeroCuenta] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [NumeroCuenta] end,
		[NombreTitular] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [NombreTitular] end,
		[Saldo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [Saldo] end,
		[FechaApertura] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [FechaApertura] end,
		[TipoCuenta] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [TipoCuenta] end
	where [CuentaID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[CuentaID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[dbo].[CuentaBancaria]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
go
if columnproperty(object_id(N'dbo.MSreplication_objects'), N'article', 'AllowsNull') is not null
exec sp_executesql 
    @statement = 
        N'insert dbo.MSreplication_objects (object_name, publisher, publisher_db, publication, article, object_type) 
            values 
        (@object_name, @publisher, @publisher_db, @publication, @article, ''P'')',
    @parameters = 
        N'@object_name sysname, @publisher sysname, @publisher_db sysname, @publication sysname, @article sysname',
    @object_name = N'sp_MSupd_dboCuentaBancaria',
    @publisher = N'DESKTOP-DBKHB40',
    @publisher_db = N'BancoDB',
    @publication = N'copiaBancoDB',
    @article = N'CuentaBancaria'
go
if object_id(N'[sp_MSdel_dboCuentaBancaria]', 'P') > 0
    drop proc [sp_MSdel_dboCuentaBancaria]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboCuentaBancaria'
go
create procedure [sp_MSdel_dboCuentaBancaria]
		@pkc1 int
as
begin  

	declare @primarykey_text nvarchar(100) = ''
	delete [dbo].[CuentaBancaria] 
	where [CuentaID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[CuentaID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[dbo].[CuentaBancaria]', @param2=@primarykey_text, @param3=13234 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
go
if columnproperty(object_id(N'dbo.MSreplication_objects'), N'article', 'AllowsNull') is not null
exec sp_executesql 
    @statement = 
        N'insert dbo.MSreplication_objects (object_name, publisher, publisher_db, publication, article, object_type) 
            values 
        (@object_name, @publisher, @publisher_db, @publication, @article, ''P'')',
    @parameters = 
        N'@object_name sysname, @publisher sysname, @publisher_db sysname, @publication sysname, @article sysname',
    @object_name = N'sp_MSdel_dboCuentaBancaria',
    @publisher = N'DESKTOP-DBKHB40',
    @publisher_db = N'BancoDB',
    @publication = N'copiaBancoDB',
    @article = N'CuentaBancaria'
go
if object_id(N'[dbo].[sp_MSdel_dboCuentaBancaria_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboCuentaBancaria_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboCuentaBancaria_msrepl_ccs]
		@pkc1 int
as
begin  

	declare @primarykey_text nvarchar(100) = ''
	delete [dbo].[CuentaBancaria] 
	where [CuentaID] = @pkc1
end  
go
