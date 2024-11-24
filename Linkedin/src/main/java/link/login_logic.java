/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package link;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author julia
 */
public class login_logic {
    public String companyName;
    public String companyPassword;
    public String userName;
    public String userPassword;
    public int login(){
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
            sql = "SELECT * FROM companies WHERE company_name = ? AND company_password = ?";
                statement = conn.prepareStatement(sql);
                statement.setString(1, companyName);
                statement.setString(2, companyPassword);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()){
                resultSet.close();
                statement.close();
                conn.close();
                return 2;
            }
            System.out.println("Welcome, " + companyName + "!");
            sql = "SELECT * FROM user_accounts WHERE email = ? AND user_password = ?";
                statement = conn.prepareStatement(sql);
                statement.setString(1, userName);
                statement.setString(2, userPassword);
            resultSet = statement.executeQuery();
            if (resultSet.next()){
                resultSet.close();
                statement.close();
                conn.close();
                return 1;
            }
            System.out.println("Welcome, " + userName + "!");
                System.out.println("Invalid company name or password. Please try again.");
            resultSet.close();
            statement.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
        return 0;
    }
    public int get_company_ID(String companyName){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789"); 
            PreparedStatement getCompanyID = conn.prepareStatement("SELECT company_ID FROM companies WHERE company_name = ?");
            getCompanyID.setString(1, companyName);
            ResultSet rsCompany = getCompanyID.executeQuery();
            int companyID = 0;
            if (rsCompany.next()) {
                companyID = rsCompany.getInt("company_ID");
                rsCompany.close();
                getCompanyID.close();
                return companyID;
            }
            rsCompany.close();
            getCompanyID.close();
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
        return 0;
    }
    public int get_user_ID(String userEmail){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/group3s15?useSSL=false&serverTimezone=UTC", "root", "123456789"); 
            PreparedStatement get_userID = conn.prepareStatement("SELECT account_ID FROM user_accounts WHERE email = ?");
            get_userID.setString(1, userEmail);
            ResultSet rs_user = get_userID.executeQuery();
            int user_ID = 0;
            if (rs_user.next()) {
                user_ID = rs_user.getInt("account_ID");
                rs_user.close();
                get_userID.close();
                return user_ID;
            }
            rs_user.close();
            get_userID.close();
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
        return 0;
    }
}
