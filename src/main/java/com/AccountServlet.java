package com;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AccountServlet", urlPatterns = "/AccountServlet")
public class AccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        if(request.getParameter("roleUser") != null) {

            session.invalidate();
            session = request.getSession(true);
            session.setAttribute("role", request.getParameter("roleUser"));
            session.setAttribute("statusLoginInHeader", "Exit");
        }
        request.getRequestDispatcher("/account.jsp").forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                HttpSession session = request.getSession(true);

//                if(request.getParameter("roleUser") != null) {
//
//                    session.invalidate();
//                    session = request.getSession(true);
//                    session.setAttribute("role", request.getParameter("roleUser"));
//                    session.setAttribute("statusLoginInHeader", "Exit");
//                }
//
//                else
                    if(session.getAttribute("role") != "Guest") {

                    session.invalidate();
                    session = request.getSession(true);
                    session.setAttribute("role", "Guest");
                    session.setAttribute("statusLoginInHeader", "Sign in or Create an account");

                } else if(session.getAttribute("role") == "Guest") {

                }

                request.getRequestDispatcher("/account.jsp").forward(request, response);
            }
            catch (Exception e) {
                throw new ServletException(e.getMessage());
            }

    }
}
