<%-- 
    Document   : view_job_applications
    Created on : Nov 24, 2024, 9:43:06 AM
    Author     : julia
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="link.login_logic" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Job Applications</title>
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
            .action-button {
                padding: 5px 10px;
                background-color: #0044cc;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
            }
            .action-button:hover {
                background-color: #003399;
            }
            .action-button[disabled] {
                background-color: #ccc;
                cursor: not-allowed;
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
        <jsp:useBean id="A" class="link.login_logic" scope="session" />
        <div class="container">
            <h1>Job Applications</h1>
            <div class="scrollable-table">
                <table>
                    <thead>
                        <tr>
                            <th>Application ID</th>
                            <th>Posting ID</th>
                            <th>Account ID</th>
                            <th>Application Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789"); 
                                
                                // Get the company_ID of the logged-in user
                                String email = A.companyName;
                                int userCompanyID = A.get_company_ID(email);
                                PreparedStatement pstmt;
                                ResultSet rs;
                                System.out.println(userCompanyID);
                                // Query to get job applications for the same company_ID
                                pstmt = conn.prepareStatement(
                                    "SELECT ja.application_ID, ja.posting_ID, ja.account_ID, ja.application_date, ja.status " +
                                    "FROM job_applications ja " +
                                    "JOIN job_postings jp ON ja.posting_ID = jp.posting_ID " +
                                    "WHERE jp.company_ID = ?");
                                pstmt.setInt(1, userCompanyID);
                                rs = pstmt.executeQuery();
                                
                                boolean hasApplications = false;
                                while (rs.next()) {
                                    hasApplications = true;
                                    String status = rs.getString("status");
                        %>
                        <tr>
                            <td><%= rs.getInt("application_ID") %></td>
                            <td><%= rs.getInt("posting_ID") %></td>
                            <td><%= rs.getInt("account_ID") %></td>
                            <td><%= rs.getDate("application_date") %></td>
                            <td><%= status %></td>
                            <td>
                                <form action="update_application_status.jsp" method="POST" style="display:inline;">
                                    <input type="hidden" name="application_ID" value="<%= rs.getInt("application_ID") %>">
                                    <input type="hidden" name="status" value="Accepted">
                                    <button type="submit" class="action-button" <%= (status.equals("Accepted") || status.equals("Rejected")) ? "disabled" : "" %>>Accept</button>
                                </form>
                                <form action="update_application_status.jsp" method="POST" style="display:inline;">
                                    <input type="hidden" name="application_ID" value="<%= rs.getInt("application_ID") %>">
                                    <input type="hidden" name="status" value="Rejected">
                                    <button type="submit" class="action-button" <%= (status.equals("Accepted") || status.equals("Rejected")) ? "disabled" : "" %>>Reject</button>
                                </form>
                            </td>
                        </tr>
                        <% 
                                }
                                rs.close();
                                pstmt.close();
                                conn.close();
                                
                                if (!hasApplications) {
                        %>
                        <tr>
                            <td colspan="6">No job applications found.</td>
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
            <a href="company_homepage.jsp" class="back-button">Back to Company Homepage</a>
        </div>
    </body>
</html>
