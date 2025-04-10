package servlets;

import DaoLayer.RSVPDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import models.RSVP;

import java.io.IOException;
import java.io.PrintWriter;

public class RSVPServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String eventIdStr = request.getParameter("eventId");
        String name = request.getParameter("guestName");
        String email = request.getParameter("guestEmail");

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        if (eventIdStr == null || eventIdStr.isEmpty() || name == null || email == null ||
            name.isEmpty() || email.isEmpty()) {
            out.print("Please fill in all fields.");
            return;
        }

        int eventId;
        try {
            eventId = Integer.parseInt(eventIdStr);
        } catch (NumberFormatException e) {
            out.print("Invalid event ID.");
            return;
        }

        RSVPDAO dao = new RSVPDAO();

        if (dao.hasRSVP(eventId, email)) {
            out.print("This email has already RSVP'd for this event.");
            return;
        }

        RSVP r = new RSVP();
        r.setEventId(eventId);
        r.setGuestName(name);
        r.setGuestEmail(email);
        dao.addRSVP(r);

        out.print("RSVP successful! See you at the event.");
    }
}
