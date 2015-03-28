import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;


public class logout extends HttpServlet {          

	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

            session.removeAttribute("class");
            session.removeAttribute("pid");

            response.setHeader("Refresh", "3;url=login.jsp");

	}

}
