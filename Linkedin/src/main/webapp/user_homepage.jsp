<%-- 
    Document   : user_homepage
    Created on : Nov 24, 2024, 9:47:18 AM
    Author     : julia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Home Page</title>
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
            .button {
                display: inline-block;
                padding: 10px 20px;
                margin: 10px;
                background-color: #0044cc;
                color: white;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .button:hover {
                background-color: #003399;
            }
            .back-button {
                display: inline-block;
                padding: 10px 20px;
                margin: 10px;
                background-color: #ccc;
                color: black;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .back-button:hover {
                background-color: #bbb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <jsp:useBean id="A" class="link.login_logic" scope="session" />
            <%
                String userName = A.userName;
            %>
            <h1>Welcome, <%= userName %>!</h1>
            <a href="view_job_posting.jsp" class="button">View Job Postings</a>
            <a href="view_user_job_applications.jsp" class="button">View Job Applications</a>
            <a href="index.html" class="back-button">Back to Login</a>
        </div>
    </body>
</html>
