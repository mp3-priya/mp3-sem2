package servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("emma".equals(username) && "emma".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", "emma");
            response.sendRedirect("EventServlet");
        } else {
            response.getWriter().println("Invalid login!");
        }
    }
}
