import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RecordPage extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		String dia = request.getParameter("Diagnosis");
		String fd= request.getParameter("FromDate");
		String td= request.getParameter("ToDate");
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
