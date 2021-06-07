<%
// Author - Karthik Subbarao, Ganesh Prasad
%>

<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.lang.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
  <head>	
  <title>Result</title>
  <style>
    #ABC 
	{
      background-color: rgba(50, 115, 220, 0.3);
    }
  </style>
  </head>
  <body>
  				<style>
				table 
				{
				font-family: arial, sans-serif;
				border-collapse: collapse;
				width: 100%;
				}
				
				td, th 
				{
				  border: 1px solid #dddddd;
				  text-align: left;
				  padding: 8px;

				}

				tr:nth-child(even) {
				  background-color: #dddddd;

				}
				</style>

  <section id="ABC">
  <font size="28"> <b> <center> Result </center> </b></font>
  <br>

  <% 
  try 
  {
  				String authcheck = (String) session.getAttribute("authenticate");
				String rolecheck = (String) session.getAttribute("role");
				if( authcheck == null )
				{
					int goodbye = 4/0;
				}
				else if(authcheck.equals("no"))
				{
					int goodbye = 4/0;
				}
				else if(authcheck.equals("yes"))
				{



		String querynum= "";
		int redirect=0;
		String DB_URL = "jdbc:mysql://cs363winservdb:3306/Group4?allowPublicKeyRetrieval=true&useSSL=false";
		Connection conn=null;
		ResultSet rs=null;

			 if(request.getParameter("query_selector") != null)
				{
					session.setAttribute("queryvalue", (String) request.getParameter("query_selector"));

					querynum = (String) session.getAttribute("queryvalue");
				}
				else
				{
				redirect=1;
				}

	  querynum = (String) session.getAttribute("queryvalue");

	  if(querynum.equals("Q1"))
	  {
		 out.println("<h3> Query 1 </h3> <br>");
		   %>
				<p>
			   <form action=""> 
			   <h3>
			   Value of K (Integer between 1 and 100) <input type="text" name="k1"><br>
			   Value of Month (String): <input type="text" name="month1"><br>
			   Value of Year (String) : <input type="text" name="year1"><br>
			   </h3>
			   <input type="submit" value = " Go  ">
				</form> 
	
				<form action="query.jsp"> 
				<input type="submit" value = "Back">
				</form>
				</p>



				<h2><center> Query1 Table </center> </h2>
				</section>
				<table>
				  <tr style="background-color:#BDB76B;color:#ffffff;">
					<th>Retweet Count</th>
					<th>Textbody</th>
					<th>Screen Name</th>
					<th>Category</th>
					<th>Sub Category</th>
				  </tr>


				<%
				if(redirect==1)
				{
					Class.forName("com.mysql.jdbc.Driver");
					String us = "Group4";
					String pas = "363s2Group4v5543";
					conn = DriverManager.getConnection(DB_URL, us, pas);
					CallableStatement cstmt = conn.prepareCall("{call q1(?,?,?)}");

					if(!(Integer.parseInt(request.getParameter("k1")) >= 1 && Integer.parseInt(request.getParameter("k1")) <= 100))
					{
						throw new Exception("K must be between 1 and 100 inclusive.");
					}

					cstmt.setInt(1, Integer.parseInt(request.getParameter("k1")) );
					cstmt.setInt(2, Integer.parseInt(request.getParameter("month1")) );
					cstmt.setInt(3, Integer.parseInt(request.getParameter("year1")) );
					rs = cstmt.executeQuery();
					while (rs.next()) 
					{
						%>
						  <tr>
							<td> <%= rs.getString("retweetcnt") %> </td>
							<td> <%= rs.getString("textbody") %> </td> 
							<td> <%= rs.getString("screen_name") %> </td>
							<td> <%= rs.getString("cat") %> </td>
							<td> <%= rs.getString("sub_cat") %> </td>
						  </tr>

						<%
					}
				
					rs.close();
					conn.close();
					redirect=0;
				}

				%>
				</table>
	  <%
 
	  }
	  else if(querynum.equals("Q2"))
	  {
	  %>
	  		   <p>
			   <form action=""> 
			   <h3>
			   Value of K (Integer): <input type="text" name="k2"><br>
			   Value of Hashtag (String): <input type="text" name="Hash2"><br>
			   Value of Month (Integer): <input type="text" name="Month2"><br>
			   Value of Year (Integer): <input type="text" name="Year2"><br>
			   </h3>
			   <input type="submit" value = " Go  ">
				</form> 
	
				<form action="query.jsp"> 
				<input type="submit" value = "Back">
				</form>
				</p>

				<h2><center> Query2 Table </center> </h2>
				</section>
				<table>
				  <tr style="background-color:#BDB76B;color:#ffffff;">
					<th>Screen Name</th>
					<th>Category</th>
					<th>_______________________________Textbody_____________________________</th>
					<th>Retweet Count</th>
				  </tr>

				<%
				if(redirect==1)
				{
					Class.forName("com.mysql.jdbc.Driver");
					String us = "Group4";
					String pas = "363s2Group4v5543";
					conn = DriverManager.getConnection(DB_URL, us, pas);
					CallableStatement cstmt = conn.prepareCall("{call q2(?,?,?,?)}");

					if(!(Integer.parseInt(request.getParameter("k2")) >= 1 && Integer.parseInt(request.getParameter("k2")) <= 100))
					{
						throw new Exception("K must be between 1 and 100 inclusive.");
					}

					cstmt.setInt(1, Integer.parseInt(request.getParameter("k2")) );
					cstmt.setString(2, (request.getParameter("Hash2")) );
					cstmt.setInt(3, Integer.parseInt(request.getParameter("Month2")) );
					cstmt.setInt(4, Integer.parseInt(request.getParameter("Year2")) );
					rs = cstmt.executeQuery();
					while (rs.next()) 
					{

						%>
						  <tr>
							<td> <%= rs.getString("screen_name") %> </td>
							<td> <%= rs.getString("category") %> </td> 
							<td> <%= rs.getString("textbody") %> </td>
							<td> <%= rs.getString("retweetcount") %> </td>
						  </tr>

						<%
					}
				
					rs.close();
					conn.close();
					redirect=0;
				}

				%>
				</table>

	  <%
	  }
	  else if(querynum.equals("Q3"))
	  {
	  %>
	  		   <p>
			   <form action=""> 
			   <h3>
			   Value of K (Integer): <input type="text" name="k3"><br>
			   Value of Year (Integer): <input type="text" name="Year3"><br>
			   </h3>
			   <input type="submit" value = " Go  ">
				</form> 
	
				<form action="query.jsp"> 
				<input type="submit" value = "Back">
				</form>
				</p>

				<h2><center> Query3 Table </center> </h2>

				</section>
				<table>
				  <tr style="background-color:#BDB76B;color:#ffffff;">
					<th>Hashtag Name</th>
					<th>_State Count</th>
					<th>State List</th>
				  </tr>


				<%
				if(redirect==1)
				{
					Class.forName("com.mysql.jdbc.Driver");
					String us = "Group4";
					String pas = "363s2Group4v5543";
					conn = DriverManager.getConnection(DB_URL, us, pas);
					CallableStatement cstmt = conn.prepareCall("{call q3(?,?)}");

					if(!(Integer.parseInt(request.getParameter("k3")) >= 1 && Integer.parseInt(request.getParameter("k3")) <= 100))
					{
						throw new Exception("K must be between 1 and 100 inclusive.");
					}

					cstmt.setInt(1, Integer.parseInt(request.getParameter("k3")) );
					cstmt.setInt(2, Integer.parseInt(request.getParameter("Year3")) );
					rs = cstmt.executeQuery();
					while (rs.next()) 
					{
						%>
						  <tr>
							<td> <%= rs.getString("Hashtagname") %> </td>
							<td> <%= rs.getString("State_Count") %> </td>
							<td> <%= rs.getString("StateList") %> </td>
						  </tr>

						<%
					}
				
					rs.close();
					conn.close();
					redirect=0;
				}

				%>
				</table>

	  <%
	  }
	  else if(querynum.equals("Q6"))
	  {
	  %>
	  		   <p>
			   <form action=""> 
			   <h3>
			   Value of K (Integer): <input type="text" name="k6"><br>
			   Value of Hashtag List (String, no space): <input type="text" name="Hash6"><br>
			   </h3>
			   <input type="submit" value = " Go  ">
				</form> 
	
				<form action="query.jsp"> 
				<input type="submit" value = "Back">
				</form>
				</p>

				<h2><center> Query6 Table </center> </h2>

				</section>
				<table>
				  <tr style="background-color:#BDB76B;color:#ffffff;">
					<th>Screen Name</th>
					<th>State</th>
				  </tr>


				<%
				if(redirect==1)
				{
					Class.forName("com.mysql.jdbc.Driver");
					String us = "Group4";
					String pas = "363s2Group4v5543";
					conn = DriverManager.getConnection(DB_URL, us, pas);
					CallableStatement cstmt = conn.prepareCall("{call q6(?,?)}");

					if(!(Integer.parseInt(request.getParameter("k6")) >= 1 && Integer.parseInt(request.getParameter("k6")) <= 100))
					{
						throw new Exception("K must be between 1 and 100 inclusive.");
					}

					cstmt.setInt(1, Integer.parseInt(request.getParameter("k6")) );
					cstmt.setString(2, (request.getParameter("Hash6")) );
					rs = cstmt.executeQuery();
					while (rs.next()) 
					{
						%>
						  <tr>
							<td> <%= rs.getString("username") %> </td>
							<td> <%= rs.getString("state") %> </td>
						  </tr>

						<%
					}
				
					rs.close();
					conn.close();
					redirect=0;
				}

				%>
				</table>

	  <%
	  }
	  else if(querynum.equals("Q10"))
	  {
	  	  %>
	  		   <p>
			   <form action=""> 
			   <h3>
			   Value of State List (String, no space): <input type="text" name="State10"><br>
			   Value of Month (Integer): <input type="text" name="Month10"><br>
			   Value of Year (Integer): <input type="text" name="Year10"><br>
			   </h3>
			   <input type="submit" value = " Go  ">
				</form> 
	
				<form action="query.jsp"> 
				<input type="submit" value = "Back">
				</form>
				</p>

				<h2><center> Query10 Table </center> </h2>

				</section>
				<table>
				  <tr style="background-color:#BDB76B;color:#ffffff;">
					<th>State</th>
					<th>Hashtag</th>
				  </tr>


				<%
				if(redirect==1)
				{
					Class.forName("com.mysql.jdbc.Driver");
					String us = "Group4";
					String pas = "363s2Group4v5543";
					conn = DriverManager.getConnection(DB_URL, us, pas);
					CallableStatement cstmt = conn.prepareCall("{call q10(?,?,?)}");
					cstmt.setString(1, (request.getParameter("State10")) );
					cstmt.setInt(2, Integer.parseInt(request.getParameter("Month10")) );
					cstmt.setInt(3, Integer.parseInt(request.getParameter("Year10")) );
					rs = cstmt.executeQuery();
					while (rs.next()) 
					{
						%>
						  <tr>
							<td> <%= rs.getString("state") %> </td>
							<td> <%= rs.getString("hashtag") %> </td>
						  </tr>

						<%
					}
				
					rs.close();
					conn.close();
					redirect=0;
				}

				%>
				</table>

	  <%
	  }
	  else if(querynum.equals("Q15"))
	  {
	  %>
	  		   <p>
			   <form action=""> 
			   <h3>
			   Value of Sub Category (String): <input type="text" name="Sub15"><br>
			   Value of Month (Integer): <input type="text" name="Month15"><br>
			   Value of Year (Integer): <input type="text" name="Year15"><br>
			   </h3>
			   <input type="submit" value = " Go  ">
				</form> 
	
				<form action="query.jsp"> 
				<input type="submit" value = "Back">
				</form>
				</p>

				<h2><center> Query15 Table </center> </h2>

				</section>
				<table>
				  <tr style="background-color:#BDB76B;color:#ffffff;">
					<th>Screen Name</th>
					<th>State</th>
					<th>URL List</th>
				  </tr>


				<%
				if(redirect==1)
				{
					Class.forName("com.mysql.jdbc.Driver");
					String us = "Group4";
					String pas = "363s2Group4v5543";
					conn = DriverManager.getConnection(DB_URL, us, pas);
					CallableStatement cstmt = conn.prepareCall("{call q15(?,?,?)}");
					cstmt.setString(1, (request.getParameter("Sub15")) );
					cstmt.setInt(2, Integer.parseInt(request.getParameter("Month15")) );
					cstmt.setInt(3, Integer.parseInt(request.getParameter("Year15")) );
					rs = cstmt.executeQuery();
					while (rs.next()) 
					{
						%>
						  <tr>
							<td> <%= rs.getString("scname") %> </td>
							<td> <%= rs.getString("State") %> </td>
							<td> <%= rs.getString("UrlList") %> </td>
						  </tr>

						<%
					}
				
					rs.close();
					conn.close();
					redirect=0;
				}

				%>
				</table>

	  <%
	  }
	  else if(querynum.equals("Q23"))
	  {
	  	  %>
	  		   <p>
			   <form action=""> 
			   <h3>
			   Value of Sub Category (String): <input type="text" name="Sub23"><br>
			   Value of Month List (String, no spaces): <input type="text" name="MonthList23"><br>
			   Value of K(Integer): <input type="text" name="k23"><br>
			   </h3>
			   <input type="submit" value = " Go  ">
				</form> 
	
				<form action="query.jsp"> 
				<input type="submit" value = "Back">
				</form>
				</p>

				<h2><center> Query23 Table </center> </h2>

				</section>
				<table>
				  <tr style="background-color:#BDB76B;color:#ffffff;">
					<th>Hashtag</th>
					<th>Tweet Count</th>
				  </tr>


				<%
				if(redirect==1)
				{
					Class.forName("com.mysql.jdbc.Driver");
					String us = "Group4";
					String pas = "363s2Group4v5543";
					conn = DriverManager.getConnection(DB_URL, us, pas);
					CallableStatement cstmt = conn.prepareCall("{call q23(?,?,?)}");

					if(!(Integer.parseInt(request.getParameter("k23")) >= 1 && Integer.parseInt(request.getParameter("k23")) <= 100))
					{
						throw new Exception("K must be between 1 and 100 inclusive.");
					}

					cstmt.setString(1, (request.getParameter("Sub23")) );
					cstmt.setString(2, (request.getParameter("MonthList23")) );
					cstmt.setInt(3, Integer.parseInt(request.getParameter("k23")) );
					rs = cstmt.executeQuery();
					while (rs.next()) 
					{
						%>
						  <tr>
							<td> <%= rs.getString("hashs") %> </td>
							<td> <%= rs.getString("tweet_count") %> </td>
						  </tr>

						<%
					}
				
					rs.close();
					conn.close();
					redirect=0;
				}

				%>
				</table>

	  <%
	  }
	  else if(querynum.equals("Q27"))
	  {
  	  %>
				</section>
				<p>
			   <form action=""> 
			   <h3>
			   Value of K (Integer): <input type="text" name="k27"><br>
			   Value of Month 1 (Integer): <input type="text" name="1Month27"><br>
			   Value of Month 2 (Integer): <input type="text" name="2Month27"><br>
			   Value of Year (Integer): <input type="text" name="Year27"><br>
			   </h3>
			   <input type="submit" value = " Go  ">
				</form> 
	
				<form action="query.jsp"> 
				<input type="submit" value = "Back">
				</form>
				</p>

				<%
				if(redirect==1)
				{
					Class.forName("com.mysql.jdbc.Driver");
					String us = "Group4";
					String pas = "363s2Group4v5543";
					conn = DriverManager.getConnection(DB_URL, us, pas);
					CallableStatement cstmt = conn.prepareCall("{call q27(?,?,?,?)}");

					if(!(Integer.parseInt(request.getParameter("k27")) >= 1 && Integer.parseInt(request.getParameter("k27")) <= 100))
					{
						throw new Exception("K must be between 1 and 100 inclusive.");
					}

					cstmt.setInt(1, Integer.parseInt(request.getParameter("k27")) );
					cstmt.setInt(2, Integer.parseInt(request.getParameter("1Month27")) );
					cstmt.setInt(3, Integer.parseInt(request.getParameter("2Month27")) );
					cstmt.setInt(4, Integer.parseInt(request.getParameter("Year27")) );
					rs = cstmt.executeQuery();

					out.println("<h1> <center> <u>" + "SC Name" + " </u></center> </h1>");
					while (rs.next()) 
					{
						out.println("<h4> <center>" + rs.getString("sc_name") + " </center> </h4>");
					}
				
					rs.close();
					conn.close();
					redirect=0;
				}
		
		
	  }
	  else if(querynum.equals("I"))
	  {
			if(rolecheck.equals("admin"))
			{
					%>
	  			    <h2> <center> Query I </center><h2>
				    <h2> Enter a User information. A minimum of username is needed to insert data as screen_name is the primary key.	</h2>	
					<p>
				   <form action=""> 
				   <h3>
				   Username (String): <input type="text" name="Iuser"><br>
				   Full Name (String): <input type="text" name="Iname"><br>
				   Sub Category (String): <input type="text" name="Isub"><br>
				   Category (String): <input type="text" name="Icat"><br>
				   State (String): <input type="text" name="Istate"><br>
				   Followers (Integer): <input type="text" name="Inumfollower"><br>
				   Following (Integer): <input type="text" name="Inumfollowing"><br>
				   Location (String): <input type="text" name="Ilocation"><br>
				   </h3>
				   <input type="submit" value = "Insert">
					</form> 
	
					<form action="query.jsp"> 
					<input type="submit" value = " Back">
					</form>
					</p>
					</section>
					<%

					if(redirect==1)
					{
						Class.forName("com.mysql.jdbc.Driver");
						String us = "Group4";
						String pas = "363s2Group4v5543";
						conn = DriverManager.getConnection(DB_URL, us, pas);
						String insertTableSQL = "insert into uuser"
						+ "(screen_name, nameof, sub_category,category, state, num_followers, num_following, location) VALUES"
						+ "(?,?,?,?,?,?,?,?)";
						PreparedStatement cstmt = conn.prepareCall(insertTableSQL);
						cstmt.clearParameters();

						String primary = (String) request.getParameter("Iuser");
						String nameof = (String) request.getParameter("Iname");
						String sub_category = (String) request.getParameter("Isub");
						String category = (String) request.getParameter("Icat");
						String state = (String) request.getParameter("Istate");
						String num_follower = (String) (request.getParameter("Inumfollower"));
						String num_following = (String) (request.getParameter("Inumfollowing")) ;
						String location = (String) request.getParameter("Ilocation");

						if(primary.equals(""))
						{
							throw new Exception("Please Enter the Username. You need to enter a valid username at minimum to insert into the database.");
						}
						if(!primary.equals(""))
						{
						   cstmt.setString(1, (request.getParameter("Iuser")) );
						}
						if(!nameof.equals(""))
						{
						cstmt.setString(2, (request.getParameter("Iname")) );
						}
						else
						{
						cstmt.setString(2, "" );
						}
						if(!sub_category.equals(""))
						{
						cstmt.setString(3, (request.getParameter("Isub")) );
						}
						else
						{
						cstmt.setString(3, "" );
						}
						if(!category.equals(""))
						{
						cstmt.setString(4, (request.getParameter("Icat")) );
						}
						else
						{
						cstmt.setString(4, "");
						}
						if(!state.equals(""))
						{
						cstmt.setString(5, (request.getParameter("Istate")) );
						}
						else
						{
						cstmt.setString(5, "" );
						}
						if(num_follower.equals(""))
						{
						cstmt.setInt(6, 0 );
						}
						else
						{
						cstmt.setInt(6, Integer.parseInt(request.getParameter("Inumfollower")) );
						}
						if(num_following.equals(""))
						{
						cstmt.setInt(7, 0 );
						}
						else
						{
						cstmt.setInt(7, Integer.parseInt(request.getParameter("Inumfollowing")) );
						}
						if(!location.equals(""))
						{
						cstmt.setString(8, (request.getParameter("Ilocation")) );
						}
						else
						{
						cstmt.setString(8, "");
						}
						int r = cstmt.executeUpdate();

						if(r ==1)
						{
							out.println("<h2> <center>" + "Insert Successfull" + " </center> </h2>");
						}
				

						conn.close();
						redirect=0;
					}
		
			}
			else
			{
				out.println("<br><br><h2><center>" +"You are not an Admin. You need to be an Admin to insert or delete."+ "</center></h2>");	
					%>
					<center>
					<form action="query.jsp"> 
					<input type="submit" value = " Back">
					</form>
					</center>
					<%
			}
	  }
	  else if(querynum.equals("D"))
	  {	  
			if(rolecheck.equals("admin"))
			{
					%>
					<h2> <center> Query D </center><h2>
					<h2> Enter a username to delete all data linked to it. </h2>
					<p>
				    <form action=""> 
				    <h3>
				    Username (String): <input type="text" name="Duser"><br>
				    </h3>
				    <input type="submit" value = "Delete">
					</form> 
	
					<form action="query.jsp"> 
					<input type="submit" value = " Back">
					</form>
					</p>
					</section>
					<%

				   if(redirect==1)
				   {	
						int triggered=0;
						String winalldayy="";
						int utriggered=0;
						String uwinalldayy="";
						Class.forName("com.mysql.jdbc.Driver");
						String us = "Group4";
						String pas = "363s2Group4v5543";
						conn = DriverManager.getConnection(DB_URL, us, pas);
						String deleteTableSQL = "delete from uuser WHERE screen_name = (?)";

						PreparedStatement cstmt = conn.prepareStatement(deleteTableSQL);
						cstmt.clearParameters();

						String primary = (String) request.getParameter("Duser");

						if(primary.equals(""))
						{
							throw new Exception("Please Enter the Username. You need to enter a valid username at minimum to insert into the database.");
						}
						else
						{
							   cstmt.setString(1, (String) (request.getParameter("Duser")) );


							   String usercheck = "select * from uuser WHERE screen_name = (?)";
							   CallableStatement cs = conn.prepareCall(usercheck);
							   cs.clearParameters();
							   cs.setString(1, (String) (request.getParameter("Duser")) );

							   rs = cs.executeQuery();
							   int size =0;
							   if (rs != null) 
							   {
								  rs.last();    
								  size = rs.getRow(); 
							   }

							   if(size ==0)
							   {
									out.println("<h2> <center>" + "No data found with this username" + " </center> </h2>");
							   }
							   if(size >0)
							   {
									   String tweetcheck = "select * from tweet WHERE tscreen_name = (?)";
									   cs = conn.prepareCall(tweetcheck);
									   cs.clearParameters();
									   cs.setString(1, (String) (request.getParameter("Duser")) );

									   rs = cs.executeQuery();
									   size =0;
									   if (rs != null) 
									   {
										  rs.last();    
										  size = rs.getRow(); 
									   }
									   if(size >0)
									   {
											   String tweetlist = "select t.tid from tweet t WHERE tscreen_name = (?)";
											   cs = conn.prepareCall(tweetlist);
											   cs.clearParameters();
											   cs.setString(1, (String) (request.getParameter("Duser")) );
											   rs = cs.executeQuery();
											   ArrayList<Integer> tlist = new ArrayList<Integer>(); 
											   while (rs.next()) 
											   {
													tlist.add( (rs.getInt("tid")));
													//out.println("<h2> <center>" + rs.getInt("t.tid") + " </center> </h2>");
											   }
											   for(int i =0;i<tlist.size(); i++)
											   {
												   //HASHTAG
									   			   ArrayList<String> hlist = new ArrayList<String>();
												   String hashlist ="Select h.thashtagname from tweetHashtag h where h.ttid = (?)";
												   cs = conn.prepareCall(hashlist);
												   cs.clearParameters();
												   cs.setInt(1, tlist.get(i));
												   rs = cs.executeQuery();
												   while (rs.next()) 
												   {
														hlist.add( (rs.getString("h.thashtagname")));
														//out.println("<h2> <center>" + rs.getString("h.thashtagname") + " </center> </h2>");
												   }
												   for(int j =0; j<hlist.size(); j++)
												   {
												        String countquery = "select t.tscreen_name from tweet t, tweetHashtag h where h.thashtagname = (?) and t.tid = h.ttid  group by t.tscreen_name";
														cs = conn.prepareCall(countquery);
														cs.clearParameters();
														cs.setString(1, hlist.get(j));
														rs = cs.executeQuery();

														size =0;
														if (rs != null) 
														{
															rs.last();    
															size = rs.getRow(); 
														}
														if(size ==1)
														{
															winalldayy= hlist.get(j);
															triggered =1;

														}
												   }


												   //URL
												   ArrayList<String> ulist = new ArrayList<String>();
												   String Urllist ="Select u.turlname from tweetUrl u where u.ttid = (?)";
												   cs = conn.prepareCall(Urllist);
												   cs.clearParameters();
												   cs.setInt(1, tlist.get(i));
												   rs = cs.executeQuery();
												   while (rs.next()) 
												   {
														ulist.add( (rs.getString("u.turlname")));
														//out.println("<h2> <center>" + rs.getString("u.turlname") + " </center> </h2>");
												   }
												   for(int j =0; j<ulist.size(); j++)
												   {
												   String countquery = "select t.tscreen_name from tweet t, tweetUrl u where u.turlname = (?) and t.tid = u.ttid  group by t.tscreen_name";
														cs = conn.prepareCall(countquery);
														cs.clearParameters();
														cs.setString(1, ulist.get(j));
														rs = cs.executeQuery();

														size =0;
														if (rs != null) 
														{
															rs.last();    
															size = rs.getRow(); 
														}
														if(size ==1)
														{
														out.println("<h2> <center>" + "----------------------------------" + " </center> </h2>");
															uwinalldayy= ulist.get(j);
															utriggered =1;

														}
												   }
											   }
									   }
							   }	   
						}

									int r = cstmt.executeUpdate();
									if(triggered==1)
									{
																	String finalDelete = "delete from hashtag where hashtag.hashtagname = (?)";
																	CallableStatement cs = conn.prepareCall(finalDelete);
																	cs.clearParameters();
																	cs.setString(1, winalldayy);
																	int testing = cs.executeUpdate();
																	if(testing ==1)
																	{
																		out.println("<h4> <center>" + "-Hashtag Table Delete: Successfull-" + " </center> </h4>");
																	}
									}

									if(utriggered==1)
									{
																	String finalDelete = "delete from url where url.urlname= (?)";
																	CallableStatement cs = conn.prepareCall(finalDelete);
																	cs.clearParameters();
																	cs.setString(1, uwinalldayy);
																	int testing = cs.executeUpdate();
																	if(testing ==1)
																	{
																		out.println("<h4> <center>" + "-URL Table Delete: Successfull-" + " </center> </h4>");
																	}
									}

									if(r ==1)
									{

										out.println("<h4> <center>" + "-tweetUrl Table: Successfull-" + " </center> </h4>");
										out.println("<h4> <center>" + "-tweetHashtag Table Delete: Successfull-" + " </center> </h4>");
										out.println("<h4> <center>" + "-Tweet Table Delete: Successfull-" + " </center> </h4>");
										out.println("<h4> <center>" + "-UUser Table Delete: Successfull-" + " </center> </h4>");
										out.println("<h2> <center>" + "----------------------------------" + " </center> </h2>");
										out.println("<h2> <center>" + "Delete Successfull" + " </center> </h2>");
									}
				

									conn.close();
									redirect=0;
				   }			
			 }
			 else
			 {
					out.println("<br><br><h2><center>" +"You are not an Admin. You need to be an Admin to insert or delete."+ "</center></h2>");	
					%>
					<center>
					<form action="query.jsp"> 
					<input type="submit" value = "Back">
					</form>
					</center>
					<%
			 }




		  	

	  }
  }
  }
  catch (Exception e) 
  {
			
			if(e != null)
			{
				if(e.getMessage() != "")
				{
				String mystring = e.getMessage();
				String arr[] = mystring.split(" ");
				String firstWord = arr[0];
					
					if(firstWord.equals("Duplicate"))
					{
						out.println("<h2> You have entered a username that already exists. Please try again with a different username." + "</h4>");
					}
					else if(e.getMessage().equals("/ by zero"))
					{
						out.println("<h2>" +"Please Login First."+ "</h2>");
							%>
								<form action="login.jsp">
								<input type="submit" value="Back"/>
								</form>
							<%
					}
					else if(mystring.equals("For input string: \"\""))
					{
						out.println("<h2>" +"Please enter the fields correctly to see the results."+ "</h2>");
					}
					else
					{
						out.println("<h2>An exception occurred: " + e.getMessage() + "</h4>");
				}	}
			}
  }
  %>
  </body>
</html>