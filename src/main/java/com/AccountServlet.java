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

            Statement statement = null;
            statement = connection.createStatement();

            session.setAttribute("userExistence", "true");

            String query = "SELECT listUsers_Email FROM ListUsers where listUsers_Email = '" + roleUser_str + "'";
            //Выполним запрос
            ResultSet result1 = statement.executeQuery(query);
            //result это указатель на первую строку с выборки
            //чтобы вывести данные мы будем использовать
            //метод next() , с помощью которого переходим к следующему элементу
            while (result1.next()) {
                String result1_str = result1.getString("listUsers_Email");
                if(result1_str.equals(roleUser_str)){
                    session.invalidate();
                    session = request.getSession(true);
                    session.setAttribute("role", roleUser_str);
                    session.setAttribute("statusLoginInHeader", "Exit");
                    session.setAttribute("userExistence", "true");
                } else {
                    session.setAttribute("userExistence", "false");
                }
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
        }
        request.getRequestDispatcher("/account.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                HttpSession session = request.getSession(true);

                // Маркер активизации запуска js-скрипта для вывода сообщенич "пользователя не существует"
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
