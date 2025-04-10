<%@ page language="java" import="DaoLayer.EventDAO, models.Event, java.util.*" %>
<%
    EventDAO eventDAO = new EventDAO();
    List<Event> events = eventDAO.getAllEvents();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Events - Home</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #fef8e0;
        }
        header {
            background-color: #ffc107;
            color: #000;
            padding: 1rem;
            text-align: center;
            font-size: 1.8rem;
            font-weight: bold;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .container {
            max-width: 1200px;
            margin: auto;
            padding: 2rem;
        }
        .filter-box {
            margin-bottom: 1.5rem;
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .filter-box input {
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            flex: 1;
            min-width: 200px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fffde7;
        }
        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #ffecb3;
        }
        tr:hover {
            background-color: #fff8e1;
        }
        button {
            background-color: #ff9800;
            border: none;
            padding: 0.5rem 1rem;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background-color: #f57c00;
        }
        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }
            tr {
                margin-bottom: 1rem;
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 0.5rem;
                background-color: #fff;
            }
            td, th {
                padding: 0.3rem 0;
                border: none;
            }
            th {
                display: none;
            }
            td:before {
                content: attr(data-label);
                font-weight: bold;
                display: block;
                margin-bottom: 4px;
            }
        }
    </style>
    <script>
        function rsvp(eventId) {
            const name = prompt("Enter your name:");
            const email = prompt("Enter your email:");

            if (name && email) {
                const formBody = "eventId=" + eventId +
                                 "&guestName=" + encodeURIComponent(name) +
                                 "&guestEmail=" + encodeURIComponent(email);

                fetch("RSVPServlet", {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: formBody
                })
                .then(response => response.text())
                .then(message => alert(message))
                .catch(error => alert("An error occurred: " + error));
            } else {
                alert("Both name and email are required to RSVP.");
            }
        }

        function filterEvents() {
            const nameFilter = document.getElementById("nameFilter").value.toLowerCase();
            const typeFilter = document.getElementById("typeFilter").value.toLowerCase();
            const rows = document.querySelectorAll("tbody tr");

            rows.forEach(row => {
                const name = row.querySelector("td:nth-child(1)").textContent.toLowerCase();
                const type = row.querySelector("td:nth-child(6)").textContent.toLowerCase();

                if (name.includes(nameFilter) && type.includes(typeFilter)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    </script>
</head>
<body>
    <header>Welcome to Emma's Event Management</header>
    <div class="container">
        <div class="filter-box">
            <input type="text" id="nameFilter" onkeyup="filterEvents()" placeholder="Search by event name">
            <input type="text" id="typeFilter" onkeyup="filterEvents()" placeholder="Search by event type">
        </div>

        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Location</th>
                    <th>Description</th>
                    <th>Type</th>
                    <th>RSVP</th>
                </tr>
            </thead>
            <tbody>
                <% for (Event e : events) { %>
                    <tr>
                        <td data-label="Name"><%= e.getName() %></td>
                        <td data-label="Date"><%= e.getDate() %></td>
                        <td data-label="Time"><%= e.getTime() %></td>
                        <td data-label="Location"><%= e.getLocation() %></td>
                        <td data-label="Description"><%= e.getDescription() %></td>
                        <td data-label="Type"><%= e.getType() %></td>
                        <td data-label="RSVP">
                            <button onclick="rsvp(<%= e.getId() %>)">RSVP</button>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
