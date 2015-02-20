import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class recordpage extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		String dia = request.getParameter("diagnosis");
		String fd= request.getParameter("from_date");
		String td= request.getParameter("to_date");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>RecordPage2</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"<H1>" +
			dia+"<br>"+"From "+ fd + " To "+td + 
			"</H1>\n" +
			"</BODY></HTML>");
	}
}
