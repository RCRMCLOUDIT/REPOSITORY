<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String name 		= request.getParameter("name")==null?"":request.getParameter("name");
 String Id			= request.getParameter("Id")==null?"0":request.getParameter("Id");
 String abrv 		= request.getParameter("abrv")==null?"":request.getParameter("abrv");
 String action 		= request.getParameter("action")==null?"":request.getParameter("action"); 
 
 String tpMngrId = request.getParameter("tpMngrId")==null?"0":request.getParameter("tpMngrId");
 String tpMngrDS = request.getParameter("tpMngrDS")==null?"0":request.getParameter("tpMngrDS");
 
 String empCustId		= request.getParameter("empCustId")==null?"":request.getParameter("empCustId");
 
 String ccType = "";
 String ccId1  = "";
 String ccId2  = "";
 BigDecimal tsk1 = new BigDecimal("0");
 BigDecimal tsk2 = new BigDecimal("0");
 
 if(!empCustId.equals(""))
 {
	int temp = 0;

	temp		= empCustId.indexOf(ConstantValue.DELIMITER);
	ccType 		= empCustId.substring(0,temp);
	empCustId	= empCustId.substring(temp + 3);

	temp 		= empCustId.indexOf(ConstantValue.DELIMITER);
	ccId1 		= empCustId.substring(0,temp);
	empCustId 	= empCustId.substring(temp + 3);

	temp		= empCustId.indexOf(ConstantValue.DELIMITER);
	ccId2 		= empCustId.substring(0,temp);
	empCustId	= empCustId.substring(temp + 3);

	temp 		= empCustId.indexOf(ConstantValue.DELIMITER);
	tsk1 		= new java.math.BigDecimal(empCustId.substring(0,temp));
	empCustId	= empCustId.substring(temp + 3);

	temp = empCustId.indexOf(ConstantValue.DELIMITER);
	tsk2 = new java.math.BigDecimal(empCustId.substring(0,temp));
 } 
 
 String contextRoot = request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim();

 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRSETUPPYS('" + 
 					companyID + "',0," +
 					new BigDecimal(Id) + ",'" +
 					name.trim() + "','" +
 					abrv.trim() + "'," +
 					tpMngrId + ",'" +
 					ccType + "','" +
 					ccId1 + "','" +
 					ccId2 + "'," +
 					tsk1 + "," +
 					tsk2 + ",'" +
 					who + "','" +
 					ip + "','" + action + "',?,?)}"; 
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="prsetuppysDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prsetuppysDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prsetuppysDBBean" />
</jsp:useBean>
<%
 prsetuppysDBBean.closeResultSet();
 prsetuppysDBBean.execute();
 prsetuppysDBBean.closeResultSet();
 
 String flag   = prsetuppysDBBean.getErrorFlag();
 String errMsg = prsetuppysDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S") && (action.equals("EMPTYPADD") || action.equals("EMPTYPUPD"))){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confgeneral/employeetypelist.jsp");
 }
 else if(flag.equals("S") && (action.equals("TPMNGRADD") || action.equals("TPMNGRUPD"))){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confgeneral/topmanagerlist.jsp");
 } 
 else if(flag.equals("S") && (action.equals("DEPARTADD") || action.equals("DEPARTUPD"))){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confgeneral/departmentlist.jsp?tpMngrId=" + tpMngrId + "&tpMngrDS=" + tpMngrDS);
 }  
 else if(flag.equals("F") && action.equals("EMPTYPADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="employeetypeadd.jsp"/>
<%
 } 
 else if(flag.equals("F") && action.equals("EMPTYPUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="employeetypeupd.jsp"/>
 <%
 }
 else if(flag.equals("F") && action.equals("TPMNGRADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="topmanageradd.jsp"/>
<%
 } 
 else if(flag.equals("F") && action.equals("TPMNGRUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="topmanagerupd.jsp"/>
 <%
 }
 else if(flag.equals("F") && action.equals("DEPARTADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="departmentadd.jsp"/>
<%
 } 
 else if(flag.equals("F") && action.equals("DEPARTUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="departmenupd.jsp"/>
 <%
 }
 %>