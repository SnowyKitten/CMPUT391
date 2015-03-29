<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head> 
<title>heyheyhey upload photo and enter radiology record</title> 
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
        if (!request.isRequestedSessionIdValid()){
            out.print("Appropriate authorization required."); 
            return;
        }
        String auth = (String) session.getAttribute("class");
        if (auth == null) {
            auth = "null";
        }
        if(auth.equals("r")) {
        %>
Please Input radiology record!
<form name="upload" method="post" action="upload">
<table>
  <tr>
    <th>Enter Record ID: </th>
    <td><input name="record_id" type="number" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter patient ID: </th>
    <td><input name="patient_id" type="number" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter Doctor ID: </th>
    <td><input name="doctor_id" type="number" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter Radiologist ID: </th>
    <td><input name="radiologist_id" type="number" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter Test Type: </th>
    <td><input name="test_type" type="text" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter Prescribing Date: </th>
    <td><input name="prescribing_date" type="text" id="datepicker"></td>

  </tr>

  <tr>
    <th>Enter Test Date: </th>
    <td><input name="test_date" type="text" id="datepicker2"></td>

  </tr>

  <tr>
    <th>Enter Diagnosis: </th>
    <td><input name="diagnosis" type="text" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter Description: </th>
    <td><input name="description" type="text" size="30" value=""></input></td>
  </tr>

  <tr>
    <td ALIGN=CENTER COLSPAN="2"><input type="submit" name=".submit" value="Enter"></td>
  </tr>
</table>
<p>
</form>

        <%            
        }
        else {
            out.print("Appropriate authorization required.");     
        }
        %>

</body> 
</html>
