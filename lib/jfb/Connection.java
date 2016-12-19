import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.concurrent.Semaphore;

public class FDBConnection
{
	public ResultSet makeQuery(Connection con, String cmd)
	{
		ResultSet rs;
		
		try
		{
			rs = query(con, cmd);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error executing query.\nFailed expression  = " + cmd);
			rs = null;
		}
		
		return rs;
	}
	
	public void makeDeletion(Connection con, String cmd)
	{
		try
		{
			update(con, cmd);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error executing deletion.\nFailed expression = " + cmd);
		}
	}
	
	public void makeInsert(Connection con, String cmd)
	{
		try
		{
			update(con, cmd);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error executing insertion.\nFailed expression = " + cmd);
		}
	}
	
	public void makeUpdate(Connection con, String cmd)
	{
		try
		{
			update(con, cmd);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error executing update.\nFailed expression = " + cmd);
		}
	}
		
	public static Connection connectSQLServer(String db_url, String user, String password)
	{
		Connection con = null;
		
		try
		{
			Class.forName("org.firebirdsql.jdbc.FBDriver");
			DriverManager.getDriver(URL_DEFAULT);
			
			con = DriverManager.getConnection(db_url, user, password);
			con.setAutoCommit(false);
			con.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return con;
	}
	
	public void closeSQLConnection(Connection con)
	{
		try
		{
			con.commit();
			con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Erro fechando a conexão com o BD.");
		}
	}	
}
