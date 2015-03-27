import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class updateperson extends HttpServlet {
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

		String createString = "SELECT person_id, first_name, last_name, address, email, phone from persons"; 

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
		
		try
       		{

             		m_con = DriverManager.getConnection(m_url,user,
              		pass);

              		stmt = m_con.createStatement();
              		rs = stmt.executeQuery(createString);

			while (rs.next()){
			System.out.println("X");
			String firstname= rs.getString("first_name");
			String lastname= rs.getString("last_name");
			String person_id= rs.getString("person_id");
			String address= rs.getString("address");
			String email= rs.getString("email");
			String phone= rs.getString("phone");

			answer=answer+"<tr> <td>"+person_id+"</td> <td>"+firstname+"</td> <td>"+lastname+"</td> <td>"+address+"</td> <td>"+email+"</td> <td>"+phone+"</td> </tr>";
			}
		

              		stmt.close();
             		m_con.close();

       		} catch(SQLException ex) {

              		System.err.println("SQLException: " +
              		ex.getMessage());

       		}


		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>RecordPage2</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"<table border=\"1\" style=\"width:100%\">\n"+
			"<tr> <td> <b> Person ID </b> </td> <td> <b> First Name </b> </td> <td> <b> Last Name</b> </td> <td> <b> Address </b> </td> <td> <b> Email ID </b> </td> <td> <b> Phone </b> </td> </tr>\n");
		out.println(answer+"</table>");
		out.println("<form name=\"updatepersonsubmit\" method=\"post\" action=\"updatepersonsubmit\"><table><tr><th>Enter Person ID: </th><td><input name=\"person_id\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<tr><th>Enter First Name: </th><td><input name=\"firstname\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<tr><th>Enter Last Name: </th><td><input name=\"lastname\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<tr><th>Enter Address: </th><td><input name=\"address\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<tr><th>Enter Email: </th><td><input name=\"email\" type=\"text\" size=\"30\" value=\"\"></input></td></tr><tr><tr><th>Enter Phone: </th><td><input name=\"phone\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<td ALIGN=CENTER COLSPAN=\"2\"><input type=\"submit\" name=\".submit\" value=\"Enter\"></td></tr></table></form>");  
		out.println("</H1>\n"+"</BODY></HTML>");

		

	}
}












