<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String Id	 		= request.getParameter("Id")==null?"":request.getParameter("Id");
 String wageId 		= request.getParameter("wageId")==null?"":request.getParameter("wageId");  
 String years 		= request.getParameter("years")==null?"":request.getParameter("years");
 String percentage	= request.getParameter("percentage")==null?"":request.getParameter("percentage");
 String amount	 	= request.getParameter("amount")==null?"":request.getParameter("amount");       
 
 String action		= request.getParameter("action")==null?"":request.getParameter("action"); 
 
 String contextRoot = request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim(); 
 	
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRAGINGS('" + 
 					companyID + "'," +
 					companyEID + "," +
 					(Id.equals("")?"0":Id) +"," + 
 					wageId + "," +
 					(years.equals("")?"0":years) + "," +
 					(percentage.equals("")?"0":percentage) + "," +
 					(amount.equals("")?"0":amount) + ",'" + 
 					who + "','" +
 					ip + "','" +
 					action + "',?,?)}"; 
 					
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="agingsDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="agingsDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="agingsDBBean" />
</jsp:useBean>
<%
 agingsDBBean.closeResultSet();
 agingsDBBean.execute();
 agingsDBBean.closeResultSet();
 
 String flag   = agingsDBBean.getErrorFlag();
 String errMsg = agingsDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/wages/aginglist.jsp?wageId=" +wageId);
 }
 else if(flag.equals("F") && action.equals("AGADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="agingadd.jsp"/>
<%
 } 
 else if(flag.equals("F") && action.equals("AGUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="agingupd.jsp"/>
 <%
 }
 %>