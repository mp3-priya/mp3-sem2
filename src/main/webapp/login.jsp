<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Event Manager</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", sans-serif;
            background-color: #fffde7;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            background-color: #ffffff;
            padding: 2rem 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            font-weight: bold;
            color: #ff9800;
        }
        label {
            font-weight: 500;
            display: block;
            margin-top: 1rem;
            margin-bottom: 0.3rem;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.6rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
            background-color: #fffdf0;
        }
        button {
            width: 100%;
            padding: 0.7rem;
            background-color: #ffc107;
            color: #000;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            border-radius: 10px;
            margin-top: 1.5rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #f57c00;
            color: #fff;
        }
        .error-msg {
            margin-top: 1rem;
            color: red;
            text-align: center;
        }
        @media (max-width: 480px) {
            .login-container {
                padding: 1.5rem;
            }
            .login-header {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">Manager Login</div>
        <form action="LoginServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" required>

            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required>

            <button type="submit">Login</button>
        </form>

        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="error-msg">⚠️ Invalid username or password</div>
        <% } %>
    </div>
</body>
</html>