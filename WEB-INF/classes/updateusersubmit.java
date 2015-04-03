import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class updateusersubmit extends HttpServlet {
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
		
		String username = request.getParameter("username");
		String userpassword = request.getParameter("userpassword");
		String userclass = request.getParameter("userclass");
		String personid = request.getParameter("personid");
		String registrationdate = request.getParameter("registrationdate");

		//connect to sql
		try
		{
			Class drvClass=Class.forName(m_driverName);
			DriverManager.registerDriver((Driver) drvClass.newInstance());
		}catch(Exception e)
		{
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());
		}
		//create query out of inputed information
		boolean flag=false;
		queryString= "update users set ";
		if (username != ""){
			queryString= queryString + "user_name='"+username+"'";
			flag=true;
		}
		if (userpassword != "") {
				if (flag == true){
					queryString= queryString +",";}
			queryString= queryString + " password='"+userpassword+"'";
			flag=true;
		}
		if (userclass != "") {
				if (flag == true){
					queryString= queryString +",";}
			queryString= queryString + " class= '"+userclass+"'";
			flag=true;
		}
		if (registrationdate != "") {
				if (flag == true){
					queryString= queryString +",";}
			queryString= queryString + "date_registered=TO_DATE('"+registrationdate+"', 'MM-DD-YYYY')";
			flag=true;
		}
		if (personid == ""){
			flag=false;
		}
		if (flag == true){
			queryString= queryString+" where person_id='"+personid+"'";
			System.out.println(queryString);
		//execute statement
		try{
		m_con = DriverManager.getConnection(m_url, m_userName,m_password);
		stmt = m_con.createStatement();
		int result = stmt.executeUpdate(queryString);


		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>adddoctor</TITLE></HEAD>\n" +
			"<BODY>\n" +
			Integer.toString(result)+" row(s) updated\n");
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
	//if not all values are inputed	
	else {

			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>RecordPage2</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"ERROR <br> <br>PLEASE PUT IN VALUES TO UPDATE\n");
		out.println("</H1>\n"+"</BODY></HTML>");
		}
}
}
