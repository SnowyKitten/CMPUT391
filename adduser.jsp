<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head> 
<title>Add User</title> 
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
        if(auth.equals("a")) {
        %>
<font size="5" color="red">Add User</font>
<form name="adduser" method="post" action="adduser">
<table>
  <tr>
    <th>Enter Name: </th>
    <td><input name="username" type="text" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter Password: </th>
    <td><input name="userpasssword" type="text" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter Class: </th>
    <td><input name="userclass" type="text" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter Person ID: </th>
    <td><input name="personid" type="text" size="30" value=""></input></td>
  </tr>
 <tr>

<tr>
    <th>Enter Registration Date: </th>
    <td><input name="registrationdate" type="text" id="datepicker"></td>
  </tr>

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
