<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head> 
        <title>Add Doctor</title> 
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

        <font size="5" color="red">Add Doctor</font>
        <form name="adddoctor" method="post" action="adddoctor">
        <table>
            <tr>
            <th>Enter Doctor ID: </th>
            <td><input name="doctorid" type="text" size="30" value=""></input></td>
            </tr>

            <tr>
            <th>Enter Patient ID: </th>
            <td><input name="patientid" type="text" size="30" value=""></input></td>
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
