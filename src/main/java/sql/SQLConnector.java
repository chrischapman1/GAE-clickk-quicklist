package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class SQLConnector {
    public Connection connectToSQL()
    {
        Connection con= null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con= DriverManager.getConnection(
                    "jdbc:mysql://203.98.95.106/quickcut_quicklist","quickcut_cc","quicklist");
        }
        catch(Exception e){
            System.out.println(e);
        }
        return con;
    }
}

