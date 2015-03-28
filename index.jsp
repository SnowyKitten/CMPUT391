<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>Index File</title>
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
        if(auth == "a") {
        %>
        <a href="search.jsp">Search<br></a>
        <a href="analysis.jsp">Analysis<br></a>
        <a href="recordpage.jsp">Report Generation<br></a>
        <a href="usermanage.jsp">User Management<br></a>
        <a href="logout.jsp"> Logout<br></a>
        <% 
        } 
        else if(auth == "r") {
        %>
        <a href="search.jsp">Search<br></a>
        <a href="uploadrecord.jsp">Upload a Record<br></a>
        <a href="upload.jsp">Upload an Image<br></a>
        <a href="logout.jsp"> Logout<br></a>
        <%            
        }
        else if(auth == "d" || auth == "p") {
        %>
        <a href="search.jsp">Search<br></a>
        <a href="logout.jsp"> Logout<br></a>
        <%            
        }
        else {
            out.print("Appropriate authorization required.");     
        }
        %>


    </body>
</html>        
