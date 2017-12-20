package com;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;

public class MainServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter writer = response.getWriter();

        // Connect to database
        String hostName = "sqlserverdb0.database.windows.net";
        String dbName = "luxuryWatchesDB";
        String user = "sqladmin";
        String password = "80978986707sS";
        String url = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", hostName, dbName, user, password);
        Connection connection = null;

        //writer.println("2");

        try {
            //writer.println("3");

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            connection = DriverManager.getConnection(url);
            String schema = connection.getSchema();
            writer.println("Successful connection - Schema: " + schema);

            writer.println("Query data example:");
            writer.println("=========================================");

            // Create and execute a SELECT SQL statement.
            String selectSql = "SELECT * FROM Brand";
//            String selectSql = "SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName "
//                    + "FROM [SalesLT].[ProductCategory] pc "
//                    + "JOIN [SalesLT].[Product] p ON pc.productcategoryid = p.productcategoryid";

            try (Statement statement = connection.createStatement();
                 ResultSet resultSet = statement.executeQuery(selectSql)) {

                //writer.println("4");

                // Print results from select statement
                writer.println("Output information from table Brand");
                while (resultSet.next())
                {
                    writer.println(resultSet.getString(1) + " "
                            + resultSet.getString(2));
                }
                connection.close();
            }
        }
        catch (Exception e) {
            //writer.println("5");
            writer.println(e.toString());
           // e.printStackTrace();
        }

        //writer.println("6");

        writer.close();
    }
}
