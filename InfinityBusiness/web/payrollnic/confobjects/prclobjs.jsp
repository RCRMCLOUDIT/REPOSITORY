<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String action 			= request.getParameter("action")==null?"":request.getParameter("action");
 
 String proyId	 		= request.getParameter("proyId")==null?"0":request.getParameter("proyId");
 
 String objectId 		= request.getParameter("objectId")==null?"0":request.getParameter("objectId");
 String objName 		= request.getParameter("objName")==null?"":request.getParameter("objName");
 String objAddress		= request.getParameter("objAddress")==null?"0":request.getParameter("objAddress");
 String objCode 	= request.getParameter("objCode")==null?"":request.getParameter("objCode");
 
 String customerId 		= request.getParameter("customerId")==null?"0":request.getParameter("customerId");
 String customerName	= request.getParameter("customerName")==null?"":request.getParameter("customerName");
 
 String empId 			= request.getParameter("empId")==null?"":request.getParameter("empId"); 
 String empName 		= request.getParameter("empName")==null?"":request.getParameter("empName");
 
 String hours 			= request.getParameter("hours")==null?"0":request.getParameter("hours");
 String post 			= request.getParameter("post")==null?"0":request.getParameter("post");
  
 String contextRoot = request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim();

 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCLOBJS('" + 
 					companyID + "'," +
 					companyEID +"," +
 					new BigDecimal(customerId) + ","+
 					new BigDecimal(objectId) + ","+
 					hours + ","+
 					post + "," +
 					empId +",'" +
 					objName.trim() + "','" +
 					objAddress.trim() + "','" +
 					who + "','" +
 					ip + "','" + action + "','" + objCode + "',?,?)}"; 
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="prclobjsDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prclobjsDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prclobjsDBBean" />
</jsp:useBean>
<%
 prclobjsDBBean.closeResultSet();
 prclobjsDBBean.execute();
 prclobjsDBBean.closeResultSet();
 
 String flag   = prclobjsDBBean.getErrorFlag();
 String errMsg = prclobjsDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S") && action.equals("OBJECTADD")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confobjects/objectslist.jsp?proyId=" + proyId);
 }
 else if(flag.equals("S") && !action.equals("OBJECTADD")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confobjects/objectslist.jsp?proyId=" + proyId);
 } 
 else if(flag.equals("F") && action.equals("OBJECTADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="objectadd.jsp"/>
 <%
 }
 else if(flag.equals("F") && action.equals("OBJECTUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="objectupd.jsp"/>
 <%
 }
 %>