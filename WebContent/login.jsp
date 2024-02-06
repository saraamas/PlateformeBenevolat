<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    
    <%-- Display an error message if login fails --%>
    <% if (request.getParameter("error") != null) { %>
        <p style="color: red;">Login failed. Please check your email and password.</p>
    <% } %>

    <form action="login" method="post">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <button type="submit">Login</button>
    </form>
    <a href='register.jsp'>New here ?Register</a>
</body>
</html>
