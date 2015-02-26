<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>Index File</title>
    </head>
    <body>
	<% 
        String auth = request.getParameter("auth");
        if(auth.equals("a")) {
        %>
        <a href="search.html">Search<br></a>
        <a href="upload.html">Upload<br></a>
        <a href="analysis.html">Analysis<br></a>
        <a href="recordpage.html">Record Page<br></a>
        <a href="usermanage.html">User Management<br></a>
        <% 
        } 
        else if(auth == "r") {
        %>
        <a href="search.html">Search<br></a>
        <a href="upload.html">Upload<br></a>
        <a href="analysis.html">Analysis<br></a>
        <%            
        }
        else if(auth == "d" || auth == "p") {
        %>
        <a href="search.html">Search<br></a>
        <%            
        }
        else {
            out.print("Appropriate authorization required.");        
        }
        %>

    </body>
</html>        
