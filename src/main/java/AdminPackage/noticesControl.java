package AdminPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class noticesControl {

    public static boolean insertData(String title, String message) {
        boolean isSuccess = false;

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                System.out.println("Connection is null!");
                return false;
            }

            String sql = "INSERT INTO notices (title, message) VALUES (?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, message);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
                System.out.println("Notice inserted successfully.");
            } else {
                System.out.println("Error: Failed to insert notice.");
            }

        } catch (Exception e) {
            System.out.println("Error during database insertion:");
            e.printStackTrace();
        }

        return isSuccess;
    }
    
    //update data
    public static boolean updatedata(int id, String title, String message) {
        boolean isSuccess = false;
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                System.out.println("Connection is null!");
                return false;
            }

            String sql = "UPDATE notices SET title = ?, message = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, message);
            ps.setInt(3, id);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
                System.out.println("Notice updated successfully. ID: " + id);
            } else {
                System.out.println("Error: Failed to update notice. ID: " + id);
            }

        } catch (Exception e) {
            System.out.println("Error during database update:");
            e.printStackTrace();
        }
        return isSuccess;
    }
}
