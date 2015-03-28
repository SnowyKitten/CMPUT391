import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class updatepersonsubmit extends HttpServlet {
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
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String email = request.getParameter("email");
		String person_id = request.getParameter("person_id");
		String address = request.getParameter("address");
		String phone = request.getParameter("phone");
		

		queryString= "update persons set ";
		System.out.println("firstname            :"+firstname);
		System.out.println("lastname             :"+lastname);
		System.out.println("email                :"+email);
		System.out.println("address              :"+address);
		System.out.println("phone                :"+phone);
		boolean flag=false;
		queryString= "update persons set ";
		if (firstname != ""){
			queryString= queryString + "first_name='"+firstname+"'";
			flag=true;
		}
		if (lastname != "") {
				if (flag == true){
					queryString= queryString +",";}
			queryString= queryString + " last_name='"+lastname+"'";
			flag=true;
		}
		if (email != "") {
				if (flag == true){
					queryString= queryString +",";}
			queryString= queryString + " email='"+email+"'";
			flag=true;
		}
		if (address != "") {
				if (flag == true){
					queryString= queryString +",";}
			queryString= queryString + " address= '"+address+"'";
			flag=true;
		}
		if (phone != "") {
				if (flag == true){
					queryString= queryString +",";}
			queryString= queryString + "phone='"+phone+"'";
			flag=true;
		}
		if (flag == true){
			queryString= queryString+" where person_id='"+person_id+"'";
			System.out.println(queryString);



		try
		{
			Class drvClass=Class.forName(m_driverName);
			DriverManager.registerDriver((Driver) drvClass.newInstance());
		}catch(Exception e)
		{
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());
		}


		

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
}
}
