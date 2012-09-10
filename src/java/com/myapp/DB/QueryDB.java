package com.myapp.DB;

/*
 * To change this template, choose Tools | Templates and open the template in
 * the editor.
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author pradeep
 */
public class QueryDB {

    private static PreparedStatement pst = null;
    private static Connection con = null;
    static String result;
    private static ResultSet rest = null;

    public static Connection getconnection() {
        try {

            String url = "jdbc:mysql://localhost/paginationdb";
            String user = "root";
            String password = "root";
            String driver = "com.mysql.jdbc.Driver";
           

            Class.forName(driver);
                 con = DriverManager.getConnection(url,user,password);

        } catch (SQLException ex) {
            System.out.println("Sql Exception::" + ex.getMessage());
            return null;

        } catch (ClassNotFoundException ex) {
            System.out.println("Class NOt Found Exception::" + ex.getMessage());
            return null;
        }
        return con;

    }

    public static ResultSet SelectQuery(String Query) throws SQLException {

        con = getconnection();
        pst = con.prepareStatement(Query);
        rest = pst.executeQuery();
        return rest;
    }

    public static String query(String Query) throws SQLException {
        try {
            con = getconnection();
    
            pst = con.prepareStatement(Query);
            int numRowsChanged = pst.executeUpdate();
             
            if (numRowsChanged != 0) {
                result = "success";
            } else {
                result = "Failed";
            }
        } catch (Exception ae) {
            result = "Failed";
            System.out.println("Error is:" + ae.getMessage());
        }

        return result;
    }

    /**
     *
     *
     *
     * @param getUpdate
     * @return
     * @throws SQLException
     */
    public static int getUpdate(String Query){
        int numRowsChanged = 0;
        try {
            con = getconnection();
            pst = con.prepareStatement(Query);
            numRowsChanged = pst.executeUpdate();
        } catch (Exception ae) {
            numRowsChanged = 0;
            System.out.println("Error is:" + ae.getMessage());
        }
        return numRowsChanged;
    }

    public static void releseResources() throws Exception {
        pst.close();
        rest.close();
        con.close();

    }
}
