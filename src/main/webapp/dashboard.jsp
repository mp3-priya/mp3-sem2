<%@ page language="java" pageEncoding="UTF-8" import="models.Event, java.util.*, DaoLayer.EventDAO, DaoLayer.RSVPDAO, models.RSVP" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    EventDAO eventDAO = new EventDAO();
    List<Event> events = eventDAO.getAllEvents();

    RSVPDAO rsvpDAO = new RSVPDAO();
    List<RSVP> rsvps = rsvpDAO.getAllRSVPs();
%>
<html>
<head>
    <title>Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f1f3f6;
            margin: 0;
            padding: 20px;
        }
        h2, h3 {
            color: #2874f0;
        }
        a {
            color: #ff5722;
            text-decoration: none;
            float: right;
        }
        button {
            background-color: #2874f0;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            margin: 2px;
        }
        button:hover {
            background-color: #0b5ed7;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.05);
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f9f9f9;
        }
        .popup {
            display: none;
            position: fixed;
            top: 10%;
            left: 30%;
            width: 40%;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            padding: 20px;
            z-index: 9999;
        }
        .overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 9998;
        }
        input[type="text"], input[type="date"], input[type="time"], textarea {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            margin-bottom: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
    </style>
    <script>
        function openCreatePopup() {
            document.getElementById('createForm').reset();
            document.getElementById('createPopup').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
        }

        function openEditPopup(id, name, date, time, duration, location, description, type) {
            document.getElementById('editId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editDate').value = date;
            document.getElementById('editTime').value = time;
            document.getElementById('editDuration').value = duration;
            document.getElementById('editLocation').value = location;
            document.getElementById('editDescription').value = description;
            document.getElementById('editType').value = type;
            document.getElementById('editPopup').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
        }

        function closePopup() {
            document.getElementById('createPopup').style.display = 'none';
            document.getElementById('editPopup').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }
    </script>
</head>
<body>
    <div id="overlay" class="overlay" onclick="closePopup()"></div>

    <h2>Welcome, <%= session.getAttribute("user") %></h2>
    <a href="LogoutServlet">Logout</a>

    <h3>All Events</h3>
    <button onclick="openCreatePopup()">+ Create New Event</button>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Date</th><th>Time</th><th>Duration</th><th>Location</th><th>Description</th><th>Type</th><th>Actions</th>
        </tr>
        <% for (Event e : events) { %>
            <tr>
                <td><%= e.getId() %></td>
                <td><%= e.getName() %></td>
                <td><%= e.getDate() %></td>
                <td><%= e.getTime() %></td>
                <td><%= e.getDuration() %></td>
                <td><%= e.getLocation() %></td>
                <td><%= e.getDescription() %></td>
                <td><%= e.getType() %></td>
                <td>
                    <form action="EventServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= e.getId() %>">
                        <button type="submit">Delete</button>
                    </form>
                    <button onclick="openEditPopup(
                        '<%= e.getId() %>',
                        '<%= e.getName() %>',
                        '<%= e.getDate() %>',
                        '<%= e.getTime() %>',
                        '<%= e.getDuration() %>',
                        '<%= e.getLocation() %>',
                        '<%= e.getDescription() %>',
                        '<%= e.getType() %>'
                    )">Edit</button>
                </td>
            </tr>
        <% } %>
    </table>

    <br><br>
    <h3>RSVP History</h3>
    <table>
        <tr><th>Event ID</th><th>Name</th><th>Email</th></tr>
        <% for (RSVP r : rsvps) { %>
            <tr>
                <td><%= r.getEventId() %></td>
                <td><%= r.getGuestName() %></td>
                <td><%= r.getGuestEmail() %></td>
            </tr>
        <% } %>
    </table>

    <!-- Create Event Popup -->
    <div id="createPopup" class="popup">
        <h3>Create Event</h3>
        <form id="createForm" action="EventServlet" method="post">
            <input type="hidden" name="action" value="create">
            Name: <input type="text" name="name"><br>
            Date: <input type="date" name="date"><br>
            Time: <input type="time" name="time"><br>
            Duration: <input type="text" name="duration"><br>
            Location: <input type="text" name="location"><br>
            Description: <textarea name="description"></textarea><br>
            Type: <input type="text" name="type"><br><br>
            <button type="submit">Create</button>
            <button type="button" onclick="closePopup()">Cancel</button>
        </form>
    </div>

    <!-- Edit Event Popup -->
    <div id="editPopup" class="popup">
        <h3>Edit Event</h3>
        <form action="EventServlet" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" id="editId">
            Name: <input type="text" name="name" id="editName"><br>
            Date: <input type="date" name="date" id="editDate"><br>
            Time: <input type="time" name="time" id="editTime"><br>
            Duration: <input type="text" name="duration" id="editDuration"><br>
            Location: <input type="text" name="location" id="editLocation"><br>
            Description: <textarea name="description" id="editDescription"></textarea><br>
            Type: <input type="text" name="type" id="editType"><br><br>
            <button type="submit">Update</button>
            <button type="button" onclick="closePopup()">Cancel</button>
        </form>
    </div>
</body>
</html>