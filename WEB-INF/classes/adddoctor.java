import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class adddoctor extends HttpServlet {
	public String response_message;
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		//database
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		String m_driverName = "oracle.jdbc.driver.OracleDriver";
		String m_userName = "rtwong";
		String m_password = "rtwong1234";
		Connection m_con;
		String queryString;
		String insertString1;
		Statement stmt;
		//get input		
		String doctorid = request.getParameter("doctorid");
		String patientid = request.getParameter("patientid");

		try
		{
			Class drvClass=Class.forName(m_driverName);
			DriverManager.registerDriver((Driver) drvClass.newInstance());
		}catch(Exception e)
		{
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());
		}


		queryString= "insert into family_doctor values('" + doctorid + "', '" + patientid + "')";

		try{
		m_con = DriverManager.getConnection(m_url, m_userName,m_password);
		stmt = m_con.createStatement();
		ResultSet rset = stmt.executeQuery(queryString);


		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>adddoctor</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"SUCCESS\n");
		out.println("</H1>\n"+"</BODY></HTML>");


		}catch(Exception ex){


			
			System.err.println("SQLException: " +
              		ex.getMessage());
			
			System.out.println("\n\n"+queryString);

			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>RecordPage2</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"ERROR <br> <br>" + ex.getMessage() + "\n");
		out.println("</H1>\n"+"</BODY></HTML>");
	}
}
}













