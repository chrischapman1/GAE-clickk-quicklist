package config;

import java.sql.*;

public class MySQLConnection {
    public static String getDB() {
        String result = "";
        try{
            Class.forName("com.mysql.jdbc.Driver");
//            Connection con=DriverManager.getConnection(
//                    "jdbc:mysql://google/analytics?cloudSqlInstance=clickk-quicklist:australia-southeast1:quicklist&amp;socketFactory=com.google.cloud.sql.mysql.SocketFactory&amp;useSSL=false", "root", "qaAnO30ANN46P5p9");
            Connection con=DriverManager.getConnection(
                    "jdbc:mysql://35.189.50.149/analytics", "root", "qaAnO30ANN46P5p9");

            Statement stmt=con.createStatement();
            ResultSet rs=stmt.executeQuery("select * from total");
            while(rs.next())
                result += rs.getString(1)+"  "+rs.getString(2)+"  "+rs.getString(3) +"\n";
            con.close();
        }catch(Exception e){ System.out.println(e);}
        return result;
    }
}
