<%-- 
    Document   : generate_reports
    Created on : Nov 24, 2024, 5:01:51 PM
    Author     : julia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Generate Reports</title>
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
                width: 400px;
            }
            h1 {
                color: #333;
                margin-bottom: 20px;
            }
            .button {
                display: block;
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                background-color: #0044cc;
                color: white;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
                font-size: 16px;
            }
            .button:hover {
                background-color: #003399;
            }
            .back-button {
                display: block;
                width: 100%;
                padding: 12px;
                margin-top: 20px;
                background-color: #ccc;
                color: black;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
                font-size: 16px;
            }
            .back-button:hover {
                background-color: #bbb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Generate Reports</h1>
            <a href="account_registration_status_report.jsp" class="button">Account Registration & Status Report</a>
            <a href="job_application_report.jsp" class="button">Job Application Report</a>
            <a href="status_expiry_report.jsp" class="button">Status and Expiry Report</a>
            <a href="top_job_listings_employers_report.jsp" class="button">Top Job Listings & Employers Report</a>
            <a href="index.html" class="back-button">Back to Login</a>
        </div>
    </body>
</html>
