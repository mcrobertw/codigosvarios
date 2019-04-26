public static void ejemploJDBC(String idbd, Strin idusuario, String Contraseña)
{
	try
	{
		Class.forName(<<oracle.jdbc.driver.OracleDriver>>);
		Connection con=DriverManager.getConnection(<<jdbc:oracle:thin:@aura.bell-labs.com:2000:bdbanco>>,idusuario,contraseña);
		Statement stmt=con.createStatement();
		try{
			stmt.executeUpdate(<<insert into cuenta values('C-9732','Navacerrada',1200)>>);
		}catch(SQLException sqle)
		{
			System.out.println(<<No se pudo insertar la tupla>>+sqle);
		}
		ResulSet rset=stmt.executeQuery(<<select nombre_sucursal, avg(saldo from cuenta group by nombre_sucursal>>);
		while(rset.next()){
			System.out.println(rset.getString(<<nombre_sucursal>>+<< >>+rset.getFloat(2));
		}
		stmt.close();
		con.close();
	}
	cath(SQLException sqle)
	{
		System.out.println(<<SQLException: >>+sqle);
	}
}