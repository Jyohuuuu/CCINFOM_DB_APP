<%-- 
    Document   : apply_job
    Created on : Nov 24, 2024, 11:35:14 AM
    Author     : julia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.LocalDate" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Applying for a Job</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            h1 {
                color: #333;
            }
            .message {
                margin-top: 20px;
                font-size: 18px;
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
            }
            .back-button:hover {
                background-color: #bbb;
            }
        </style>
    </head>
    <body>
        <jsp:useBean id="A" class="link.login_logic" scope="session" />
        <div class="container">
            <h1>Applying for a Job</h1>
            <% 
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789"); 
                    
                    String userEmail = A.userName;
                    PreparedStatement pstmt = conn.prepareStatement("SELECT education, years_of_experience FROM user_accounts WHERE email = ?");
                    pstmt.setString(1, userEmail);
                    ResultSet rs = pstmt.executeQuery();
                    
                    String userEducation = "";
                    int userYoE = 0;
                    if (rs.next()) {
                        userEducation = rs.getString("education");
                        userYoE = rs.getInt("years_of_experience");
                    }
                    
                    rs.close();
                    pstmt.close();
                    
                    String jobEducationRequirement = request.getParameter("education_requirement");
                    int jobYoERequirement = Integer.parseInt(request.getParameter("years_of_experience_requirement"));
                    
                    boolean isEligible = false;
                    
                    switch (jobEducationRequirement) {
                        case "None":
                            if (userYoE >= jobYoERequirement) {
                                isEligible = true;
                            }
                            break;
                        case "High School":
                            if (!userEducation.equals("None") && userYoE >= jobYoERequirement) {
                                isEligible = true;
                            }
                            break;
                        case "Bachelors":
                            if ((userEducation.equals("Bachelors") || userEducation.equals("Masters") || userEducation.equals("PhD")) && userYoE >= jobYoERequirement) {
                                isEligible = true;
                            }
                            break;
                        case "Masters":
                            if ((userEducation.equals("Masters") || userEducation.equals("PhD")) && userYoE >= jobYoERequirement) {
                                isEligible = true;
                            }
                            break;
                        case "PhD":
                            if (userEducation.equals("PhD") && userYoE >= jobYoERequirement) {
                                isEligible = true;
                            }
                            break;
                    }
                    
                    if (isEligible) {
                        // Check if the user has already applied for this job
                        pstmt = conn.prepareStatement("SELECT COUNT(*) FROM job_applications WHERE posting_ID = ? AND account_ID = ?");
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("posting_ID")));
                        pstmt.setInt(2, A.get_user_ID(userEmail));
                        rs = pstmt.executeQuery();
                        rs.next();
                        int applicationCount = rs.getInt(1);
                        rs.close();
                        pstmt.close();
                        
                        if (applicationCount > 0) {
                            %>
                            <p class="message">You have already applied for this job.</p>
                            <%
                        } else {
                            // Insert application into job_applications table
                            pstmt = conn.prepareStatement("INSERT INTO job_applications (application_ID, posting_ID, account_ID, application_date, status) VALUES (?, ?, ?, ?, ?);");
                            PreparedStatement app_ID = conn.prepareStatement("SELECT COALESCE(MAX(application_ID), 0) + 1 AS newID FROM job_applications;");
                            ResultSet rst = app_ID.executeQuery();
                            int application_ID = 0;
                            if (rst.next()) {
                                application_ID = rst.getInt("newID");
                            }
                            rst.close();
                            app_ID.close();
                            
                            pstmt.setInt(1, application_ID);
                            pstmt.setInt(2, Integer.parseInt(request.getParameter("posting_ID")));
                            pstmt.setInt(3, A.get_user_ID(userEmail));
                            Date application_date = Date.valueOf(LocalDate.now());
                            pstmt.setDate(4, application_date);
                            pstmt.setString(5, "Applied");
                            pstmt.executeUpdate();
                            pstmt.close();
                            %>
                            <p class="message">You have successfully applied for the job.</p>
                            <%
                        }
                    } else {
                        %>
                        <p class="message">You do not meet the requirements for this job.</p>
                        <%
                    }
                    
                    conn.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            %>
            <a href="view_job_posting.jsp" class="back-button">Back</a>
        </div>
    </body>
</html>
