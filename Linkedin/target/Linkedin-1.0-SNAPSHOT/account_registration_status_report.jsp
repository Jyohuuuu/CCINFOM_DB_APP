<%-- 
    Document   : account_registration_status_report
    Created on : Nov 24, 2024, 5:16:11 PM
    Author     : julia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Registration Report</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 1000px;
                margin: 0 auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                color: #333;
                margin-bottom: 20px;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            .form-group select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }
            .scrollable-table {
                max-height: 400px;
                overflow-y: auto;
                margin-top: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid #ccc;
            }
            th, td {
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            .back-button {
                display: block;
                width: 100%;
                padding: 10px;
                margin-top: 20px;
                background-color: #ccc;
                color: black;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
            }
            .back-button:hover {
                background-color: #bbb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Account Registration and Status Report</h1>
            <form method="GET" action="account_registration_status_report.jsp">
                <div class="form-group">
                    <label for="year">Select Year:</label>
                    <select id="year" name="year">
                        <% 
                            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                            for (int year = currentYear; year >= 2000; year--) {
                        %>
                        <option value="<%= year %>"><%= year %></option>
                        <% 
                            }
                        %>
                    </select>
                </div>
                <button type="submit">Generate Report</button>
            </form>
            <div class="scrollable-table">
                <table>
                    <thead>
                        <tr>
                            <th>Account ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>Registration Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            String selectedYear = request.getParameter("year");
                            if (selectedYear != null) {
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789"); 
                                    PreparedStatement pstmt = conn.prepareStatement("SELECT account_ID, first_name, last_name, email, registration_date FROM user_accounts WHERE YEAR(registration_date) = ?");
                                    pstmt.setInt(1, Integer.parseInt(selectedYear));
                                    ResultSet rs = pstmt.executeQuery();
                                    
                                    while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("account_ID") %></td>
                            <td><%= rs.getString("first_name") %></td>
                            <td><%= rs.getString("last_name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getDate("registration_date") %></td>
                        </tr>
                        <% 
                                    }
                                    rs.close();
                                    pstmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <a href="generate_reports.jsp" class="back-button">Back to Reports</a>
        </div>
    </body>
</html>