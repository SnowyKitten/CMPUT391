/***
 *  
 *  Copyright 2007 COMPUT 391 Team, CS, UofA                             
 *  @Adapted form Fan Deng's UploadImage.java
 *                                                                  
 *  Licensed under the Apache License, Version 2.0 (the "License");         
 *  you may not use this file except in compliance with the License.        
 *  You may obtain a copy of the License at                                 
 *      http://www.apache.org/licenses/LICENSE-2.0                          
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  
 *  Shrink function from
 *  http://www.java-tips.org/java-se-tips/java.awt.image/shrinking-an-image-by-skipping-pixels.html
 *
 *
 * CREATE TABLE pacs_images 
	(record_id   int,
	image_id    int,
	thumbnail   blob,
	regular_size blob,
	full_size    blob,
	PRIMARY KEY(record_id,image_id),
	FOREIGN KEY(record_id) REFERENCES radiology_record);
      *
      *  One may also need to create a sequence using the following 
      *  SQL statement to automatically generate a unique pic_id:
      *
      *   CREATE SEQUENCE pic_id_sequence;
      *
      ***/

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import oracle.sql.*;
import oracle.jdbc.*;
import java.awt.Image;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

/**
 *  The package commons-fileupload-1.0.jar is downloaded from 
 *         http://jakarta.apache.org/commons/fileupload/ 
 *  and it has to be put under WEB-INF/lib/ directory in your servlet context.
 *  One shall also modify the CLASSPATH to include this jar file.
 */
import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;

public class UploadImage extends HttpServlet {
    public String response_message;
    public void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException, IOException {
	//  change the following parameters to connect to the oracle database
	String username = "rtwong";
	String password = "rtwong1234";
	String drivername = "oracle.jdbc.driver.OracleDriver";
	String dbstring ="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

	int pic_id;
	FileItem image_file = null;


	try {
	    //Parse the HTTP request to get the image stream
	    DiskFileUpload fu = new DiskFileUpload();
	    List FileItems = fu.parseRequest(request);
	    int recordID=0;
	    // Process the uploaded items, assuming only 1 image file uploaded
	    Iterator i = FileItems.iterator();
	    //FileItem item = (FileItem) i.next();
	    while (i.hasNext()) {
		FileItem item = (FileItem) i.next();
		if(item.isFormField()){
			if(item.getFieldName().equals("recordID")){
				recordID=Integer.parseInt(item.getString());
			}
		}else{
			image_file=item;

	    	}
	    }

	    //Get the image stream
	    InputStream instream = image_file.getInputStream();

	    BufferedImage img = ImageIO.read(instream);
	    BufferedImage thumbNail = shrink(img, 10);
	    BufferedImage fullimg = shrink(img, 5);

            // Connect to the database and create a statement
            Connection conn = getConnected(drivername,dbstring, username,password);
	    Statement stmt = conn.createStatement();
	    
	    /*
	     *  First, to generate a unique pic_id using an SQL sequence
	     */
	    ResultSet rset1 = stmt.executeQuery("SELECT pic_id_sequence.nextval from dual");
	    rset1.next();
	    pic_id = rset1.getInt(1);

	    //Insert an empty blob into the table first. Note that you have to 
	    //use the Oracle specific function empty_blob() to create an empty blob
	    stmt.execute("INSERT INTO pacs_images VALUES("+recordID+","+pic_id+",empty_blob(),empty_blob(),empty_blob())");
 
	    // to retrieve the lob_locator 
	    // Note that you must use "FOR UPDATE" in the select statement
	    String cmd ="SELECT * FROM pacs_images WHERE record_id = "+recordID+" and image_id = "+pic_id+" FOR UPDATE";
	    ResultSet rset = stmt.executeQuery(cmd);
	    rset.next();
	    BLOB myblob = ((OracleResultSet)rset).getBLOB(3);
	    BLOB regularBlob = ((OracleResultSet)rset).getBLOB(4);
	    BLOB fullBlob = ((OracleResultSet)rset).getBLOB(5);
	    //Write the image to the blob object
	    OutputStream outstream = myblob.getBinaryOutputStream();
	    ImageIO.write(thumbNail, "jpg", outstream);

	    OutputStream regular = regularBlob.getBinaryOutputStream();
	    ImageIO.write(img, "jpg", regular);

	    OutputStream full = fullBlob.getBinaryOutputStream();
	    ImageIO.write(fullimg, "jpg", full);

	    instream.close();
 	    regular.close();
	    outstream.close();
	    full.close();

            stmt.executeUpdate("commit");
	    response_message = " Upload OK!  ";
            conn.close();

	} catch( Exception ex ) {
	    //System.out.println( ex.getMessage());
	    response_message = ex.getMessage();
	}

	//Output response to the client
	response.setContentType("text/html");
	PrintWriter out = response.getWriter();
	out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
		    "Transitional//EN\">\n" +
		    "<HTML>\n" +
		    "<HEAD><TITLE>Upload Message</TITLE></HEAD>\n" +
		    "<BODY>\n" +
		    "<H1>" +
		            response_message +
		    "</H1>\n" +
		    "</BODY></HTML>");
    }

    /*
      /*   To connect to the specified database
    */
    private static Connection getConnected( String drivername,
					    String dbstring,
					    String username, 
					    String password  ) 
	throws Exception {
	Class drvClass = Class.forName(drivername); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	return( DriverManager.getConnection(dbstring,username,password));
    } 

    //shrink image by a factor of n, and return the shrinked image
    public static BufferedImage shrink(BufferedImage image, int n) {

        int w = image.getWidth() / n;
        int h = image.getHeight() / n;

        BufferedImage shrunkImage =
            new BufferedImage(w, h, image.getType());

        for (int y=0; y < h; ++y)
            for (int x=0; x < w; ++x)
                shrunkImage.setRGB(x, y, image.getRGB(x*n, y*n));

        return shrunkImage;
    }


}
