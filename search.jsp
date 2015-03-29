<%@ page import="java.sql.*, java.util.*" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
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
        String check = (String) session.getAttribute("class");
        if (!( check !="a" && check != "r" && check != "d" && check != "p")){
            out.print("Appropriate authorization required."); 
            return;
        }
        String auth = (String) session.getAttribute("class");
        %>

	<%
	      String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	      String m_driverName = "oracle.jdbc.driver.OracleDriver";
	      
	      String m_userName = "rtwong"; //supply username
	      String m_password = "rtwong1234"; //supply password
	      
	      
	      Connection m_con;
	      Statement stmt;
              ResultSet rset;
	      
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
    <form name=insertData method=post action=search.jsp> 

      Search by Keyword(s)<br>
      <table>
          <tr>
              <td>
                <input type=text name=query><br><br><br>
              </td>
           </tr>

      </table>
      <table>

          <tr>
          Search by Test Date(s)
          </tr>
          <tr>
              <td>FROM:</td>
              <td><input name="from_date" type="text" id="datepicker"></td>
              <td>TO</td>
              <td><input name="to_date" type="text" id="datepicker2"></td>
           </tr>
       </table>
       <table>
           <tr>
                <br><br>
                Record Ordering Style              
                <td>
                <input type="radio" name="rank" value="newest">Show Newest First<br>
                <input type="radio" name="rank" value="oldest">Show Oldest First<br>
                <input type="radio" name="rank" value="ranking">Show by Ranking
                </td>
            </tr>
       </table>
       <input type=submit value="Search" name="search">
    </form>
    <%

        String ranking = request.getParameter("rank");
        String keyword = request.getParameter("query");
        String from_date = request.getParameter("from_date");
        String to_date = request.getParameter("to_date");
        if (ranking == null) {
            ranking = "null";
        }
        if (keyword == null) {
            keyword = "null";
        }
        if (from_date == null) {
            from_date = "null";
        }
        if (to_date == null) {
            to_date = "null";
        }


        String SQLStatement = "";
        String SQLOrdering = "";
        String pid = (String) session.getAttribute("pid");
        String security = "";

        SQLStatement = "select r.* ";
            

        if (ranking.equals("newest")) {
            SQLOrdering = "r.test_date desc";
        }
        else if (ranking.equals("oldest")) {
            SQLOrdering = "r.test_date asc";
        }
        else if (ranking.equals("ranking")) {
            SQLOrdering = "rank desc";
        }

        if (auth.equals("a")) {}
        else if(auth.equals("r")) {
            security = "r.radiologist_id = '" + pid + "' AND";
        }
        else if(auth.equals("d")) {
            security = "r.doctor_id = '" + pid + "' AND";
        }
        else if(auth.equals("p")) {
            security = "r.patient_id = '" + pid + "' AND ";
        }
        else{
            out.println(pid);
        }


        // case 1: keywords, no dates
        if (!(keyword.equals("")) && from_date.equals("") && to_date.equals("")) {
            String[] keywordList = keyword.split(" ");
            SQLStatement = SQLStatement + ", ";
            int counter = 0;
            for (int i = 0; i < keywordList.length; i++) {
                SQLStatement = SQLStatement + "6*score(" + Integer.toString(counter + 1)
                                          + ")+6*score(" + Integer.toString(counter + 2)
                                          + ")+3*score(" + Integer.toString(counter + 3)
                                          + ")+score(" + Integer.toString(counter + 4)
                                          + ") ";

                if (i != keywordList.length - 1) {
                    SQLStatement = SQLStatement + "+ ";
                }
                counter = counter + 4;
            }

            SQLStatement = SQLStatement + "as rank from radiology_record r full join persons p on r.patient_id = p.person_id where ";

            counter = 0;
            SQLStatement = SQLStatement + security;
            for (int i = 0; i < keywordList.length; i++) {
                SQLStatement = SQLStatement +"(contains(p.first_name, '" + keywordList[i]
                                           + "', " + Integer.toString(counter + 1)
                                           + ") > 0 OR "
                                           + "contains(p.last_name, '" + keywordList[i]
                                           + "', " + Integer.toString(counter + 2)
                                           + ") > 0 OR "
                                           + "contains(r.diagnosis, '" + keywordList[i]
                                           + "', " + Integer.toString(counter + 3)
                                           + ") > 0 OR "
                                           + "contains(r.description, '" + keywordList[i]
                                           + "', " + Integer.toString(counter + 4)
                                           + ") > 0 )";
                if (i != keywordList.length - 1) {
                    SQLStatement = SQLStatement + "OR ";
                }
                counter = counter + 4;
            }
            SQLStatement = SQLStatement + "ORDER BY " + SQLOrdering;
        }   
        // case 2: dates, no keywords
        else if (keyword.equals("") && !(from_date.equals("")) && !(to_date.equals(""))){
            SQLStatement = SQLStatement + "from radiology_record r full join persons p on r.patient_id = p.person_id where " + security;

            SQLStatement = SQLStatement + "r.test_date between to_date('" + from_date
                                        + "', 'MM/DD/YYYY') and to_date('" + to_date
                                        + "', 'MM/DD/YYYY') order by ";

            if (ranking.equals("ranking")) {
                out.println("Cannot order by ranking without keyword search" + "<br>");
                out.println("Default of 'Show Newest First' is used." + "<br>");
                SQLStatement = SQLStatement + "r.test_date desc";
            }
            else {
                SQLStatement = SQLStatement + SQLOrdering;
            }

        }

        // case 3: both parameters
        else if (!keyword.equals("") && !(from_date.equals("")) && !(to_date.equals("")))
        {
            String[] keywordList = keyword.split(" ");
            SQLStatement = SQLStatement + ", ";
            int counter = 0;
            for (int i = 0; i < keywordList.length; i++) {
                SQLStatement = SQLStatement + "6*score(" + Integer.toString(counter + 1)
                                          + ")+6*score(" + Integer.toString(counter + 2)
                                          + ")+3*score(" + Integer.toString(counter + 3)
                                          + ")+score(" + Integer.toString(counter + 4)
                                          + ") ";

                if (i != keywordList.length - 1) {
                    SQLStatement = SQLStatement + "+ ";
                }
                counter = counter + 4;
            }

            SQLStatement = SQLStatement + "as rank from radiology_record r full join persons p on r.patient_id = p.person_id where ";

            SQLStatement = SQLStatement + "r.test_date between to_date('" + from_date
                                        + "', 'MM/DD/YYYY') and to_date('" + to_date
                                        + "', 'MM/DD/YYYY') AND ";

            counter = 0;
            SQLStatement = SQLStatement + security;
            for (int i = 0; i < keywordList.length; i++) {
                SQLStatement = SQLStatement +"(contains(p.first_name, '" + keywordList[i]
                                           + "', " + Integer.toString(counter + 1)
                                           + ") > 0 OR "
                                           + "contains(p.last_name, '" + keywordList[i]
                                           + "', " + Integer.toString(counter + 2)
                                           + ") > 0 OR "
                                           + "contains(r.diagnosis, '" + keywordList[i]
                                           + "', " + Integer.toString(counter + 3)
                                           + ") > 0 OR "
                                           + "contains(r.description, '" + keywordList[i]
                                           + "', " + Integer.toString(counter + 4)
                                           + ") > 0 )";
                if (i != keywordList.length - 1) {
                    SQLStatement = SQLStatement + "OR ";
                }
                counter = counter + 4;
            }
            SQLStatement = SQLStatement + "ORDER BY " + SQLOrdering;
        }
    %> 
    <table border="2">
        <tr>
            <th>Record ID</th>
            <th>Patient ID</th>
            <th>Doctor ID</th>
            <th>Radiologist ID</th>
            <th>Test Type</th>
            <th>Prescribing Date</th>
            <th>Test Date</th>
            <th>Diagnosis</th>
            <th>Description</th>
            <th>Images</th>        
        </tr>
    <%

        try {
            stmt = m_con.createStatement();
            rset = stmt.executeQuery(SQLStatement);
            while (rset != null && rset.next()) {
                String recordID = (rset.getString("record_id"));
                String patientID = (rset.getString("patient_id"));
                String doctorID = (rset.getString("doctor_id"));
                String radiologistID = (rset.getString("radiologist_id"));
                String testType = (rset.getString("TEST_TYPE"));
                String prescribeDate = (rset.getString("PRESCRIBING_DATE"));
                String testDate = (rset.getString("TEST_DATE"));
                String diagnosis = (rset.getString("DIAGNOSIS"));
                String description = (rset.getString("description"));

                out.println("<tr>");
                out.println("<td>" + recordID + "</td>");
                out.println("<td>" + patientID + "</td>");
                out.println("<td>" + doctorID + "</td>");
                out.println("<td>" + radiologistID + "</td>");
                out.println("<td>" + testType + "</td>");
                out.println("<td>" + prescribeDate + "</td>");
                out.println("<td>" + testDate + "</td>");
                out.println("<td>" + diagnosis + "</td>");
                out.println("<td>" + description + "</td>");
            }
        } catch (Exception e){
            out.println("help");
        }    

        
    %>
    </table>

    </body>
</html>        
