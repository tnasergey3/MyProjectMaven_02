package com;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "AddToCardServlet", urlPatterns = "/AddToCardServlet")
public class AddToCardServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idProduct = request.getParameter("idProduct");
        String img01Product = request.getParameter("img01Product");
        String priceProduct = request.getParameter("priceProduct");
        String nameProduct = request.getParameter("nameProduct");
        String brandProduct = request.getParameter("brandProduct");
        String brandProduct_str = null;

        Date dateOfPurchase = new Date();

        HttpSession session = request.getSession(true);
        String roleUser_str = (String) session.getAttribute("role");

        PrintWriter writer = response.getWriter();
        response.setContentType("text/html");

//        writer.println("idProduct = " + idProduct);
//        writer.println("img01Product = " + img01Product);
//        writer.println("priceProduct = " + priceProduct);
//        writer.println("nameProduct = " + nameProduct);
//        writer.println("roleUser_str = " + roleUser_str);


        // Connect to database
        String hostName = "sqlserverdb0.database.windows.net";
        String dbName = "luxuryWatchesDB";
        String user = "sqladmin";
        String password = "80978986707sS";
        String url = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", hostName, dbName, user, password);
        Connection connection = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url);
//            //String schema = connection.getSchema();

            Statement statement = connection.createStatement();

            // Select Brand
            String query0 = "SELECT brand_name FROM Brand WHERE brand_id = " + brandProduct;
            ResultSet resultSet = statement.executeQuery(query0);
            while (resultSet.next())
            {
               brandProduct_str = resultSet.getString("brand_name");
            }

            // Insert
            String query = "INSERT INTO Shoppingbag (client, product_id, product_name, product_price, product_img01) VALUES("
                    + "(SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = '" + roleUser_str + "'), " + idProduct + ", '" + nameProduct + "', " + priceProduct + ", '" + img01Product + "')";
            statement.executeUpdate(query);

            request.getRequestDispatcher("MenuMaintenanceServlet?brand=" + brandProduct_str).forward(request, response);

        } catch (Exception ex) {
            //выводим наиболее значимые сообщения
            Logger.getLogger(AccountServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AccountServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        writer.close();
    }
}
