<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String payrollId	= request.getParameter("payrollId")==null?"0":request.getParameter("payrollId");
 String descrp 		= request.getParameter("descrp")==null?"":request.getParameter("descrp");
 String payrollType	= request.getParameter("payrollType")==null?"":request.getParameter("payrollType");

 String emplType	= request.getParameter("emplType")==null?"":request.getParameter("emplType");

 String currId   = request.getParameter("currId")==null?"":request.getParameter("currId");
 String cratDT	 = request.getParameter("cratDT")==null?"":request.getParameter("cratDT");         

 String from	= request.getParameter("from")==null?"":request.getParameter("from");         
 String to	 	= request.getParameter("to")==null?"":request.getParameter("to");         
 
 String pyDecPay 	= request.getParameter("pyDecPay")==null?"":request.getParameter("pyDecPay");
 
 String creatById 	= request.getParameter("creatById")==null?"":request.getParameter("creatById");
 String checkById 	= request.getParameter("checkById")==null?"":request.getParameter("checkById"); 
 String autById 	= request.getParameter("autById")==null?"":request.getParameter("autById");
 String payById 	= request.getParameter("payById")==null?"":request.getParameter("payById");
 
 String action		 	= request.getParameter("action")==null?"":request.getParameter("action"); 
 
 String contextRoot = request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim(); 
 	
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCRTPARS('" + 
 					companyID + "'," + 
 					companyEID + "," + 
 					payrollId + ",'" +
 					payrollType + "','" +
 					descrp + "'," +
 					emplType + ",'" +
 					currId + "','" +
 					Format.strDatetoSQLDate(cratDT) + "','" +
 					Format.strDatetoSQLDate(from) + "','" +
 					Format.strDatetoSQLDate(to) + "','" + pyDecPay +"'," + 
 					(creatById.equals("")?"0":creatById) + "," +
 					(checkById.equals("")?"0":checkById) + "," +
 					(autById.equals("")?"0":autById) + "," +
 					(payById.equals("")?"0":payById) + ",'" +
 					action +"',?,?)}";

 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="prcrtparsDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prcrtparsDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prcrtparsDBBean" />
</jsp:useBean>
<%
 prcrtparsDBBean.closeResultSet();
 prcrtparsDBBean.execute();
 prcrtparsDBBean.closeResultSet();
 
 String flag   = prcrtparsDBBean.getErrorFlag();
 String errMsg = prcrtparsDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/mainpayroll/mainpayrolllist.jsp?emptTypeId="+emplType);
 }
 else if(flag.equals("F") && action.equals("ADDPYR"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="mainpayrolladd.jsp"/>
<%
 } 
 else if(flag.equals("F") && action.equals("UPDPYR"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="mainpayrollupd.jsp"/>
 <%
 }
 %>