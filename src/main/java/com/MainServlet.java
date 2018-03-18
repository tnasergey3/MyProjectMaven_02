package com;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;



@WebServlet(name = "mainServlet", urlPatterns = "/mainServlet")
public class MainServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
//            String tempValue1 = request.getParameter("roleUser").toString();


            HttpSession session = request.getSession(true);
//            session.setAttribute("tempValue", tempValue1);


            // Загрузка главной страницы первый раз
            if (session.getAttribute("role") == null) {
                session.setAttribute("role", "Guest");
                session.setAttribute("statusLoginInHeader", "Sign in or Create an account");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
             //Загрузка страницы не в первый раз
            else {
                // Обработка входа пользователя
//                if (session.getAttribute("role") != "Guest") {
//                    session.setAttribute("role", request.getParameter("roleUser"));
//                    session.setAttribute("statusLoginInHeader", "Exit");
//                    request.getRequestDispatcher("/checkout.jsp").forward(request, response);
//                }

                request.getRequestDispatcher("/sessionattr.jsp").forward(request, response);




//
//                // Авторизация пользователя
//                if (request.getParameter("roleUser") != "Guest") {
//                    session.setAttribute("role", request.getParameter("roleUser"));
//                    session.setAttribute("statusLoginInHeader", "Exit");
//                    request.getRequestDispatcher("/single.jsp").forward(request, response);
//                }
//
//                // Если пользователь Guest
//                if (session.getAttribute("role") == "Guest") {
//                    request.getRequestDispatcher("/account.jsp").forward(request, response);
//                }
//
            }
//
//            request.getRequestDispatcher("/register.jsp").forward(request, response);

            // Авторизация пользователя
            // Разлогинивание
/*            if(request.getParameter("statusLoginInHeader") == "Exit")
            {
                session.setAttribute("role", "Guest");
                session.setAttribute("statusLoginInHeader", "Sign in or Create an account");
                request.getRequestDispatcher("/account.jsp").forward(request, response);

            // Первый вход, загрузка галавной страницы
            } else if (request.getParameter("statusLoginInHeader") == "Sign in or Create an account" || session.getAttribute("role") == null) {
                session.setAttribute("role", "Guest");
                session.setAttribute("statusLoginInHeader", "Sign in or Create an account");
                request.getRequestDispatcher("/index.jsp").forward(request, response);

                // Авторизация пользователя
            } else if (request.getParameter("statusLoginInHeader") == "Sign in or Create an account") {
                //session.setAttribute("role", request.getParameter("roleUser"));
                //session.setAttribute("statusLoginInHeader", "Exit");
                request.getRequestDispatcher("/account.jsp").forward(request, response);
            } else
*/
            // Запуск главной страницы
            //request.getRequestDispatcher("/index.jsp").forward(request, response);


        }
        catch (Exception e) {
            throw new ServletException(e.getMessage());
        }




//        PrintWriter writer = response.getWriter();

//        // Connect to database
//        String hostName = "sqlserverdb0.database.windows.net";
//        String dbName = "luxuryWatchesDB";
//        String user = "sqladmin";
//        String password = "80978986707sS";
//        String url = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", hostName, dbName, user, password);
//        Connection connection = null;

//        try {
//
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//            connection = DriverManager.getConnection(url);
//            String schema = connection.getSchema();
//            writer.println("Successful connection - Schema: " + schema);
//
//            writer.println("Query data example:");
//            writer.println("=========================================");
//
//            // Create and execute a SELECT SQL statement.
//            String selectSql = "SELECT * FROM Brand";
////            String selectSql = "SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName "
////                    + "FROM [SalesLT].[ProductCategory] pc "
////                    + "JOIN [SalesLT].[Product] p ON pc.productcategoryid = p.productcategoryid";
//
//            try (Statement statement = connection.createStatement();
//                 ResultSet resultSet = statement.executeQuery(selectSql)) {
//
//
//                // Print results from select statement
//                writer.println("Output information from table Brand");
//                while (resultSet.next())
//                {
//                    writer.println(resultSet.getString(1) + " "
//                            + resultSet.getString(2));
//                }
//                connection.close();
//            }
//        }
//        catch (Exception e) {
//            writer.println(e.toString());
//
//        }
//
//        writer.close();


    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {

        }
        catch (Exception e) {
            throw new ServletException(e.getMessage());
        }

    }

}
