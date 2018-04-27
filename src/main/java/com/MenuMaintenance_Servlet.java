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
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "MenuMaintenance_Servlet", urlPatterns = "/MenuMaintenance_Servlet")
public class MenuMaintenance_Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        response.setContentType("text/plain");

        HttpSession session = request.getSession(true);

        // Connect to database
//        String hostName = "sql0serverdb0.database.windows.net";
//        String dbName = "luxuryWatchesDB";
//        String user = "sqladmin";
//        String password = "80978986707sS";
//        String url = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", hostName, dbName, user, password);
//        Connection connection = null;

//        try {

            // Get the values of all request parameters
            Enumeration en = request.getParameterNames();
            while (en.hasMoreElements()) {

                // Get the name of the request parameter
                String name = (String) en.nextElement();
                writer.println(name);

            }


//        } catch (Exception ex) {
//            //выводим наиболее значимые сообщения
//            Logger.getLogger(AccountServlet.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            if (connection != null) {
//                try {
//                    connection.close();
//                } catch (SQLException ex) {
//                    Logger.getLogger(AccountServlet.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
            writer.close();

//        }

    }
}
