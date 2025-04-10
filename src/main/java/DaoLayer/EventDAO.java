package DaoLayer;

import models.Event;
import java.sql.*;
import java.util.*;

public class EventDAO {
    private Connection connect() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/UNI476_event_manager", "root", ""
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Event> getAllEvents() {
        List<Event> list = new ArrayList<>();
        try (Connection con = connect()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM events");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Event e = new Event();
                e.setId(rs.getInt("id"));
                e.setName(rs.getString("event_name"));
                e.setDate(rs.getString("event_date"));
                e.setTime(rs.getString("event_time"));
                e.setDuration(rs.getString("duration"));
                e.setLocation(rs.getString("location"));
                e.setDescription(rs.getString("description"));
                e.setType(rs.getString("event_type"));
                e.setOwner(rs.getString("owner_name"));
                list.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addEvent(Event e) {
        try (Connection con = connect()) {
            String sql = "INSERT INTO events(event_name, event_date, event_time, duration, location, description, event_type, owner_name) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, e.getName());
            ps.setString(2, e.getDate());
            ps.setString(3, e.getTime());
            ps.setString(4, e.getDuration());
            ps.setString(5, e.getLocation());
            ps.setString(6, e.getDescription());
            ps.setString(7, e.getType());
            ps.setString(8, e.getOwner());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateEvent(Event e) {
        try (Connection con = connect()) {
            String sql = "UPDATE events SET event_name=?, event_date=?, event_time=?, duration=?, location=?, description=?, event_type=?, owner_name=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, e.getName());
            ps.setString(2, e.getDate());
            ps.setString(3, e.getTime());
            ps.setString(4, e.getDuration());
            ps.setString(5, e.getLocation());
            ps.setString(6, e.getDescription());
            ps.setString(7, e.getType());
            ps.setString(8, e.getOwner());
            ps.setInt(9, e.getId());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteEvent(int id) {
        try (Connection con = connect()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM events WHERE id = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} 