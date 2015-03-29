<%@ page import="java.sql.*, java.util.*" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>Analysis</title>
    </head>
    <body>

        <%
        //HttpSession session = request.getSession(true);
        if (!request.isRequestedSessionIdValid()){
            out.print("Appropriate authorization required."); 
            return;
        }
        String auth = (String) session.getAttribute("class");
        if (auth == null) {
            auth = "null";
        }
        if(auth.equals("a")) {
        %>
       <%
	      String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	      String m_driverName = "oracle.jdbc.driver.OracleDriver";
	      
	      String m_userName = "rtwong"; //supply username
	      String m_password = "rtwong1234"; //supply password
	      
	      
	      Connection m_con;
	      Statement stmt;
	      
	      try
	      {
	      
		Class drvClass = Class.forName(m_driverName);
		DriverManager.registerDriver((Driver)
		drvClass.newInstance());
		m_con = DriverManager.getConnection(m_url, m_userName, m_password);
		
	      } 
	      catch(Exception e)
	      {      
		out.print("Error displaying data: ");
		out.println(e.getMessage());
		return;
	      }

	%>
<font size="5" color="red">OLAP Cube</font>
<form action="analysis.jsp" method="post">
  <input type="checkbox" name="patient" value="true" > Include Patient<br>
  <input type="checkbox" name="testtype" value="true" > Include Test Type<br>
  <input type="checkbox" name="time" value="true" > Include Time<br>
  <input type="radio" name="sort" value="weakly">Sort by Weakly<br>
  <input type="radio" name="sort" value="monthly">Sort by Monthly<br>
  <input type="radio" name="sort" value="yearly">Sort by Yearly</td>
  <input type="submit" value="Submit">
</form>
<br><br><br>


<%
   try{
	ResultSet patients;
	ResultSet types;
	ResultSet times;
	ResultSet rs;
	
	String pat= request.getParameter("patient");
	String type1= request.getParameter("testtype");
	String time1= request.getParameter("time");

	ArrayList<String> patientlist= new ArrayList<String>();
	ArrayList<String> typeslist= new ArrayList<String>();
	ArrayList<String> timeslist= new ArrayList<String>();
	System.out.print("test0\n\n\n\n");
	if (pat != null) {
		PreparedStatement doSearch = m_con.prepareStatement("select person_id from persons p where p.person_id in (select patient_id from radiology_record)");  
		stmt = m_con.createStatement();
              	patients = doSearch.executeQuery();
		while (patients.next()){
			String patient_id= patients.getString("person_id");
			patientlist.add(patient_id);
		}
		for (String s : patientlist){
		out.print(s+"<br>");}
	}
	System.out.print("test1\n\n\n\n");
	//out.println(type1.equals("true"));
	if (type1 != null) {
		PreparedStatement doSearch = m_con.prepareStatement("select test_type from radiology_record");  
		stmt = m_con.createStatement();
              	types = doSearch.executeQuery();
		while (types.next()){
			String typestring= types.getString("test_type");
			typeslist.add(typestring);
		}
		//for (String s : typeslist){
		//out.print(s+"<br>");}
	}
	out.print("asdfsdfsdf"+"<br>");
	if (time1 != null) {
		PreparedStatement doSearch = m_con.prepareStatement("select test_date from radiology_record");  
		stmt = m_con.createStatement();
              	times = doSearch.executeQuery();
		while (times.next()){
			String timestring= times.getString("test_date");
			timeslist.add(timestring);
		}
		for (String s : timeslist){
		out.print(s+"<br>");}
	}

	

	
	if (time1 == null){
		if (pat == null){
			out.print("test9");
			PreparedStatement doSearch = m_con.prepareStatement("select test_type, count(test_type) from radiology_record group by test_type");
			stmt = m_con.createStatement();
              		rs = doSearch.executeQuery();
			while (rs.next()){
				out.print("test1"+"<br>");
				String typestring= rs.getString("test_type");
				//String countstring= rs.getString("test_type(count)");
				out.print(typestring+"<br>");
				}
			}
		}	
			
	
   }catch(Exception e)
    {
        System.out.print("SQLException: " +e.getMessage());
	m_con.rollback();
    }
%>

        <%            
        }
        else {
            out.print("Appropriate authorization required.");     
        }
        %>


    </body>
</html>        
