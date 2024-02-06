<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration</title>
</head>
<body>
    <h2>Choose your role:</h2>
    <form action="register" method="post">
        <label>Email:</label>
        <input type="text" name="email" required><br>
        
        <label>Password:</label>
        <input type="password" name="password" required><br>
        
        <label>Confirm password:</label>
        <input type="password" name="confirmPassword" required><br>
        <label>Role:</label>
        <select name="role" required>
            <option value="benevole">Benevole</option>
            <option value="adminassociation">Admin Association</option>
        </select><br>

        <input type="submit" value="Register">
    </form>
</body>
</html>
