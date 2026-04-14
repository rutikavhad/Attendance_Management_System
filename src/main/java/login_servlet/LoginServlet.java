package login_servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        try {
            // Load Driver
            Class.forName("org.postgresql.Driver");

            // Connect DB
            Connection con = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/attendance_db",
                "matrix",   // change if needed
                "1234"        // change if needed
            );

            // Query
            String sql = "SELECT * FROM admin WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // SUCCESS
                HttpSession session = request.getSession();
                session.setAttribute("user", email);

                response.sendRedirect("dashboard.jsp");

            } else {
                // FAIL
                response.sendRedirect("login.jsp?error=1");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("DB ERROR: " + e.getMessage());
        }
    }
}