<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head> 
<title>Record Page htmlfile</title> 
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
    <td><input name="from_date" type="textfield" size="20" value="YYYY/MM/DD"></input></td>
    <th>TO </th>
    <td><input name="to_date" type="textfield" size="20" value="YYYY/MM/DD"></input></td>
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
