<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head> 
<title>heyheyhey upload phote and enter radiology record</title> 
</head>
<body> 

        <%
        //HttpSession session = request.getSession(true);
        if (!request.isRequestedSessionIdValid()){
            out.print("Appropriate authorization required."); 
            return;
        }
        Cookie[] cookies = request.getCookies();
        String auth = "null";
        for (int i=0; i<cookies.length; i++) {
            if(cookies[i].getName().equals("type")) {
                auth = cookies[i].getValue();
            }
        }
        %>

	<% 
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
    <td><input name="prescribing_date" type="text" size="30" value="YYYY/MM/DD"></input></td>

  </tr>

  <tr>
    <th>Enter Test Date: </th>
    <td><input name="test_date" type="text" size="30" value="YYYY/MM/DD"></input></td>

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
</form>

        <%            
        }
        else {
            out.print("Appropriate authorization required.");     
        }
        %>



</body> 
</html>
