package AdminPackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String title = request.getParameter("title");
        String message = request.getParameter("message");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                boolean isSuccess = noticesControl.updatedata(id, title, message);

                if (isSuccess) {
                    response.sendRedirect("ListNotices?message=update_success");
                } else {
                    response.sendRedirect("ListNotices?message=update_error");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("ListNotices?message=invalid_id");
            }
        } else {
            response.sendRedirect("ListNotices?message=missing_id");
        }
    }
}