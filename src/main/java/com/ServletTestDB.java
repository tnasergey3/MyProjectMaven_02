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

@WebServlet(name = "ServletTestDB", urlPatterns = "/ServletTestDB")
public class ServletTestDB extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter writer = response.getWriter();
        writer.println("Query data example:");

        HttpSession session = request.getSession(true);

        //
        //String roleUser_str = request.getParameter("roleUser");
        String roleUser_str = "admin";
        //String resultQuary = null;

       // if(roleUser_str != null) {

            // ********************
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
                //String schema = connection.getSchema();

                Statement statement = null;
                statement = connection.createStatement();

                //String query = "SELECT listUsers_Email FROM ListUsers WHERE listUsers_Email = 'admin'";
                String query = "SELECT Product.product_name FROM Product WHERE Product.brand = (SELECT Brand.brand_id FROM Brand WHERE Brand.brand_name = 'Rolex')";
                //String query = "SELECT listUsers_Email FROM ListUsers";
                //Выполним запрос
                ResultSet result1 = statement.executeQuery(query);

                //result это указатель на первую строку с выборки
                //чтобы вывести данные мы будем использовать
                //метод next() , с помощью которого переходим к следующему элементу
                while (result1.next()) {
//                    if (roleUser_str == result1.getString(1).toString()) {
                    writer.println("Result = " + result1.getString(1));
//                        session.invalidate();
//                        session = request.getSession(true);
//                        session.setAttribute("role", roleUser_str);
//                        session.setAttribute("statusLoginInHeader", "Exit");
//                    } else {
//                        writer = response.getWriter();
//                        writer.println("<script>alert('Такого пользователя не существует');</script>");
//
//                    }
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
        writer.close();

        //}
    }
}
