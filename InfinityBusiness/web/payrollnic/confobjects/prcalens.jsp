<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String action 			= request.getParameter("action")==null?"":request.getParameter("action");
 
 String custName	= request.getParameter("custName")==null?"":request.getParameter("custName");
 String objName		= request.getParameter("objName")==null?"":request.getParameter("objName");
 
 String custEid		= request.getParameter("custEid")==null?"0":request.getParameter("custEid");
 String objectId	= request.getParameter("objectId")==null?"0":request.getParameter("objectId");
  
 String descrp 		= request.getParameter("descrp")==null?"":request.getParameter("descrp");
 String emplType	= request.getParameter("emplType")==null?"":request.getParameter("emplType");

 String cratDT	 = request.getParameter("cratDT")==null?"":request.getParameter("cratDT");         
 String from	= request.getParameter("from")==null?"":request.getParameter("from");         
 String to	 	= request.getParameter("to")==null?"":request.getParameter("to");         

 String creatById 	= request.getParameter("creatById")==null?"0":request.getParameter("creatById");
 String checkById 	= request.getParameter("checkById")==null?"0":request.getParameter("checkById");
 String autById 	= request.getParameter("autById")==null?"0":request.getParameter("autById");
 
 String byEmployee			=  request.getParameter("byEmployee")==null?"Y":request.getParameter("byEmployee");
 String employeeMastId 		= request.getParameter("employeeMastId")==null?"":request.getParameter("employeeMastId");
 String	emplMastSalQ		= request.getParameter("emplMastSalQ")==null?"":request.getParameter("emplMastSalQ");
 String	employeeMastName	= request.getParameter("employeeMastName")==null?"":request.getParameter("employeeMastName"); 
  
 String contextRoot = request.getParameter("contextRoot");
 
 String proyId		= request.getParameter("proyId")==null?"0":request.getParameter("proyId");
 
 String startValidate = request.getParameter("startValidate")==null?"N":request.getParameter("startValidate");
 
 String days		= request.getParameter("days")==null?"0":request.getParameter("days");
 
 StringBuffer buff 	= new StringBuffer();
 String updRec		= "N";
 int count 			= Integer.parseInt(request.getParameter("rows")==null?"0":request.getParameter("rows"));
 int realcount 		= 0;
 Boolean passBy		= false;
 
 				for (int i = 0; i < count; i++)
				{
					if(byEmployee.equals("Y"))
					{
						if(!(request.getParameter("employeeId" + i)).equals("0"))
						{
							buff.append(request.getParameter("lineId" + i)==null?"0":request.getParameter("lineId" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("emplSalQ" + i)==null?"0":request.getParameter("emplSalQ" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("employeeId" + i)==null?"0":request.getParameter("employeeId" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day1Hrs" + i)==null?"0":request.getParameter("day1Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day2Hrs" + i)==null?"0":request.getParameter("day2Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day3Hrs" + i)==null?"0":request.getParameter("day3Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day4Hrs" + i)==null?"0":request.getParameter("day4Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day5Hrs" + i)==null?"0":request.getParameter("day5Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day6Hrs" + i)==null?"0":request.getParameter("day6Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day7Hrs" + i)==null?"0":request.getParameter("day7Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day8Hrs" + i)==null?"0":request.getParameter("day8Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day9Hrs" + i)==null?"0":request.getParameter("day9Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day10Hrs" + i)==null?"0":request.getParameter("day10Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day11Hrs" + i)==null?"0":request.getParameter("day11Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day12Hrs" + i)==null?"0":request.getParameter("day12Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day13Hrs" + i)==null?"0":request.getParameter("day13Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day14Hrs" + i)==null?"0":request.getParameter("day14Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day15Hrs" + i)==null?"0":request.getParameter("day15Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							if(days.equals("16"))
							{
								buff.append(request.getParameter("day16Hrs" + i)==null?"0":request.getParameter("day16Hrs" + i));
							}
							else
							{
								buff.append("0");
							}					
							buff.append(ConstantValue.DELIMITER);									
							buff.append(request.getParameter("hp" + i)==null?"0":request.getParameter("hp" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("ord" + i)==null?"0":request.getParameter("ord" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("ext" + i)==null?"0":request.getParameter("ext" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("total" + i)==null?"0":request.getParameter("total" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("ordAMT" + i)==null?"0":request.getParameter("ordAMT" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("extAMT" + i)==null?"0":request.getParameter("extAMT" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append("0");
							buff.append(ConstantValue.DELIMITER);
							
							realcount++; 
						}//END OF IF EMPLOYEE ID != 0
					}
					else
					{
						if(!(request.getParameter("objectId" + i)).equals("0"))
						{
							buff.append(request.getParameter("lineId" + i)==null?"0":request.getParameter("lineId" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(emplMastSalQ);
							buff.append(ConstantValue.DELIMITER);
							buff.append(employeeMastId);
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day1Hrs" + i)==null?"0":request.getParameter("day1Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day2Hrs" + i)==null?"0":request.getParameter("day2Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day3Hrs" + i)==null?"0":request.getParameter("day3Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day4Hrs" + i)==null?"0":request.getParameter("day4Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day5Hrs" + i)==null?"0":request.getParameter("day5Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day6Hrs" + i)==null?"0":request.getParameter("day6Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day7Hrs" + i)==null?"0":request.getParameter("day7Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day8Hrs" + i)==null?"0":request.getParameter("day8Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day9Hrs" + i)==null?"0":request.getParameter("day9Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day10Hrs" + i)==null?"0":request.getParameter("day10Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day11Hrs" + i)==null?"0":request.getParameter("day11Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day12Hrs" + i)==null?"0":request.getParameter("day12Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day13Hrs" + i)==null?"0":request.getParameter("day13Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day14Hrs" + i)==null?"0":request.getParameter("day14Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("day15Hrs" + i)==null?"0":request.getParameter("day15Hrs" + i));
							buff.append(ConstantValue.DELIMITER);
							if(days.equals("16"))
							{
								buff.append(request.getParameter("day16Hrs" + i)==null?"0":request.getParameter("day16Hrs" + i));
							}
							else
							{
								buff.append("0");
							}					
							buff.append(ConstantValue.DELIMITER);									
							buff.append(request.getParameter("hp" + i)==null?"0":request.getParameter("hp" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("ord" + i)==null?"0":request.getParameter("ord" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("ext" + i)==null?"0":request.getParameter("ext" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("total" + i)==null?"0":request.getParameter("total" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("ordAMT" + i)==null?"0":request.getParameter("ordAMT" + i));
							buff.append(ConstantValue.DELIMITER);
							buff.append(request.getParameter("extAMT" + i)==null?"0":request.getParameter("extAMT" + i));
							buff.append(ConstantValue.DELIMITER);							
							buff.append(request.getParameter("objectId" + i)==null?"0":request.getParameter("objectId" + i));
							buff.append(ConstantValue.DELIMITER);
							
							realcount++; 
						}	
					}//END OF ELSE	
				}//END OF FOR
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim();
 
 if(action.equals("DETAILAU"))
 	checkById = String.valueOf(realcount);

 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCALENS('" + 
 					companyID + "',0," + custEid + "," + objectId + "," + proyId + ",'" +
 					Format.strDatetoSQLDate(cratDT) + "','" +
 					Format.strDatetoSQLDate(from) + "','" +
 					Format.strDatetoSQLDate(to) + "','" +
 					descrp + "'," +
 					creatById + "," +
 					checkById + "," +
 					autById + ",'" +
 					buff.toString() + "','" +
 					who + "','" + 
 					ip + "','" + action+ "',?,?)}"; 

 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="prcalensDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prcalensDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prcalensDBBean" />
</jsp:useBean>
<%
 prcalensDBBean.closeResultSet();
 prcalensDBBean.execute();
 prcalensDBBean.closeResultSet();
 
 String flag   = prcalensDBBean.getErrorFlag();
 String errMsg = prcalensDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S") && action.equals("ADDPRGH")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confobjects/objectslist.jsp?proyId=" + errMsg);
 }
 else if(flag.equals("S") && action.equals("UPDPRGH")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confobjects/programlist.jsp");
 }
 else if(flag.equals("S") && !action.equals("OBJECTADD") && action.equals("DETAILAU") && byEmployee.equals("Y")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confobjects/programdetail.jsp?custName=" + custName + "&objName=" + objName + "&objectId=" + objectId + "&proyId=" + proyId + "&custEid=" + custEid);
 }
 else if(flag.equals("S") && !action.equals("OBJECTADD") && action.equals("DETAILAU") && byEmployee.equals("N")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confobjects/programdetailempl.jsp?proyId=" + proyId + "&employeeMastId=" + employeeMastId + "&employeeMastName=" + employeeMastName + "&emplMastSalQ=" + emplMastSalQ);
 }  
 else if(flag.equals("S") && !action.equals("OBJECTADD") && !action.equals("DETAILUPD") && !action.equals("CHGSTATUS") && !action.equals("GENPAY") && !action.equals("VALSAL") && !action.equals("UPDPRGH")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confobjects/objectslist.jsp");
 } 
 else if(flag.equals("S") && action.equals("CHGSTATUS") && startValidate.equals("N")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confobjects/programlist.jsp");
 } 
 else if(flag.equals("S") && action.equals("CHGSTATUS") && startValidate.equals("Y")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confobjects/objectslist.jsp?proyId=" + proyId);
 }
 else if((flag.equals("S") && action.equals("GENPAY")) || action.equals("VALSAL"))
 {
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confobjects/programlist.jsp");
 }   
 else if(flag.equals("F") && action.equals("ADDPRGH"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="newprogram.jsp"/>
 <%
 }
 else if(flag.equals("F") && action.equals("UPDPRGH"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="editprogram.jsp"/>
 <%
 }
  else if(flag.equals("F") && action.equals("DETAILAU") && byEmployee.equals("Y"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="programdetail.jsp"/>
 <%
 }
  else if(flag.equals("F") && action.equals("DETAILAU") && byEmployee.equals("N"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="programdetailempl.jsp"/>
 <%
 }
 %>