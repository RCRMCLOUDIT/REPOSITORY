<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String Id	 		= request.getParameter("Id")==null?"":request.getParameter("Id");
 String name 		= request.getParameter("name")==null?"":request.getParameter("name");
 String descrp 		= request.getParameter("descrp")==null?"":request.getParameter("descrp");
 String taxOrd 		= request.getParameter("taxOrd")==null?"":request.getParameter("taxOrd");
 String taxType 	= request.getParameter("taxType")==null?"":request.getParameter("taxType");
 String calBSON 	= request.getParameter("calBSON")==null?"":request.getParameter("calBSON");
 
 String compRT 		= request.getParameter("compRT")==null?"":request.getParameter("compRT");
 String emplRT 		= request.getParameter("emplRT")==null?"":request.getParameter("emplRT");
 String compAM 		= request.getParameter("compAM")==null?"":request.getParameter("compAM");
 String emplAM 		= request.getParameter("emplAM")==null?"":request.getParameter("emplAM");       
 
 String maxAmt 		= request.getParameter("maxAmt")==null?"0":request.getParameter("maxAmt");       

 String vendorId 	= request.getParameter("vendorId")==null?"":request.getParameter("vendorId");  

 //CUENTA DE DEBITO	
 String level1 	= request.getParameter("level1")==null?"":request.getParameter("level1");  

 //CUENTA DE CREDITO
 String level2 	= request.getParameter("level2")==null?"":request.getParameter("level2");  
 
 String action		 	= request.getParameter("action")==null?"":request.getParameter("action"); 
 
 String isINSS	= "N";
 String isIR	= "N";		
 
 if(taxType.equals("SS"))
 {
 	isINSS  = "Y";
 	isIR	= "N";
 }
 else if(taxType.equals("IR"))
 {
 	isINSS  = "N";
 	isIR	= "Y";
 }
 else
 {
 	isINSS  = "N";
 	isIR	= "N"; 
 }
 
 String contextRoot = request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim(); 
 	
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRTAXES('" + 
 					companyID + "'," +
 					companyEID + "," +
 					(Id.equals("")?"0":Id) + ",'" +
 					name + "','" +
 					descrp + "'," +
 					(taxOrd.equals("")?"0":taxOrd) + ",'" +
 					isINSS + "','" +
 					isIR + "','" +
 					calBSON + "'," +
 					(vendorId.equals("")?"0":vendorId) + ",'" +
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
 					(emplRT.equals("")?"0":emplRT) + "," +
 					(compRT.equals("")?"0":compRT) + "," +
 					(emplAM.equals("")?"0":emplAM) + "," +
 					(compAM.equals("")?"0":compAM) + ",'" +
 					who + "','" +
 					ip + "','"
 					+ action + "'," + (maxAmt.equals("")?"0":maxAmt) + ",?,?)}";
 					
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="prtaxesDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prtaxesDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prtaxesDBBean" />
</jsp:useBean>
<%
 prtaxesDBBean.closeResultSet();
 prtaxesDBBean.execute();
 prtaxesDBBean.closeResultSet();
 
 String flag   = prtaxesDBBean.getErrorFlag();
 String errMsg = prtaxesDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/taxes/taxlist.jsp");
 }
 else if(flag.equals("F") && action.equals("TAXADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="taxadd.jsp"/>
<%
 } 
 else if(flag.equals("F") && action.equals("TAXUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="taxupd.jsp"/>
 <%
 }
 %>