import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class photo extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		String record_id = request.getParameter("record_id");
		String patient_id = request.getParameter("patient_id");
		String doctor_id = request.getParameter("doctor_id");
		String radiologist_id = request.getParameter("radiologist_id");

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>Asn2Sample</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"<H1>" +
			"insert into radiology_record values('" + record_id + "', '" + patient_id + "', '"+ doctor_id + "', '"+ radiologist_id + "'"+
			"</H1>\n" +
			"</BODY></HTML>");
	}
}
