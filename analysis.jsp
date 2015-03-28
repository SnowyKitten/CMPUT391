<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>Analysis</title>
    </head>
    <body>

        <%
        //HttpSession session = request.getSession(true);
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
        Stuff here in the future ----------------

        <%            
        }
        else {
            out.print("Appropriate authorization required.");     
        }
        %>


    </body>
</html>        
