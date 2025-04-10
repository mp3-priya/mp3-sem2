package DaoLayer;

import models.RSVP;
import java.sql.*;
import java.util.*;

public class RSVPDAO {
    private Connection connect() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/UNI476_event_manager", "root", ""
            );
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Failed to connect to database!");
            e.printStackTrace();
        }
        return conn;
    }

    public void addRSVP(RSVP rsvp) {
        try (Connection con = connect()) {
            if (con == null) {
                System.out.println("Database connection failed in addRSVP");
                return;
            }
            String sql = "INSERT INTO rsvps(event_id, guest_name, guest_email) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, rsvp.getEventId());
            ps.setString(2, rsvp.getGuestName());
            ps.setString(3, rsvp.getGuestEmail());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean hasRSVP(int eventId, String email) {
        try (Connection con = connect()) {
            if (con == null) return false;

            String sql = "SELECT COUNT(*) FROM rsvps WHERE event_id = ? AND guest_email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, eventId);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<RSVP> getAllRSVPs() {
        List<RSVP> list = new ArrayList<>();
        try (Connection con = connect()) {
            if (con == null) {
                System.out.println("Database connection failed in getAllRSVPs");
                return list;
            }
            PreparedStatement ps = con.prepareStatement("SELECT * FROM rsvps");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RSVP r = new RSVP();
                r.setId(rs.getInt("id"));
                r.setEventId(rs.getInt("event_id"));
                r.setGuestName(rs.getString("guest_name"));
                r.setGuestEmail(rs.getString("guest_email"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
