<%-- 
    Document   : update_application_status
    Created on : Nov 24, 2024, 4:07:36 PM
    Author     : julia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Application Status</title>
    </head>
    <body>
        <%
            String applicationID = request.getParameter("application_ID");
            String status = request.getParameter("status");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789");

                // Update the application status
                PreparedStatement pstmt = conn.prepareStatement("UPDATE job_applications SET status = ? WHERE application_ID = ?");
                pstmt.setString(1, status);
                pstmt.setInt(2, Integer.parseInt(applicationID));
                int rowsUpdated = pstmt.executeUpdate();
                pstmt.close();

                if (rowsUpdated > 0) {
                    if ("Accepted".equals(status)) {
                        pstmt = conn.prepareStatement("SELECT account_ID, posting_ID FROM job_applications WHERE application_ID = ?");
                        pstmt.setInt(1, Integer.parseInt(applicationID));
                        ResultSet rs = pstmt.executeQuery();
                        int accountID = 0;
                        int postingID = 0;
                        if (rs.next()) {
                            accountID = rs.getInt("account_ID");
                            postingID = rs.getInt("posting_ID");
                        }
                        rs.close();
                        pstmt.close();

                        pstmt = conn.prepareStatement("SELECT company_ID, branch_ID, position_ID FROM job_postings WHERE posting_ID = ?");
                        pstmt.setInt(1, postingID);
                        rs = pstmt.executeQuery();
                        int companyID = 0;
                        int branchID = 0;
                        int positionID = 0;
                        if (rs.next()) {
                            companyID = rs.getInt("company_ID");
                            branchID = rs.getInt("branch_ID");
                            positionID = rs.getInt("position_ID");
                        }
                        rs.close();
                        pstmt.close();

                        // Create a new job
                        pstmt = conn.prepareStatement("INSERT INTO jobs (job_ID, position_ID, company_ID, branch_ID) VALUES (?, ?, ?, ?)");
                        PreparedStatement jobIDStmt = conn.prepareStatement("SELECT COALESCE(MAX(job_ID), 0) + 1 AS newID FROM jobs");
                        ResultSet jobIDRs = jobIDStmt.executeQuery();
                        int newJobID = 0;
                        if (jobIDRs.next()) {
                            newJobID = jobIDRs.getInt("newID");
                        }
                        jobIDRs.close();
                        jobIDStmt.close();

                        pstmt.setInt(1, newJobID);
                        pstmt.setInt(2, positionID);
                        pstmt.setInt(3, companyID);
                        pstmt.setInt(4, branchID);
                        pstmt.executeUpdate();
                        pstmt.close();

                        // Update the user's company_ID and job_ID
                        pstmt = conn.prepareStatement("UPDATE user_accounts SET company_ID = ?, job_ID = ? WHERE account_ID = ?");
                        pstmt.setInt(1, companyID);
                        pstmt.setInt(2, newJobID);
                        pstmt.setInt(3, accountID);
                        pstmt.executeUpdate();
                        pstmt.close();

                        %>
                        <p>The application has been accepted, a new job has been created, and the user's information has been updated.</p>
                        <%
                    } else if ("Rejected".equals(status)) {
                        %>
                        <p>The application has been rejected.</p>
                        <%
                    }
                } else {
                    %>
                    <p>Failed to update the application status.</p>
                    <%
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                %>
                <p>Error: <%= e.getMessage() %></p>
                <%
            }
        %>
        <a href="view_job_applications.jsp">Back to Job Applications</a>
    </body>
</html>
