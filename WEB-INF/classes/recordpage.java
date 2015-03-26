import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;




public class recordpage extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		String dia = request.getParameter("diagnosis");
		String fd= request.getParameter("from_date");
		String td= request.getParameter("to_date");


System.out.println(dia);
System.out.println(fd);
System.out.println(td);
		
		String answer="";


		String user="rtwong";
		String pass="rtwong1234";

		
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
                String m_driverName = "oracle.jdbc.driver.OracleDriver";

		Connection m_con;
		Statement stmt;
		ResultSet rs;

		String createString = "SELECT p1.first_name, p1.last_name, p1.address, p1.phone from persons p1 "+
				      "WHERE p1.person_id in (SELECT r1.patient_id from radiology_record r1 "+
				      "WHERE r1.diagnosis like '"+dia+"' "+
				      "AND r1.prescribing_date BETWEEN TO_DATE('"+fd+"','MM-DD-YYYY') AND TO_DATE('"+td+"','MM-DD-YYYY'))"; 
 			 
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
			String first_name= rs.getString("first_name");
			String last_name= rs.getString("last_name");
			String address= rs.getString("address");
			String phone= rs.getString("phone");

			answer=answer+"<tr> <td>"+first_name+"</td> <td>"+last_name+"</td> <td>"+address+"</td> <td>"+phone+"</td> </tr>";
			}
		

              		stmt.close();
             		m_con.close();

       		} catch(SQLException ex) {

              		System.err.println("SQLException: " +
              		ex.getMessage());

       		}


		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

	
		/*out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>Asn2Sample</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"<H1>" +
			"hello" + 
			"</H1>\n" +
			"</BODY></HTML>");*/
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>RecordPage2</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"<table border=\"1\" style=\"width:100%\">\n"+
			"<tr> <td> <b> First Name </b> </td> <td> <b> Last Name </b> </td> <td> <b> Address </b> </td> <td> <b> Phone </b> </td> </tr>\n");
		out.println(answer+"</table>");
		out.println("</H1>\n"+"</BODY></HTML>");

		

	}
}
