<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head> 
<title>Add User</title> 
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
    <td><input name="registrationdate" type="text" size="30" value=""></input></td>
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
