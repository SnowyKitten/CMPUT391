<%@ page import="java.sql.*, java.util.*" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>Analysis</title>
		<!-- http://jqueryui.com/datepicker/ -->
        <title>Search</title>
	 <meta charset="utf-8">
	<title>jQuery UI Datepicker - Default functionality</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/	jquery-ui.css">
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script>
	$(function() {
		$( "#datepicker" ).datepicker();
		});
		</script>
	<script>
	$(function() {
		$( "#datepicker2" ).datepicker();
		});
		</script>
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
  <th>Date:  FROM</th>
    <td><input name="from_date" type="text" id="datepicker"></td>
    <th>TO </th>
    <td><input name="to_date" type="text" id="datepicker2"></td><br><br>
    <input type="radio" name="sort" value="w">Sort by Weekly<br>
  <input type="radio" name="sort" value="m">Sort by Monthly<br>
  <input type="radio" name="sort" value="y">Sort by Yearly</td>
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
	String fromdate= request.getParameter("from_date");
	String todate= request.getParameter("to_date");
	String radio= request.getParameter("sort");
	
	String h1="";
	int flag1=0;
	String dt="";
	//out.print(radio);
	if (radio != null){
	if (radio.equals("w")){
	    h1="WW";
	    flag1=1;
	    dt="(as week)";
	}
	if (radio.equals("m")){
	    h1="MONTH";
	    flag1=1;
	    dt=" (as month)";
	}
	if (radio.equals("y")){
	    h1 = "YEAR";
	    flag1=1;
	    dt=" (as year)";
	}
	}

	
	
	if (fromdate == ""){
	    fromdate= null;
	}
	if (todate == ""){
	    todate= null;
	}
	
	if (((fromdate == null) && (todate != null)) || ((todate == null) && (fromdate != null))){
	    out.print("Date ignored. Please put in start and end date"+"<br>");
	    todate = null;
	    fromdate = null;
	}
	
	//out.print(fromdate+todate+"<br>");
	
	
	ArrayList<String> patientlist= new ArrayList<String>();
	ArrayList<String> typeslist= new ArrayList<String>();
	ArrayList<String> timeslist= new ArrayList<String>();

	
	    if (fromdate == null){
		if (pat == null){
			if (type1 != null){
				PreparedStatement doSearch;
				if (flag1 == 1){
				    String stm= "select rec.test_type as t1, trunc(rec.test_date, '"+h1+"') as d1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic where pic.record_id = rec.record_id group by cube(rec.test_type,trunc(rec.test_date, '"+h1+"'))";
				    doSearch = m_con.prepareStatement(stm);
				    }
				else{
				    String stm="select rec.test_type as t1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic where pic.record_id = rec.record_id group by rec.test_type";
				    doSearch = m_con.prepareStatement(stm);
				}
				stmt = m_con.createStatement();
				rs = doSearch.executeQuery();
				out.print("<table border=\"2\">");
				if (flag1 == 1){
				    out.print("<tr><td>"+"Type"+"</td><td>"+"Date"+dt+"</td><td>"+"Images"+"</td>");
				    while (rs.next()){
					String typestring= rs.getString("t1");
					String countstring= rs.getString("c1");
					String datestring= rs.getString("d1");
					if ((typestring != null) && (countstring != null) && (datestring != null)){
					    out.print("<tr><td>"+typestring+"</td><td>"+datestring+"</td><td>"+countstring+"</td>");
					    }
				    }
				}else{
				    out.print("<tr><td>"+"Type"+"</td>"+"<td>"+"Images"+"</td>");

				    while (rs.next()){
					String typestring= rs.getString("t1");
					String countstring= rs.getString("c1");
					if ((typestring != null) && (countstring != null)){
					    out.print("<tr><td>"+typestring+"</td><td>"+countstring+"</td>");
					    }
				    }
				}
			}
		}else{
		    if (type1 == null){
			PreparedStatement doSearch;
			if (flag1 == 1){
			    String stm= "select concat(per.first_name,per.last_name) as name1, count(pic.image_id) as c1,  trunc(rec.test_date, '"+h1+"') as d1 from radiology_record rec, pacs_images pic, persons per where pic.record_id = rec.record_id and per.person_id = rec.patient_id group by cube(concat(per.first_name,per.last_name),trunc(rec.test_date, '"+h1+"'))";
			    doSearch = m_con.prepareStatement(stm);
			    }
			else{
			    String stm="select concat(per.first_name,per.last_name) as name1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic, persons per where pic.record_id = rec.record_id and per.person_id = rec.patient_id group by cube(concat(per.first_name,per.last_name))";
			    doSearch = m_con.prepareStatement(stm);
			}
			stmt = m_con.createStatement();
			rs = doSearch.executeQuery();
			out.print("<table border=\"2\">");
			if (flag1 == 1){
			    out.print("<tr><td>"+"Type"+"</td><td>"+"Date"+dt+"</td><td>"+"Images"+"</td>");
			    while (rs.next()){
				String typestring= rs.getString("name1");
				String countstring= rs.getString("c1");
				String datestring= rs.getString("d1");
				if ((typestring != null) && (countstring != null) && (datestring != null)){
				    out.print("<tr><td>"+typestring+"</td><td>"+datestring+"</td><td>"+countstring+"</td>");
				    }
			    }
			}else{
			    out.print("<tr><td>"+"Name"+"</td>"+"<td>"+"Images"+"</td>");
			    while (rs.next()){
				String namestring= rs.getString("name1");
				String countstring= rs.getString("c1");
				if ((namestring != null) && (countstring != null)){
				    out.print("<tr><td>"+namestring+"</td><td>"+countstring+"</td>");
				    }
			    }
			}
		    }
		    else{
			PreparedStatement doSearch;
			if (flag1 == 1){
			    String stm= "select concat(per.first_name,per.last_name) as name1, rec.test_type as t1, count(pic.image_id) as c1,  trunc(rec.test_date, '"+h1+"') as d1 from radiology_record rec, pacs_images pic, persons per where pic.record_id = rec.record_id and per.person_id = rec.patient_id group by cube(concat(per.first_name,per.last_name),rec.test_type,trunc(rec.test_date, '"+h1+"'))";
			    doSearch = m_con.prepareStatement(stm);
			}
			else{
			    String stm="select concat(per.first_name,per.last_name) as name1, rec.test_type as t1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic, persons per where pic.record_id = rec.record_id and per.person_id = rec.patient_id group by cube(concat(per.first_name,per.last_name),rec.test_type)";
			    doSearch = m_con.prepareStatement(stm);
			}
			stmt = m_con.createStatement();
			rs = doSearch.executeQuery();
			out.print("<table border=\"2\">");
			if (flag1 == 1){
			    out.print("<tr><td>"+"Name"+"</td><td>"+"Type"+"</td><td>"+"Date"+dt+"</td><td>"+"Images"+"</td>");
			    while (rs.next()){
				String namestring= rs.getString("name1");
				String countstring= rs.getString("c1");
				String datestring= rs.getString("d1");
				String typestring= rs.getString("t1");
				if ((namestring != null) && (countstring != null) && (datestring != null) && (typestring != null)){
				    out.print("<tr><td>"+namestring+"</td><td>"+typestring+"</td><td>"+datestring+"</td><td>"+countstring+"</td>");
				}
			    }
			}else{
			    out.print("<tr><td>"+"Name"+"</td><td>"+"Type"+dt+"</td><td>"+"Images"+"</td>");
			    while (rs.next()){
				String namestring= rs.getString("name1");
				String countstring= rs.getString("c1");
				String typestring= rs.getString("t1");
				if ((typestring != null) && (countstring != null) && (namestring != null)){
				    out.print("<tr><td>"+namestring+"</td><td>"+typestring+"</td><td>"+countstring+"</td>");
				    }
			    }
			}
		    
		    }
		}
	    }else{
		out.print("From  "+fromdate+"       to"+todate);
		if (pat == null){
		    if (type1 == null){
			PreparedStatement doSearch;
				if (flag1 == 1){
				    String stm= "select trunc(rec.test_date, '"+h1+"') as d1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic  where rec.test_date between to_date('"+fromdate+"','MM-DD-YYYY') and to_date('"+todate+"', 'MM-DD-YYYY') and rec.record_id = pic.record_id  group by cube(trunc(rec.test_date, '"+h1+"'))";
				    doSearch = m_con.prepareStatement(stm);
				    }
				else{
				    String stm="select rec.test_date as td, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic where rec.test_date between to_date('"+fromdate+"','MM-DD-YYYY') and to_date('"+todate+"', 'MM-DD-YYYY') and rec.record_id = pic.record_id group by rec.test_date";
				    doSearch = m_con.prepareStatement(stm);
				}
				stmt = m_con.createStatement();
				rs = doSearch.executeQuery();
				out.print("<table border=\"2\">");
				if (flag1 == 1){
				    out.print("<tr><td>"+"Date"+dt+"</td><td>"+"Images"+"</td>");
				    while (rs.next()){
					String countstring= rs.getString("c1");
					String datestring= rs.getString("d1");
					if ((countstring != null) && (datestring != null)){
						out.print("<tr><td>"+datestring+"</td><td>"+countstring+"</td>");
					}
				    }
				}else{
				    out.print("<tr><td>"+"Date"+"</td><td>"+"Images"+"</td>");
				    while (rs.next()){
					String countstring= rs.getString("c1");
					String datestring= rs.getString("td");
					if ((countstring != null) && (datestring != null)){
					    out.print("<tr><td>"+datestring+"</td><td>"+countstring+"</td><td>");
					    }
				    }
				}
		    }
		    else{
		    PreparedStatement doSearch;
				if (flag1 == 1){
				    String stm= "select rec.test_type as t1, trunc(rec.test_date, '"+h1+"') as d1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic  where rec.test_date between to_date('"+fromdate+"','MM-DD-YYYY') and to_date('"+todate+"', 'MM-DD-YYYY') and rec.record_id = pic.record_id  group by cube(trunc(rec.test_date, '"+h1+"'),rec.test_type)";
				    doSearch = m_con.prepareStatement(stm);
				    }
				else{
				    String stm="select rec.test_type as t1, rec.test_date as d1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic where rec.test_date between to_date('"+fromdate+"','MM-DD-YYYY') and to_date('"+todate+"', 'MM-DD-YYYY') and rec.record_id = pic.record_id group by cube(rec.test_date,rec.test_type)";
				    doSearch = m_con.prepareStatement(stm);
				}
				stmt = m_con.createStatement();
				rs = doSearch.executeQuery();
				out.print("<table border=\"2\">");
				    out.print("<tr><td>"+"Date"+dt+"</td><td>"+"Type"+"</td><td>"+"Images"+"</td>");
				    while (rs.next()){
					String countstring= rs.getString("c1");
					String datestring= rs.getString("d1");
					String typestring= rs.getString("t1");
					if ((countstring != null) && (datestring != null) && (typestring != null)){
						out.print("<tr><td>"+datestring+"</td><td>"+typestring+"</td><td>"+countstring+"</td>");
				    }
				}
				
		    }
		}
		else{
		    if (type1 == null){
			out.print("date true <br> patient true <br> type any");
			PreparedStatement doSearch;
			    if (flag1 == 1){
				String stm= "select trunc(rec.test_date, '"+h1+"') as d1, concat(per.first_name, per.last_name) as name1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic, persons per where rec.test_date between to_date('"+fromdate+"','MM-DD-YYYY') and to_date('"+todate+"', 'MM-DD-YYYY') and rec.record_id = pic.record_id and per.person_id = rec.patient_id group by cube(concat(per.first_name, per.last_name), trunc(rec.test_date, '"+h1+"'))";
				doSearch = m_con.prepareStatement(stm);
			    }
			    else{
				String stm="select rec.test_date as d1, concat(per.first_name, per.last_name) as name1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic, persons per where rec.test_date between to_date('"+fromdate+"','MM-DD-YYYY') and to_date('"+todate+"', 'MM-DD-YYYY') and rec.record_id = pic.record_id and per.person_id = rec.patient_id group by cube(concat(per.first_name, per.last_name),rec.test_date)";
				doSearch = m_con.prepareStatement(stm);
			    }
			    stmt = m_con.createStatement();
			    rs = doSearch.executeQuery();
			    out.print("<table border=\"2\">");
			    out.print("<tr><td>"+"Date"+dt+"</td><td>"+"Name"+"</td><td>"+"Images"+"</td>");
			    while (rs.next()){
				String countstring= rs.getString("c1");
				String datestring= rs.getString("d1");
				String namestring= rs.getString("name1");
				if ((countstring != null) && (datestring != null) && (namestring != null)){
				    out.print("<tr><td>"+datestring+"</td><td>"+namestring+"</td><td>"+countstring+"</td>");
				}
			    }
			}
			else{
			    out.print("date true <br> patient true <br> type any");
			PreparedStatement doSearch;
			    if (flag1 == 1){
				String stm= "select rec.test_type as t1, trunc(rec.test_date, '"+h1+"') as d1, concat(per.first_name, per.last_name) as name1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic, persons per where rec.test_date between to_date('"+fromdate+"','MM-DD-YYYY') and to_date('"+todate+"', 'MM-DD-YYYY') and rec.record_id = pic.record_id and per.person_id = rec.patient_id group by cube(concat(per.first_name, per.last_name), trunc(rec.test_date, '"+h1+"'),rec.test_type)";
				doSearch = m_con.prepareStatement(stm);
			    }
			    else{
				String stm="select rec.test_type as t1, rec.test_date as d1, concat(per.first_name, per.last_name) as name1, count(pic.image_id) as c1 from radiology_record rec, pacs_images pic, persons per where rec.test_date between to_date('"+fromdate+"','MM-DD-YYYY') and to_date('"+todate+"', 'MM-DD-YYYY') and rec.record_id = pic.record_id and per.person_id = rec.patient_id group by cube(concat(per.first_name, per.last_name),rec.test_date,rec.test_type)";
				doSearch = m_con.prepareStatement(stm);
			    }
			    stmt = m_con.createStatement();
			    rs = doSearch.executeQuery();
			    out.print("<table border=\"2\">");
			    out.print("<tr><td>"+"Date"+dt+"</td><td>"+"Name"+"</td><td>"+"Type"+"</td><td>"+"Images"+"</td>");
			    while (rs.next()){
				String countstring= rs.getString("c1");
				String datestring= rs.getString("d1");
				String namestring= rs.getString("name1");
				String typestring= rs.getString("t1");
				if ((countstring != null) && (datestring != null) && (namestring != null) && (typestring != null)){
				    out.print("<tr><td>"+datestring+"</td><td>"+namestring+"</td><td>"+typestring+"</td><td>"+countstring+"</td>");
				}
			    }
			}
		    }	
	    }
	
	    
	
	
   }catch(Exception e)
    {
	out.print("SQL ERROR");
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
