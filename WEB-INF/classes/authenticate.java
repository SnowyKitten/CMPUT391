import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;


public class authenticate extends HttpServlet {          

	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

        
            String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
            String m_driverName = "oracle.jdbc.driver.OracleDriver";

            String m_userName = "rtwong";
            String m_password = "rtwong1234";

            String queryString;
            String l_login;
            String l_password;
            
            Statement stmt;
            Connection m_con;

            String actual_pass = null;
            String print_out = null;
            String user_type = null;



            try {
                Class drvClass = Class.forName(m_driverName);
                DriverManager.registerDriver((Driver) drvClass.newInstance());
            } catch(Exception e) {
                System.err.print("ClassNotFoundException: ");
                System.err.println(e.getMessage());
            }
		
            l_login = request.getParameter("login");
	    l_password = request.getParameter("password");
            queryString = "select password, class from users u where u.user_name = '" + l_login + "'";
            try {
                m_con = DriverManager.getConnection(m_url, m_userName, m_password);
                stmt = m_con.createStatement();
                ResultSet rset = stmt.executeQuery(queryString);
                while(rset.next()) {
                    actual_pass = rset.getString(1);
                    user_type = rset.getString(2);
                }
                if (actual_pass.equals(l_password)) {
                    HttpSession session = request.getSession(true);
                    Cookie cookie = new Cookie("type", user_type);
                    response.addCookie(cookie);
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("login.jsp");
                }

                stmt.close();
                m_con.close();
            } catch(Exception e) {
                response.sendRedirect("login.jsp");
            }
	}

}
