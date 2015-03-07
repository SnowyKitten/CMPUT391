import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class updateuser extends HttpServlet {
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

		String createString = "SELECT user_name, class, person_id, date_registered from users"; 

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
			String user_name= rs.getString("user_name");
			String class1= rs.getString("class");
			String person_id= rs.getString("person_id");
			String date_registered= rs.getString("date_registered");

			answer=answer+"<tr> <td>"+user_name+"</td> <td>"+class1+"</td> <td>"+person_id+"</td> <td>"+date_registered+"</td> </tr>";
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
			"<tr> <td> <b> Username </b> </td> <td> <b> Class </b> </td> <td> <b> Person ID </b> </td> <td> <b> Date Registered </b> </td> </tr>\n");
		out.println(answer+"</table>");
		out.println("<form name=\"updateusersubmit\" method=\"post\" action=\"updateusersubmit\"><table><tr><th>Enter Username: </th><td><input name=\"username\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");


out.println("<tr><th>Enter Password: </th><td><input name=\"userpasssword\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<tr><th>Enter Class: </th><td><input name=\"userclass\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<tr><th>Enter Person ID: </th><td><input name=\"personid\" type=\"text\" size=\"30\" value=\"\"></input></td></tr><tr><tr><th>Enter Registration Date: </th><td><input name=\"registrationdate\" type=\"text\" size=\"30\" value=\"\"></input></td></tr>");

out.println("<td ALIGN=CENTER COLSPAN=\"2\"><input type=\"submit\" name=\".submit\" value=\"Enter\"></td></tr></table></form>");  
		out.println("</H1>\n"+"</BODY></HTML>");

		

	}
}












