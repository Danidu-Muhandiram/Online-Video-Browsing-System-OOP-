package AdminPackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/InsertServlet")
public class InsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String title = request.getParameter("title");
        String message = request.getParameter("message");

        boolean isSuccess = noticesControl.insertData(title, message);

        if (isSuccess) {
            // Redirect back to the ListNotices servlet to refresh the list
            response.sendRedirect("ListNotices?message=success");
        } else {
            // Redirect back to the ListNotices servlet with an error message
            response.sendRedirect("ListNotices?message=error");
        }
    }
}