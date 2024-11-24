<%-- 
    Document   : view_user_job_applications
    Created on : Nov 24, 2024, 9:43:06 AM
    Author     : julia
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View User Job Applications</title>
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
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #ccc;
                color: black;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
            }
            .back-button:hover {
                background-color: #bbb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>User Job Applications</h1>
            <div class="scrollable-table">
                <table>
                    <thead>
                        <tr>
                            <th>Application ID</th>
                            <th>Posting ID</th>
                            <th>Account ID</th>
                            <th>Application Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <jsp:useBean id="A" class="link.login_logic" scope="session" />
                        <% 
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789"); 
                                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM job_applications WHERE account_ID = ?");
                                String email = A.userName;
                                pstmt.setInt(1, A.get_user_ID(email));
                                ResultSet rs = pstmt.executeQuery();
                                
                                boolean hasApplications = false;
                                while (rs.next()) {
                                    hasApplications = true;
                        %>
                        <tr>
                            <td><%= rs.getInt("application_ID") %></td>
                            <td><%= rs.getInt("posting_ID") %></td>
                            <td><%= rs.getInt("account_ID") %></td>
                            <td><%= rs.getDate("application_date") %></td>
                            <td><%= rs.getString("status") %></td>
                        </tr>
                        <% 
                                }
                                rs.close();
                                pstmt.close();
                                conn.close();
                                
                                if (!hasApplications) {
                        %>
                        <tr>
                            <td colspan="5">No job applications found.</td>
                        </tr>
                        <% 
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <a href="user_homepage.jsp" class="back-button">Back to User Homepage</a>
        </div>
    </body>
</html>
