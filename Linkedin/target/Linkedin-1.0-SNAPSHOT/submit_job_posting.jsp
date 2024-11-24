<%-- 
    Document   : submit_job_posting
    Created on : Nov 24, 2024, 8:32:14 AM
    Author     : julia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Submit Job Posting</title>
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
        <jsp:useBean id="job" class="link.job_posting" scope="session" />
        <jsp:useBean id="A" class="link.login_logic" scope="session" />
        <%
            String position_ID = request.getParameter("position_ID");
            String educationRequirement = request.getParameter("educationRequirement");
            String yearsOfExperience = request.getParameter("yearsOfExperience");
            String branchID = request.getParameter("branchID");
            String companyName = A.companyName;
            String yoE = request.getParameter("yearsOfExperience");
            int company_ID = A.get_company_ID(companyName);
            System.out.println(position_ID);
            System.out.println(educationRequirement);
            System.out.println(yearsOfExperience);
            System.out.println(branchID);
            job.position_ID = Integer.parseInt(position_ID);
            job.company_ID = company_ID;
            job.education_requirement = String.valueOf(educationRequirement);
            job.branch_ID = Integer.parseInt(branchID);
            job.yoE = Integer.parseInt(yoE);
            int result = job.post_job();
        %>
        <div class="container">
            <%
                if (result == 1) {
            %>
                <h1>Job Posting Successfully Created</h1>
                <p>Your job posting has been successfully created.</p>
            <% 
                } else {
            %>
                <h1>Job Posting Creation Failed</h1>
                <p>There was an error creating your job posting. Please try again.</p>
            <% 
                }
            %>
            <a href="company_homepage.jsp" class="back-button">Back to Company Homepage</a>
        </div>
    </body>
</html>
