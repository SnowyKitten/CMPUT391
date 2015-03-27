import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;


public class logout extends HttpServlet {          

	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

            Cookie cookie = new Cookie("type", "");
            response.addCookie(cookie);
            response.sendRedirect("login.jsp");

	}

}
