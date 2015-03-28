<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head> 
        <title>Add Doctor</title> 
    </head>
    <body> 
        <%
        if (!request.isRequestedSessionIdValid()){
            out.print("Appropriate authorization required."); 
            return;
        }
        String auth = session.getAttribute("class");

        if (auth == null) {
            auth = "null";
        }

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
