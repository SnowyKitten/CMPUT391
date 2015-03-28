<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>User Management Index</title>
    </head>
    <body>
        <%
        //HttpSession session = request.getSession(true);
        if (!request.isRequestedSessionIdValid()){
            out.print("Appropriate authorization required. adopted"); 
            return;
        }
        String auth = (String) session.getAttribute("class");
        %>

	<% 
        if(auth.equals("a")) {
        %>
        <a href="adduser.jsp">Add User<br></a>
        <a href="addperson.jsp">Add Person<br></a>
        <a href="adddoctor.jsp">Add Doctor<br></a>
	
	<form id="updateuser" method="post" action="updateuser">   
	<a href="javascript:{}" onclick="document.getElementById('updateuser').submit(); return false;">Update User</a>
	</form>

	<form id="updateperson" method="post" action="updateperson">   
	<a href="javascript:{}" onclick="document.getElementById('updateperson').submit(); return false;">Update Person</a>
	</form>

	<form id="updatedoctor" method="post" action="updatedoctor">   
	<a href="javascript:{}" onclick="document.getElementById('updatedoctor').submit(); return false;">Update Doctor</a>
	</form>

        <%            
        }
        else {
            out.print("Appropriate authorization required.");     
        }
        %>


    </body>
</html>        
