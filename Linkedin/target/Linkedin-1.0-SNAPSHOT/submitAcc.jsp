<%-- 
    Document   : submitAcc
    Created on : Nov 24, 2024, 5:34:28 AM
    Author     : julia
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,link.*,java.time.LocalDate,java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Submission</title>
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
        <jsp:useBean id="B" class="link.UserAccount_Record_Management" scope="request" />
        <%
            String first_name = request.getParameter("first_name");
            String last_name = request.getParameter("last_name");
            String contact_no = request.getParameter("contact_no");
            String email = request.getParameter("email");
            String home_address = request.getParameter("home_address");
            String birthday = request.getParameter("birthday");
            String education = request.getParameter("education");
            String years_of_experience = request.getParameter("years_of_experience");
            String primary_language = request.getParameter("primary_language");
            String job_ID = request.getParameter("job_ID");
            String company_ID = request.getParameter("company_ID");
            String password = request.getParameter("password");
            B.first_name = String.valueOf(first_name);
            B.last_name = String.valueOf(last_name);
            B.email = String.valueOf(email);
            B.primary_language = String.valueOf(primary_language);
            B.userpassword = String.valueOf(password);
            B.birthday = String.valueOf(birthday);
            if (contact_no == null || contact_no.isEmpty()) {
                contact_no = null;
            } else {
                B.contact_no = contact_no;
            }
            if (home_address == null || home_address.isEmpty()) {
                B.home_address = null;
            } else {
                B.home_address = home_address;
            }
            if (education == null || education.isEmpty()) {
                B.education = null;
            } else {
                B.education = education;
            }
            if (years_of_experience == null || years_of_experience.isEmpty()) {
                B.years_of_experience = -1;
            } else {
                B.years_of_experience = Integer.parseInt(years_of_experience);
            }
            if (job_ID == null || job_ID.isEmpty()) {
                B.job_ID = -1;
            } else {
                B.job_ID = Integer.parseInt(job_ID);
            }
            if (company_ID == null || company_ID.isEmpty()) {
                B.company_ID = -1;
            } else {
                B.company_ID = Integer.parseInt(company_ID);
            }
            int result = B.register_account();
        %>
        <div class="container">
            <%
                if (result == 1) {
            %>
                <h1>Account Successfully Created</h1>
                <p>Your account has been successfully created.</p>
            <% 
                } else {
            %>
                <h1>Account Creation Failed</h1>
                <p>There was an error creating your account. Please try again.</p>
            <% 
                }
            %>
            <a href="index.html" class="back-button">Back to Login</a>
        </div>
    </body>
</html>
