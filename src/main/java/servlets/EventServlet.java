package servlets;

import java.io.IOException;
import java.util.List;

import DaoLayer.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Event;

public class EventServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EventDAO dao = new EventDAO();
        List<Event> events = dao.getAllEvents();
        request.setAttribute("events", events);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        EventDAO dao = new EventDAO();

        Event e = new Event();
        e.setName(request.getParameter("name"));
        e.setDate(request.getParameter("date"));
        e.setTime(request.getParameter("time"));
        e.setDuration(request.getParameter("duration"));
        e.setLocation(request.getParameter("location"));
        e.setDescription(request.getParameter("description"));
        e.setType(request.getParameter("type"));
        e.setOwner("emma");

        switch (action) {
            case "create":
                dao.addEvent(e);
                break;
            case "edit":
                e.setId(Integer.parseInt(request.getParameter("id")));
                dao.updateEvent(e);
                break;
            case "delete":
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteEvent(id);
                break;
        }
        response.sendRedirect("EventServlet");
    }
}
