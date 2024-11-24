/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package link;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
/**
 *
 * @author julia
 */
public class job_posting {
    public int posting_ID;
    public int position_ID;
    public int branch_ID;
    public int company_ID;
    public String education_requirement ;
    public String status;
    public int yoE;
    
    public int post_job(){
        try {
            String sql;
            PreparedStatement statement;
            Connection conn;
            Class.forName("com.mysql.cj.jdbc.Driver");
            String user = "root";
            String password = "123456789";
            String url = "jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC";
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("SELECT COALESCE(MAX(posting_ID), 0) + 1 AS newID FROM job_postings;");
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()){
                posting_ID = rst.getInt("newID");
            }
            pstmt = conn.prepareStatement("INSERT INTO job_postings (posting_ID, position_ID, company_ID, branch_ID, education_requirement, years_of_experience_requirement, posting_date, expiry_date, status) VALUES (?,?,?,?,?,?,?,?,?)");
            pstmt.setInt(1, posting_ID);
            pstmt.setInt(2, position_ID);
            pstmt.setInt(3, company_ID);
            pstmt.setInt(4, branch_ID);
            pstmt.setString(5,education_requirement);
            pstmt.setInt(6, yoE);
            Date postingDate = Date.valueOf(LocalDate.now());
            pstmt.setDate(7, postingDate);
            LocalDate expiryLocalDate = LocalDate.now().plusMonths(1);
            Date expiryDate = Date.valueOf(expiryLocalDate);
            pstmt.setDate(8, expiryDate);
            pstmt.setString(9,"Active");
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return 1;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return 0;
    }
    public int view_job_postings(){
        try {
            String sql;
            PreparedStatement statement;
            Connection conn;
            Class.forName("com.mysql.cj.jdbc.Driver");
            String user = "root";
            String password = "123456789";
            String url = "jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC";
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connection Successful");
            
        } catch (Exception e){
            System.out.println("Error: " + e.getMessage());
        }
        return 0;
    }
}
