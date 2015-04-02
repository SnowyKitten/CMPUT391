import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;




public class recordpage extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		//get data from html
		String dia = request.getParameter("diagnosis");
		String fd= request.getParameter("from_date");
		String td= request.getParameter("to_date");

		//setup for printing to html
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		//set answer to nothing initially
		String answer="";

		//sql setup
		String user="rtwong";
		String pass="rtwong1234";

		
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
                String m_driverName = "oracle.jdbc.driver.OracleDriver";

		Connection m_con;
		Statement stmt;
		ResultSet rs;

		//create sql statement
		String createString = "SELECT p1.first_name, p1.last_name, p1.address, p1.phone, r1.test_date as tda from persons p1, radiology_record r1 "+
				      "WHERE p1.person_id = r1.patient_id "+
				      "and r1.diagnosis like '"+dia+"' "+
				      "and r1.prescribing_date BETWEEN TO_DATE('"+fd+"','MM-DD-YYYY') AND TO_DATE('"+td+"','MM-DD-YYYY')"+
				      "and r1.test_date in (select min(r2.test_date) from radiology_record r2 where r2.patient_id = p1.person_id and r2.prescribing_date BETWEEN TO_DATE('"+fd+"','MM-DD-YYYY') AND TO_DATE('"+td+"','MM-DD-YYYY') and r2.diagnosis like '"+dia+"' )"; 
 			 
		
		//try to connect
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

			//append results as row in table
			while (rs.next()){
			String first_name= rs.getString("first_name");
			String last_name= rs.getString("last_name");
			String address= rs.getString("address");
			String phone= rs.getString("phone");
			String tda= rs.getString("tda");

			answer=answer+"<tr> <td>"+first_name+"</td> <td>"+last_name+"</td> <td>"+address+"</td> <td>"+phone+"</td><td>"+tda+"</td> </tr>";
			}
		

              		stmt.close();
             		m_con.close();

		//if error print in system
       		} catch(SQLException ex) {

              		System.err.println("SQLException: " +
              		ex.getMessage());
			out.println(ex.getMessage());

       		}

	
		//print the table out
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>RecordPage2</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"<table border=\"1\" style=\"width:100%\">\n"+
			"<tr> <td> <b> First Name </b> </td> <td> <b> Last Name </b> </td> <td> <b> Address </b> </td> <td> <b> Phone </b> </td> <td> <b> Test Date </b> </td> </tr>\n");
		out.println(answer+"</table>");
		out.println("</H1>\n"+"</BODY></HTML>");

		

	}
}
