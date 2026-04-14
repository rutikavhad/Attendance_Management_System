package login_servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.time.LocalTime;
import java.time.Duration;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int empId = Integer.parseInt(request.getParameter("employee_id"));
        String action = request.getParameter("action");

        try {
            Class.forName("org.postgresql.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/attendance_db",
                "matrix",
                "1234"
            );

            // Check today's record
            String checkQuery = "SELECT * FROM attendance WHERE employee_id=? AND date=CURRENT_DATE";
            PreparedStatement checkPs = con.prepareStatement(checkQuery);
            checkPs.setInt(1, empId);
            ResultSet rs = checkPs.executeQuery();

            // Standard times
            LocalTime officeStart = LocalTime.of(10, 0);
            LocalTime officeEnd = LocalTime.of(17, 0);

            if(action.equals("checkin")) {

                if(rs.next()) {
                    response.getWriter().println("Already Checked In ❌");
                    return;
                }

                LocalTime now = LocalTime.now();

                int lateMinutes = 0;
                String status = "Present";

                if(now.isAfter(officeStart)) {
                    lateMinutes = (int) Duration.between(officeStart, now).toMinutes();
                    status = "Late";
                }

                String insert = "INSERT INTO attendance(employee_id, check_in, late_minutes, status) VALUES(?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(insert);
                ps.setInt(1, empId);
                ps.setTime(2, Time.valueOf(now));
                ps.setInt(3, lateMinutes);
                ps.setString(4, status);

                ps.executeUpdate();

                response.getWriter().println("Check-In Done ✅");

            } else if(action.equals("checkout")) {

                if(!rs.next()) {
                    response.getWriter().println("No Check-In Found ❌");
                    return;
                }

                LocalTime now = LocalTime.now();

                int earlyMinutes = 0;
                String status = rs.getString("status");

                if(now.isBefore(officeEnd)) {
                    earlyMinutes = (int) Duration.between(now, officeEnd).toMinutes();

                    if(status.equals("Late")) {
                        status = "Late + Early";
                    } else {
                        status = "Early Leave";
                    }
                }

                String update = "UPDATE attendance SET check_out=?, early_leave_minutes=?, status=? WHERE employee_id=? AND date=CURRENT_DATE";
                PreparedStatement ps = con.prepareStatement(update);

                ps.setTime(1, Time.valueOf(now));
                ps.setInt(2, earlyMinutes);
                ps.setString(3, status);
                ps.setInt(4, empId);

                ps.executeUpdate();

                response.getWriter().println("Check-Out Done ✅");
            }

            con.close();

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("DB Error: " + e.getMessage());
        }
    }
}