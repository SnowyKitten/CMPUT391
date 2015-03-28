<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head> 
<title>Add Person</title> 
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
        if(auth == "a") {
        %>

<font size="5" color="red">Add Person</font>
<form name="addperson" method="post" action="addperson">
<table>
  <tr>
    <th>Enter Person ID: </th>
    <td><input name="personid" type="text" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter First Name: </th>
    <td><input name="firstname" type="text" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter Last Name: </th>
    <td><input name="lastname" type="text" size="30" value=""></input></td>
  </tr>

  <tr>
    <th>Enter Address: </th>
    <td><input name="address" type="text" size="30" value=""></input></td>
  </tr>
 <tr>

    <th>Enter Email: </th>
    <td><input name="email" type="text" size="30" value=""></input></td>
  </tr>

<tr>
    <th>Enter Phone: </th>
    <td><input name="phone" type="text" size="30" value=""></input></td>
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
