int ODBCexample()
{
	RETCODE error;
	HENV ent; /*entorno*/
	HDBC con; /*conexión a la base de datos*/
	
	SQLAllocEnv(&ent);
	SQLAllocConnect(ent,&con);
	SQLConnect(con,<<aura.bell-labs.com>>,SQL NTS,<<avi>>, SQL NTS, <<avipasswd>>,SQL NTS);
	{
		char nombresucursal[80];
		float saldo;
		int lenOut1, lenOut2;
		HSTMT stmt;
		
		char * consulta=<<select nombre_sucursal, sum (saldo)
				from cuenta
				group by nombre_sucursal>>;
		
		SQLAllocStmt(con,&stmt);
		error=SQLExecDirect(stmt,consulta,SQL NTS);
		if(error==SQL SUCCESS){
			SQLBindCol(stmt, 1, SQL C CHAR, nombresucursal, 80,&lenOut1);
			SQLBindCol(stmt,2,SQL C FLOAT,&saldo,0,&lenOut2);
			while(SQLFetch(stmt)>=SQL SUCCESS){
				printf(<<%s %g\n, nombresucursal,saldo);
			}
		}
		SQLFreeStmt(stmt, SQL DROP);
	}
	SQLDisconnect(con);
	SQLFreeConnect(con);
	SQLFreeEnv(ent);
}	