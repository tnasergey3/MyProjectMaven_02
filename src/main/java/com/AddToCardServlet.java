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

        // Проверка
        if (roleUser_str.equals("Guest") || roleUser_str == null) {
            request.getRequestDispatcher("/account.jsp").forward(request, response);
        } else {
            // Connect to database
            String hostName = "sqlserverdb0.database.windows.net";
            String dbName = "luxuryWatchesDB";
            String user = "sqladmin";
            String password = "80978986707sS";
            String url = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", hostName, dbName, user, password);
            Connection connection = null;
            Statement statement = null;

            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(url);
                statement = connection.createStatement();

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

                //request.getRequestDispatcher("MenuMaintenanceServlet?brand=" + brandProduct_str).forward(request, response);

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

            // обновление корзины
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(url);
                statement = connection.createStatement();

                // Выборка стоимости товаров в корзине конкретного пользователя
                String query = "SELECT SUM(product_price) FROM Shoppingbag WHERE client = (SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = '" + roleUser_str + "')";
                ResultSet result = statement.executeQuery(query);

                while (result.next()) {
                    session.setAttribute("amountProductsInShoppingBag", result.getInt(1));
                }
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

            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(url);
                statement = connection.createStatement();

                // Выборка количества товаров в корзине конкретного пользователя
                String query  = "SELECT COUNT(product_price) FROM Shoppingbag WHERE client = (SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = '" + roleUser_str + "')";
                ResultSet result1 = statement.executeQuery(query);

                while (result1.next()) {
                    session.setAttribute("quantityProductsInShoppingBag", result1.getString(1));
                }
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
            //
            // Обновление текущей странички
            request.getRequestDispatcher("MenuMaintenanceServlet?brand=" + brandProduct_str).forward(request, response);
        }






    }
}
