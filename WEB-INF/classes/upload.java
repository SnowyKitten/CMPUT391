import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

/**
 *  This servlet inserts a record into the rediology table:
 *
 *   radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, 		description)
 *
 *
 */

public class upload extends HttpServlet {
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
		String record_id = request.getParameter("record_id");
		String patient_id = request.getParameter("patient_id");
		String doctor_id = request.getParameter("doctor_id");
		String radiologist_id = request.getParameter("radiologist_id");
		String test_type = request.getParameter("test_type");
		String prescribing_date = request.getParameter("prescribing_date");
		String test_date = request.getParameter("test_date");
		String diagnosis = request.getParameter("diagnosis");
		String description = request.getParameter("description");

		try
		{
			Class drvClass=Class.forName(m_driverName);
			DriverManager.registerDriver((Driver) drvClass.newInstance());
		}catch(Exception e)
		{
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());
		}
		
		queryString= "insert into radiology_record values('" + record_id + "', '" + patient_id + "', '"+ doctor_id + "', '"+ radiologist_id +"', '" +  test_type +"', " + "TO_DATE("+"'"+prescribing_date+"', 'MM-DD-YYYY')"+", TO_DATE("+"'"+test_date+"', 'MM-DD-YYYY')" +",'"+diagnosis+"', '"+description+"')";

		try
		{
			m_con = DriverManager.getConnection(m_url, m_userName,m_password);
			stmt = m_con.createStatement();
			ResultSet rset = stmt.executeQuery(queryString);
			response_message = " Upgrade Complete! ";
			stmt.close();
			m_con.close();
		}catch(Exception ex){
			response_message = ex.getMessage();
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
		"Transitional//EN\">\n" +
		"<HTML>\n" +
		"<HEAD><TITLE>Asn2Sample</TITLE></HEAD>\n" +
		"<BODY>\n" +
		"<H1>" +
		response_message+
		"</H1>\n" +
                "<a href ='index.jsp'> Back Button</a>" + 
		"</BODY></HTML>");
	}
}
