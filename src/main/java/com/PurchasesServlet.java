package com;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "PurchasesServlet", urlPatterns = "/PurchasesServlet")
public class PurchasesServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        String roleUser_str = (String) session.getAttribute("role");
        //int idClient = Integer.parseInt(request.getParameter("idClient"));
        //Список для хранения товаров в корзине
        List<ProductInShoppingbag> listProductsInShoppingbag = new ArrayList<>();
        // Количество товаров в корзине
        String countProductInShoppingbag = null;

        java.util.Date dateOfPurchase = new Date();

        // Connect to database
        String hostName = "sqlserverdb0.database.windows.net";
        String dbName = "luxuryWatchesDB";
        String user = "sqladmin";
        String password = "80978986707sS";
        String url = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", hostName, dbName, user, password);
        Connection connection = null;
        Statement statement = null;

        // Прочитать данные из корзины
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url);
            statement = connection.createStatement();

            //
            // Чтение из базы содержимого корзины
            String query333 = "SELECT * FROM Shoppingbag WHERE client = (SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = " + "'" + roleUser_str + "'" + ")";
            ResultSet result11 = statement.executeQuery(query333);

            while (result11.next()) {

                ProductInShoppingbag prodShoppingbag = new ProductInShoppingbag();
                prodShoppingbag.shoppingbag_id = Integer.parseInt(result11.getString("shoppingbag_id"));
                prodShoppingbag.client = Integer.parseInt(result11.getString("client"));
                prodShoppingbag.product_id = Integer.parseInt(result11.getString("product_id"));
                //idClient = prodShoppingbag.product_id;
                prodShoppingbag.product_name = result11.getString("product_name");
                prodShoppingbag.product_price = Integer.parseInt(result11.getString("product_price"));
                prodShoppingbag.product_img01 = result11.getString("product_img01");

                listProductsInShoppingbag.add(prodShoppingbag);
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
        // Записать данные из корзины в таблицу purchases
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url);
            statement = connection.createStatement();

            // Insert
            for(ProductInShoppingbag item : listProductsInShoppingbag){
                String query = "INSERT INTO Purchase (purchase_date, client, status, product_id, product_name, product_price, product_img01) VALUES('"
                        + dateOfPurchase.toString() + "', " + item.client + ", " + "'in processing', " + item.product_id  + ", '" + item.product_name + "', " + item.product_price + ", '" + item.product_img01 + "')";
                statement.executeUpdate(query);
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
        // Удалить данные из корзины
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url);//
            statement = connection.createStatement();

            // Deleting data
            String query = "DELETE FROM Shoppingbag WHERE Shoppingbag.client = (SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = " + "'" + roleUser_str + "'" + ")";
            ResultSet result11 = statement.executeQuery(query);

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
        // обновление header (корзина)
        session.setAttribute("amountProductsInShoppingBag", "0");
        session.setAttribute("quantityProductsInShoppingBag", "0");

        //
        // Вычисление количества и суммы покупок для конкретного пользователя
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url);
            statement = connection.createStatement();

            // Выборка стоимости товаров в корзине конкретного пользователя
            String query = "SELECT SUM(product_price) FROM Purchase WHERE client = (SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = '" + roleUser_str + "')";
            ResultSet result = statement.executeQuery(query);

            //result11.first();
            while (result.next()) {
                session.setAttribute("amountProductsInPurchase", result.getInt(1));
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
            String query  = "SELECT COUNT(product_price) FROM Purchase WHERE client = (SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = '" + roleUser_str + "')";
            ResultSet result1 = statement.executeQuery(query);

            while (result1.next()) {
                session.setAttribute("quantityProductsInPurchase", result1.getString(1));
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
        // Вывести результат в файл
        request.getRequestDispatcher("/purchases.jsp").forward(request, response);
    }
}
