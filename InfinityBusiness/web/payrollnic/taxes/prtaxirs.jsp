<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String Id	 		= request.getParameter("Id")==null?"":request.getParameter("Id");
 String taxId 		= request.getParameter("taxId")==null?"":request.getParameter("taxId");  
 String minAmt 		= request.getParameter("minAmt")==null?"":request.getParameter("minAmt");
 String maxAmt 		= request.getParameter("maxAmt")==null?"":request.getParameter("maxAmt");
 String percentage	= request.getParameter("percentage")==null?"":request.getParameter("percentage");
 String baseAmt 	= request.getParameter("baseAmt")==null?"":request.getParameter("baseAmt");
 String overAmt 	= request.getParameter("overAmt")==null?"":request.getParameter("overAmt");        
 
 String action		= request.getParameter("action")==null?"":request.getParameter("action"); 
 
 String contextRoot = request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim(); 
 	
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRTAXIRS('" + 
 					companyID + "'," +
 					companyEID + "," +
 					(Id.equals("")?"0":Id) +"," + 
 					taxId + "," +
 					(minAmt.equals("")?"0":minAmt) + "," +
 					(maxAmt.equals("")?"0":maxAmt) + "," +
 					(percentage.equals("")?"0":percentage) + "," +
 					(baseAmt.equals("")?"0":baseAmt) + "," + 
 					(overAmt.equals("")?"0":overAmt) + ",'" +
 					who + "','" +
 					ip + "','" +
 					action + "',?,?)}"; 
 					
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="prtaxirsDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prtaxirsDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prtaxirsDBBean" />
</jsp:useBean>
<%
 prtaxirsDBBean.closeResultSet();
 prtaxirsDBBean.execute();
 prtaxirsDBBean.closeResultSet();
 
 String flag   = prtaxirsDBBean.getErrorFlag();
 String errMsg = prtaxirsDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/taxes/taxirlist.jsp?taxId=" +taxId);
 }
 else if(flag.equals("F") && action.equals("IRADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="taxiradd.jsp"/>
<%
 } 
 else if(flag.equals("F") && action.equals("IRUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="taxirupd.jsp"/>
 <%
 }
 %>