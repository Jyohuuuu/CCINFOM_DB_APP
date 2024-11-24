<%-- 
    Document   : create_job_posting
    Created on : Nov 24, 2024, 5:34:28 AM
    Author     : julia
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Job Posting</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 0;
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
            .form-group {
                margin: 15px 0;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            .form-group input, .form-group select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .form-group input[type="number"] {
                width: auto;
            }
            .form-group button {
                padding: 10px 20px;
                background-color: #0044cc;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .form-group button:hover {
                background-color: #003399;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Create Job Posting</h1>
            <form action="submit_job_posting.jsp" method="POST">
                <div class="form-group">
                    <label for="position-id">Job Position</label>
                    <select id="position-id" name="position_ID" required>
                        <option value="">Select a position</option>
                        <% 
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789");
                                PreparedStatement pstmt = conn.prepareStatement("SELECT position_ID, position_name FROM REF_job_position");
                                ResultSet rs = pstmt.executeQuery();
                                while (rs.next()) {
                        %>
                        <option value="<%= rs.getInt("position_ID") %>"><%= rs.getString("position_name") %></option>
                        <% 
                                }
                                rs.close();
                                pstmt.close();
                                conn.close();
                            } catch (Exception e) {
                                System.out.println(e.getMessage());
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="educationRequirement">Education Requirement</label>
                    <select id="educationRequirement" name="educationRequirement" required>
                        <option value="None">None</option>
                        <option value="High School">High School</option>
                        <option value="Bachelors">Bachelors</option>
                        <option value="Masters">Masters</option>
                        <option value="PhD">PhD</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="yearsOfExperience">Required Years of Experience</label>
                    <input type="number" id="yearsOfExperience" name="yearsOfExperience" placeholder="Enter required years of experience" required>
                </div>
                <div class="form-group">
                    <label for="branchID">Branch ID</label>
                    <select id="branchID" name="branchID" required>
                        <option value="">Select a branch</option>
                        <jsp:useBean id="A" class="link.login_logic" scope="session" />
                        <% 
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789"); 
                                String companyName = A.companyName;
                                PreparedStatement getCompanyID = conn.prepareStatement("SELECT company_ID FROM companies WHERE company_name = ?");
                                getCompanyID.setString(1, companyName);
                                ResultSet rsCompany = getCompanyID.executeQuery();
                                int companyID = 0;
                                if (rsCompany.next()) {
                                    companyID = rsCompany.getInt("company_ID");
                                }
                                rsCompany.close();
                                getCompanyID.close();

                                PreparedStatement pstmt = conn.prepareStatement("SELECT branch_ID, location FROM branches WHERE company_ID = ?");
                                pstmt.setInt(1, companyID);
                                ResultSet rs = pstmt.executeQuery();
                                while (rs.next()) {
                        %>
                        <option value="<%= rs.getInt("branch_ID") %>"><%= rs.getString("location") %></option>
                        <% 
                                }
                                rs.close();
                                pstmt.close();
                                conn.close();
                            } catch (Exception e) {
                                System.out.println(e.getMessage());
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <button type="submit">Submit</button>
                </div>
            </form>
        </div>
    </body>
</html>
