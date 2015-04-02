import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

/**
 *  This servlet sends one picture stored in the table below to the client 
 *  who requested the servlet.
 *
 *   pacs_images(record_id,image_id,thumbnail,regular_size,full_size)
 *
 *  The request must come with a query string as follows:
 *    GetOnePic?12:        sends the picture in thumbnail with photo_id = 12
 *    
 *
 *  @adapted from Li-Yan Yuan's example
 *
 */
public class GetOnePic extends HttpServlet 
    implements SingleThreadModel {

    /**
     *    This method first gets the query string indicating image_id,
     *    and then executes the query 
     *          select image from database where picid = image_id   
     *    Finally, it sends the picture to the client
     */

    public void doGet(HttpServletRequest request,
		      HttpServletResponse response)
	throws ServletException, IOException {
	
	//  construct the query  from the client's QueryString
	String picid  = request.getQueryString();
	String query;

	query = "select thumbnail from pacs_images where image_id=" + picid;


	ServletOutputStream out = response.getOutputStream();

	/*
	 *   to execute the given query
	 */
	Connection conn = null;
	try {
	    conn = getConnected();
	    Statement stmt = conn.createStatement();
	    ResultSet rset = stmt.executeQuery(query);

	    if ( rset.next() ) {
		response.setContentType("image/gif");
		InputStream input = rset.getBinaryStream(1);	    
		int imageByte;
		while((imageByte = input.read()) != -1) {
		    out.write(imageByte);
		}
		input.close();
	    } 
	    else 
		out.println("no picture available");
	} catch( Exception ex ) {
	    out.println(ex.getMessage() );
	}
	// to close the connection
	finally {
	    try {
		conn.close();
	    } catch ( SQLException ex) {
		out.println( ex.getMessage() );
	    }
	}
    }

    /*
     *   Connect to the specified database
     */
    private Connection getConnected() throws Exception {

	String username = "rtwong";
	String password = "rtwong1234";
        /* one may replace the following for the specified database */
	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	String driverName = "oracle.jdbc.driver.OracleDriver";

	/*
	 *  to connect to the database
	 */
	Class drvClass = Class.forName(driverName); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	return( DriverManager.getConnection(dbstring,username,password) );
    }
}
