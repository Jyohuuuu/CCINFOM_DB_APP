<%-- 
    Document   : view_job_posting
    Created on : Nov 24, 2024, 10:52:28 AM
    Author     : julia
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Job Postings</title>
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
            .apply-button {
                padding: 5px 10px;
                background-color: #0044cc;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
            }
            .apply-button:hover {
                background-color: #003399;
            }
            .apply-button[disabled] {
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
            <h1>Job Postings</h1>
            <div class="scrollable-table">
                <table>
                    <thead>
                        <tr>
                            <th>Posting ID</th>
                            <th>Position</th>
                            <th>Company</th>
                            <th>Location</th>
                            <th>Education Requirement</th>
                            <th>Years of Experience</th>
                            <th>Posting Date</th>
                            <th>Expiry Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789"); 
                                String query = "SELECT jp.posting_ID, jp.position_ID, jp.company_ID, jp.branch_ID, rjp.position_name, c.company_name, b.location, jp.education_requirement, jp.years_of_experience_requirement, jp.posting_date, jp.expiry_date, jp.status " +
                                               "FROM job_postings jp " +
                                               "JOIN REF_job_position rjp ON jp.position_ID = rjp.position_ID " +
                                               "JOIN companies c ON jp.company_ID = c.company_ID " +
                                               "JOIN branches b ON jp.branch_ID = b.branch_ID";
                                PreparedStatement pstmt = conn.prepareStatement(query);
                                ResultSet rs = pstmt.executeQuery();
                                
                                while (rs.next()) {
                                    String status = rs.getString("status");
                        %>
                        <tr>
                            <td><%= rs.getInt("posting_ID") %></td>
                            <td><%= rs.getString("position_name") %></td>
                            <td><%= rs.getString("company_name") %></td>
                            <td><%= rs.getString("location") %></td>
                            <td><%= rs.getString("education_requirement") %></td>
                            <td><%= rs.getInt("years_of_experience_requirement") %></td>
                            <td><%= rs.getDate("posting_date") %></td>
                            <td><%= rs.getDate("expiry_date") %></td>
                            <td><%= status %></td>
                            <td>
                                <form action="apply_job.jsp" method="POST">
                                    <input type="hidden" name="posting_ID" value="<%= rs.getInt("posting_ID") %>">
                                    <input type="hidden" name="position_ID" value="<%= rs.getInt("position_ID") %>">
                                    <input type="hidden" name="company_ID" value="<%= rs.getInt("company_ID") %>">
                                    <input type="hidden" name="branch_ID" value="<%= rs.getInt("branch_ID") %>">
                                    <input type="hidden" name="education_requirement" value="<%= rs.getString("education_requirement") %>">
                                    <input type="hidden" name="years_of_experience_requirement" value="<%= rs.getInt("years_of_experience_requirement") %>">
                                    <input type="hidden" name="posting_date" value="<%= rs.getDate("posting_date") %>">
                                    <input type="hidden" name="expiry_date" value="<%= rs.getDate("expiry_date") %>">
                                    <input type="hidden" name="status" value="<%= status %>">
                                    <button type="submit" class="apply-button" 
                                        <% if (status.equals("Closed") || status.equals("Expired")) { %> 
                                            disabled 
                                        <% } %>
                                    >Apply</button>
                                </form>
                            </td>
                        </tr>
                        <% 
                                }
                                rs.close();
                                pstmt.close();
                                conn.close();
                            } catch (Exception e) {
                                System.out.println(e.getMessage());
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <a href="user_homepage.jsp" class="back-button">Back to User Homepage</a>
        </div>
    </body>
</html>