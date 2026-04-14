package login_servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

@WebServlet("/test")
public class test extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        try {
            // Load Driver
            Class.forName("org.postgresql.Driver");

            // Connect DB
            Connection con = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/attendance_db",
                "matrix",   // change if needed
                "1234"        // change if needed
            );

            if (con != null) {
                response.getWriter().println("<h2 style='color:green;'>✅ DB CONNECTED SUCCESSFULLY</h2>");
            } else {
                response.getWriter().println("<h2 style='color:red;'>❌ DB CONNECTION FAILED</h2>");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();

            response.getWriter().println("<h2 style='color:red;'>❌ ERROR:</h2>");
            response.getWriter().println("<pre>" + e.getMessage() + "</pre>");
        }
    }
}