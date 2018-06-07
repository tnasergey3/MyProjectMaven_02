package com;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet(name = "mainServlet", urlPatterns = "/mainServlet")
public class MainServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession(true);

            // Загрузка главной страницы первый раз
            if (session.getAttribute("role") == null) {
                session.setAttribute("role", "Guest");
                session.setAttribute("statusLoginInHeader", "Sign in or Create an account");
                session.setAttribute("amountProductsInShoppingBag", "0");
                session.setAttribute("quantityProductsInShoppingBag", "0");
                request.getRequestDispatcher("/contact.jsp").forward(request, response);
            }
             //Загрузка страницы не в первый раз
            else {
                // Обработка входа пользователя
//                if (session.getAttribute("role") != "Guest") {
//                    session.setAttribute("role", request.getParameter("roleUser"));
//                    session.setAttribute("statusLoginInHeader", "Exit");
//                    request.getRequestDispatcher("/checkout.jsp").forward(request, response);
//                }
            }
        }
        catch (Exception e) {
            throw new ServletException(e.getMessage());
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
