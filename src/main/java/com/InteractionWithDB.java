package com;

import javax.servlet.ServletException;
import java.sql.*;

public class InteractionWithDB {
//    String Query(String stringQuary) throws SQLException {
//        String hostName = "sqlserverdb0.database.windows.net";
//        String dbName = "luxuryWatchesDB";
//        String user = "sqladmin";
//        String password = "80978986707sS";
//        String url = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", hostName, dbName, user, password);
//        Connection connection = null;
//
//        try {
//
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//            connection = DriverManager.getConnection(url);
//            String schema = connection.getSchema();
//
//            String selectSql = "SELECT brand_name FROM Brand WHERE brand_name = 'Titan'";
//
//            try (Statement statement = connection.createStatement();
//                 ResultSet resultSet = statement.executeQuery(selectSql)) {
//
//                while (resultSet.next()) {
//                    return resultSet.getString(1).toString();
//                }
//            }
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        } finally {
//            connection.close();
//        }
//    }
}
