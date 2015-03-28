<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head> 
<title>Record Page htmlfile</title> 
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
        %>

	<% 
        if(auth.equals("a")) {
        %>

<font size="5" color="red">Record Page</font>
<br>
<br>
<form name="recordpage" method="Post" action="recordpage">
  <tr>
    <th>Diagnosis: </th>
    <td><input name="diagnosis" type="textfield" size="43" value="Diagnosis"></input></td>
  </tr>
  <br>
  <tr>
    <th>Date:  FROM</th>
    <td><input name="from_date" type="text" id="datepicker"></td>
    <th>TO </th>
    <td><input name="to_date" type="text" id="datepicker2"></td>
  </tr>
  <br>
  <tr>
    <td ALIGN=CENTER COLSPAN="2"><input type="submit" size ="90" name=".submit" value="GO"></td>
  </tr>

</form>

        <%            
        }
        else {
            out.print("Appropriate authorization required.");     
        }
        %>



</body> 
</html>
