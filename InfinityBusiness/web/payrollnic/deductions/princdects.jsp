<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String Id	 		= request.getParameter("Id")==null?"":request.getParameter("Id");
 String name 		= request.getParameter("name")==null?"":request.getParameter("name");
 String descrp 		= request.getParameter("descrp")==null?"":request.getParameter("descrp");
 String concType 	= request.getParameter("concType")==null?"":request.getParameter("concType");       

 String seizable 	= request.getParameter("seizable")==null?"":request.getParameter("seizable"); 

 String isIncome 	= request.getParameter("isIncome")==null?"":request.getParameter("isIncome"); 
 String isDeduction = request.getParameter("isDeduction")==null?"":request.getParameter("isDeduction"); 
 String status	 	= request.getParameter("status")==null?"":request.getParameter("status");   
 
 String vendorId	= request.getParameter("vendorId")==null?"":request.getParameter("vendorId");   
 String order		= request.getParameter("order")==null?"":request.getParameter("order");  

 String isAging		= request.getParameter("isAging")==null?"N":request.getParameter("isAging");
 String percent		= request.getParameter("percent")==null?"":request.getParameter("percent");
 String amount		= request.getParameter("amount")==null?"":request.getParameter("amount");
 String dedType		= request.getParameter("dedType")==null?"O":request.getParameter("dedType");
 
 //CUENTA DE DEBITO	
 String level1 	= request.getParameter("level1")==null?"":request.getParameter("level1");  

 //CUENTA DE CREDITO
 String level2 	= request.getParameter("level2")==null?"":request.getParameter("level2");  
 
 String action		 	= request.getParameter("action")==null?"":request.getParameter("action"); 
 
 String contextRoot = request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim(); 
 	
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRINCDECTS('" + 
 					companyID + "'," +
 					companyEID + "," +
 					(Id.equals("")?"0":Id) + ",'" +
 					name + "','" +
 					descrp + "','" +
 					isIncome + "','" +
 					isDeduction + "','" +
 					(concType.equals("F")?"Y":"N") + "','" +
 					(concType.equals("V")?"Y":"N") + "','" +
 					(level1.length() == 15?level1.substring(0,3):"000")   + "','" +
 					(level1.length() == 15?level1.substring(3,6):"000")   + "','" +
 					(level1.length() == 15?level1.substring(6,9):"000")   + "','" + 
 					(level1.length() == 15?level1.substring(9,12):"000")  + "','" +
 					(level1.length() == 15?level1.substring(12,15):"000") + "','" +
 					(level2.length() == 15?level2.substring(0,3):"000")   + "','" +
 					(level2.length() == 15?level2.substring(3,6):"000")   + "','" +
 					(level2.length() == 15?level2.substring(6,9):"000")   + "','" +
 					(level2.length() == 15?level2.substring(9,12):"000")  + "','" +
 					(level2.length() == 15?level2.substring(12,15):"000") + "',"  + 			
 					(vendorId.equals("")?"0":vendorId) +",'" +
 					seizable + "','" + dedType + "','" +
 					status + "','1'," +
 					(order.equals("")?"0":order) + ",'"+
 					who +"','" +
 					ip +"','" +
 					isAging + "'," +
 					(percent.equals("")?"0":percent) + "," +
 					(amount.equals("")?"0":amount) + ",'" +
					action + "','',?,?)}";
 					
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="princdectsDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="princdectsDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="princdectsDBBean" />
</jsp:useBean>
<%
 princdectsDBBean.closeResultSet();
 princdectsDBBean.execute();
 princdectsDBBean.closeResultSet();
 
 String flag   = princdectsDBBean.getErrorFlag();
 String errMsg = princdectsDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/deductions/deductionslist.jsp");
 }
 else if(flag.equals("F") && action.equals("INCDEDADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="deductionsadd.jsp"/>
<%
 } 
 else if(flag.equals("F") && action.equals("INCDEDUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="deductionsupd.jsp"/>
 <%
 }
 %>