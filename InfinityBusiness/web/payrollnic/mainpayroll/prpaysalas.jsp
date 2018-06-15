<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String payrollId	= request.getParameter("payrollId")==null?"0":request.getParameter("payrollId");
 String emplType	= request.getParameter("emplType")==null?"0":request.getParameter("emplType");

 String buff 		= "";
 String updRec		= "N";
 int count 			= Integer.parseInt(request.getParameter("rows")==null?"0":request.getParameter("rows"));
 int realcount = 0;
 
 				for (int i = 0; i < count; i++)
				{
						updRec = request.getParameter("updRec" + i);
						
						if (updRec.equals("Y"))
						{
							buff = buff + request.getParameter("lineId" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("employeeId" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("daysMiss" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("amountMiss" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("agingMiss" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("exHR" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("exHRAmt" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("ferHR" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("ferHRAmt" + i) + ConstantValue.DELIMITER;							
							buff = buff + request.getParameter("septHR" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("septHRAmt" + i) + ConstantValue.DELIMITER;							
							buff = buff + request.getParameter("vacDays" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("vacAmt" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("rvacDays" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("rvacAmt" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("sickCat" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("sickDays" + i) + ConstantValue.DELIMITER;							
							buff = buff + request.getParameter("sickAmt" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("interAmt" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("totalAmt" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("wrkDays" + i) + ConstantValue.DELIMITER;
							buff = buff + request.getParameter("rwrkDays" + i) + ConstantValue.DELIMITER;
							realcount++; 
						}	
				}
 
 String lineId = "0";
 String emplId = "0";
 String emplNum= "0";
 
 if((emplType.equals("") || emplType.equals("0")) && realcount > 0)
 	emplType = Integer.toString(realcount);
 
 String action		 	= request.getParameter("action")==null?"":request.getParameter("action"); 
 
 String contextRoot = request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim(); 
 	
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRPAYSALAS('" + 
 					companyID + "'," + 
 					companyEID + "," +
 					lineId + "," + 
 					payrollId + "," +
 					emplType + "," +
 					emplId + ",'" +
 					emplNum + "',0,0,'" + buff.toString() +"','" + who + "','" + ip + "','"+action +"',?,?)}";

 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="prpaysalasDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prpaysalasDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prpaysalasDBBean" />
</jsp:useBean>
<%
 prpaysalasDBBean.closeResultSet();
 prpaysalasDBBean.execute();
 prpaysalasDBBean.closeResultSet();
 
 String flag   = prpaysalasDBBean.getErrorFlag();
 String errMsg = prpaysalasDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S") && !action.equals("UPDPAYSALR")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/mainpayroll/mainpayrolllist.jsp");
 }
 else if(flag.equals("S") && action.equals("UPDPAYSALR")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/mainpayroll/wrkpaysalarybysect.jsp?payrollId=" + payrollId);
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