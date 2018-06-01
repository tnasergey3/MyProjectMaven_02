package com;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "AccountServlet", urlPatterns = "/AccountServlet")
public class AccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        String roleUser_str = request.getParameter("roleUser");
        session.setAttribute("userExistence_Switch", "on");
        //session.setAttribute("userExistence", "true");

        String result1_str = null;
        Statement statement = null;

        if(roleUser_str != null) {
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
                statement = connection.createStatement();

                // Проверка на существование пользователя в базе
                String query = "SELECT listUsers_Email FROM ListUsers WHERE listUsers_Email = '" + roleUser_str + "'";
                ResultSet result1 = statement.executeQuery(query);

                    while (result1.next()) {
                        result1_str = result1.getString("listUsers_Email");
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

            if(result1_str.equals(roleUser_str)){ // Проверка если пользователь существует
                 session.invalidate();
                 session = request.getSession(true);
                 session.setAttribute("role", roleUser_str);
                 session.setAttribute("statusLoginInHeader", "Exit");
                 session.setAttribute("userExistence", "false");

            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(url);
                statement = connection.createStatement();

                // Выборка стоимости товаров в корзине конкретного пользователя
                String query = "SELECT SUM(product_price) FROM Shoppingbag WHERE client = (SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = '" + roleUser_str + "')";
                ResultSet result = statement.executeQuery(query);

                //result11.first();
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

        } else {
            session.setAttribute("userExistence", "true");
        }

        }
        request.getRequestDispatcher("/account.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                HttpSession session = request.getSession(true);

                // Маркер активизации запуска js-скрипта для вывода сообщения "пользователя не существует"
                session.setAttribute("userExistence_Switch", "off");

                    if(session.getAttribute("role") != "Guest") {
                        session.invalidate();
                        session = request.getSession(true);
                        session.setAttribute("role", "Guest");
                        session.setAttribute("statusLoginInHeader", "Sign in or Create an account");
                } else if(session.getAttribute("role") == "Guest") {                }

                request.getRequestDispatcher("/account.jsp").forward(request, response);
            }
            catch (Exception e) {
                throw new ServletException(e.getMessage());
            }
    }
}
