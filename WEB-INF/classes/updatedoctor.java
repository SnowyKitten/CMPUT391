import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class updatedoctor extends HttpServlet {
	public String response_message;
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		//database
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		String m_driverName = "oracle.jdbc.driver.OracleDriver";
		String user="rtwong";
		String pass="rtwong1234";
		Connection m_con;
		String queryString;
		String insertString1;
		Statement stmt;
		ResultSet rs;
		String answer="";
		
		//make sql statemtn to get information
		String createString = "SELECT doctor_id, patient_id from family_doctor"; 

				System.out.println(createString);
		try
       		{

              		Class drvClass = Class.forName(m_driverName);
              		DriverManager.registerDriver((Driver)
              		drvClass.newInstance());

       		} catch(Exception e)
       		{

              		System.err.print("ClassNotFoundException: ");
              		System.err.println(e.getMessage());
       		}
		
		//execute statement
		try
       		{

             		m_con = DriverManager.getConnection(m_url,user,
              		pass);

              		stmt = m_con.createStatement();
              		rs = stmt.executeQuery(createString);

			while (rs.next()){
			System.out.println("X");
			String doctorid= rs.getString("doctor_id");
			String patientid= rs.getString("patient_id");

			answer=answer+"<tr> <td>"+doctorid+"</td> <td>"+patientid+"</td> </tr>";
			}
		

              		stmt.close();
             		m_con.close();

		//print error
       		} catch(SQLException ex) {

              		System.err.println("SQLException: " +
              		ex.getMessage());

       		}

		//write information to table and get input in html
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>RecordPage2</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"<table border=\"1\" style=\"width:100%\">\n"+
			"<tr> <td> <b> Doctor ID </b> </td> <td> <b> Patient ID </b> </td> </tr>\n");
		out.println(answer+"</table>");
		out.println("<form name=\"updatedoctorsubmit\" method=\"post\" action=\"updatedoctorsubmit\"><table><tr><th>Enter Current Doctor ID: </th><td><input name=\"doctoridc\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");


out.println("<tr><th>Enter New Doctor ID: </th><td><input name=\"doctoridn\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<tr><th>Enter Current Patient ID: </th><td><input name=\"patientidc\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<tr><th>Enter New Patient ID: </th><td><input name=\"patientidn\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<td ALIGN=CENTER COLSPAN=\"2\"><input type=\"submit\" name=\".submit\" value=\"Enter\"></td></tr></table></form>");  
		out.println("</H1>\n"+"</BODY></HTML>");

		

	}
}












