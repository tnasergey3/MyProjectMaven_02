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
        Date dateOfPurchase = new Date();
        String roleUser_str = request.getParameter("roleUser");

        PrintWriter writer = response.getWriter();
        response.setContentType("text/html");
        HttpSession session = request.getSession(true);

//        writer.println("idProduct = " + idProduct);
//        writer.println("img01Product = " + img01Product);
//        writer.println("priceProduct = " + priceProduct);
//        writer.println("nameProduct = " + nameProduct);


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
//
            Statement statement = null;
            statement = connection.createStatement();

            // Insert
           //String query = "SELECT * FROM Product WHERE Product.brand = (SELECT Brand.brand_id FROM Brand WHERE Brand.brand_name = '" + brandSt + "')";
//            String query = "INSERT INTO Purchase (purchase_date, client, status, product01_id, product01_name, product01_price, product01_img01) VALUES('"
//                    + dateOfPurchase.toString() + "', 3, 'status01', " + idProduct + ", '" + nameProduct + "', " + priceProduct + ", '" + img01Product + "')";

            String query = "INSERT INTO Shoppingbag (client, product01_id, product01_name, product01_price, product01_img01) VALUES("
                    + "(SELECT listUsers_id FROM ListUsers WHERE listUsers_FirstName = '" + roleUser_str + "'), " + idProduct + ", '" + nameProduct + "', " + priceProduct + ", '" + img01Product + "')";
            statement.executeUpdate(query);

            //result это указатель на первую строку с выборки
            //чтобы вывести данные мы будем использовать
            //метод next() , с помощью которого переходим к следующему элементу
//            while (result1.next()) {
//
//                Product prod = new Product();
//                prod.product_id = result1.getString("product_id");
//                prod.product_name = result1.getString("product_name");
//                prod.category = Integer.parseInt(result1.getString("category"));
//                prod.brand = Integer.parseInt(result1.getString("brand"));
//                prod.product_description_short = result1.getString("product_description_short");
//                prod.product_description_long = result1.getString("product_description_long");
//                prod.color = Integer.parseInt(result1.getString("color"));
//                prod.size = result1.getString("size");
//                prod.discount = Integer.parseInt(result1.getString("discount"));
//                prod.product_price = Integer.parseInt(result1.getString("product_price"));
//                prod.product_tag = result1.getString("product_tag");
//                prod.product_review = result1.getString("product_review");
//                prod.product_sku = result1.getString("product_sku");
//                prod.product_picture01 = result1.getString("product_picture01");
//                prod.product_picture02 = result1.getString("product_picture02");
//                prod.product_picture03 = result1.getString("product_picture03");
//
//                //listProducts.add(prod);
//                //request.setAttribute("listProducts", listProducts);
//            }

            //request.getRequestDispatcher("/checkout.jsp").forward(request, response);

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
