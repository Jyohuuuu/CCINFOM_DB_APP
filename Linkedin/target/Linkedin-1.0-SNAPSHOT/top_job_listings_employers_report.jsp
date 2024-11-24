<%-- 
    Document   : top_job_listings_employers_report
    Created on : Nov 24, 2024, 5:17:16 PM
    Author     : julia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Top Job Listings & Employers Report</title>
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
            <h1>Top Job Listings & Employers Report</h1>
            <div class="scrollable-table">
                <table>
                    <thead>
                        <tr>
                            <th>Company ID</th>
                            <th>Company Name</th>
                            <th>Total Applications</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789"); 
                                PreparedStatement pstmt = conn.prepareStatement(
                                    "SELECT jp.company_ID, c.company_name, COUNT(ja.application_ID) AS total_applications " +
                                    "FROM job_postings jp " +
                                    "LEFT JOIN job_applications ja ON jp.posting_ID = ja.posting_ID " +
                                    "LEFT JOIN companies c ON jp.company_ID = c.company_ID " +
                                    "GROUP BY jp.company_ID, c.company_name " +
                                    "ORDER BY total_applications DESC");
                                ResultSet rs = pstmt.executeQuery();
                                
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("company_ID") %></td>
                            <td><%= rs.getString("company_name") %></td>
                            <td><%= rs.getInt("total_applications") %></td>
                        </tr>
                        <% 
                                }
                                rs.close();
                                pstmt.close();
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <a href="generate_reports.jsp" class="back-button">Back to Reports</a>
        </div>
    </body>
</html>
