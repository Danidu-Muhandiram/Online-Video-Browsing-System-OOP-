package AdminPackage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ListNotices")
public class ListNoticesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<notices> noticeList = new ArrayList<>();
        String message = request.getParameter("message");
        if (message != null) {
            request.setAttribute("feedbackMessage", message.equals("success") ? "Notice added successfully!" : "Error adding notice.");
        }

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id, title, message FROM notices")) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String messageText = rs.getString("message");
                notices notice = new notices(id, title, messageText);
                noticeList.add(notice);
            }

            request.setAttribute("notices", noticeList);
            request.getRequestDispatcher("notices.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load notices.");
            request.getRequestDispatcher("notices.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}