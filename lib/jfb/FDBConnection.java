import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.concurrent.Semaphore;

public class FDBConnection
{
	private Connection con;

	public ResultSet makeQuery(String cmd)
	{
		ResultSet rs;
		
		try
		{
			rs = con.createStatement().executeQuery(cmd);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error executing query.\nFailed expression  = " + cmd);
			rs = null;
		}
		
		return rs;
	}
	
	public void makeUpdate(String cmd)
	{
		try
		{
			con.createStatement().executeUpdate(cmd);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error executing update.\nFailed expression = " + cmd);
		}
	}
		
	public void connectSQLServer(String db_url, String user, String password)
	{
		try
		{
			Class.forName("org.firebirdsql.jdbc.FBDriver");
			DriverManager.getDriver(db_url);
			
			con = DriverManager.getConnection(db_url, user, password);
			con.setAutoCommit(false);
			con.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void closeSQLConnection()
	{
		try
		{
			con.commit();
			con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error closing FDB connection.");
		}
	}	
}
