import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class authenticate extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		String login = request.getParameter("login");
		String password = request.getParameter("password");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>Temp Authentication Page</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"<H1>" +
			login +
			password + 
			"</H1>\n" +
			"</BODY></HTML>");
	}
}
