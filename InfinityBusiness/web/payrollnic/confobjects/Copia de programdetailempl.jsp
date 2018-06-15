<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Detalle de Programacion</TITLE>
</HEAD> 
 <BODY onload="cal_total_days();">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Detalle de Programacion";
 
 static final int CUR_HEADINF = 1;
 static final int CUR_DEATINF = 2;
 static final int OBJECT_CUR  = 3;
 
 static final int COOBJID_COLUMN		= 1; //OBJECT ID COLUMN
 static final int COCUSTEID_COLUMN		= 2; //CUSTOMER EID
 static final int CUSTNAME_COLUMN		= 3; //CUSTOMER NAME
 static final int COOBJNAME_COLUMN		= 4; //OBJECT NAME
 static final int COOBJADDR_COLUMN		= 5; //OBJECT ADDRRESS 
 static final int COSUPVR_COLUMN		= 6; //SUPERVISOR 
 static final int COHOURS_COLUMN		= 7; //HOURS
 static final int COPOST_COLUMN			= 8; //POSITIONS  
 static final int COOBJCODE_COLUMN		= 9; //OBJECT CODE 
 
 static final int PHDESCRH_COLUMN = 2;
 static final int PHFDATE_COLUMN  = 3;
 static final int PHTDATE_COLUMN  = 4;
 static final int DAYS_COLUMN 	  = 5;        
 
 static final int PHROWID_COLUMN 	= 1;
 static final int PHCUSTEID_COLUMN 	= 2;
 static final int PHOBJID_COLUMN 	= 3;
 static final int PHEMPLID_COLUMN	= 4;
 static final int PHEMPLNM_COLUMN 	= 5;     
 static final int PHDAY1_COLUMN 	= 6;
 static final int PHDAY2_COLUMN 	= 7;
 static final int PHDAY3_COLUMN 	= 8;
 static final int PHDAY4_COLUMN 	= 9;
 static final int PHDAY5_COLUMN 	= 10;
 static final int PHDAY6_COLUMN 	= 11;
 static final int PHDAY7_COLUMN 	= 12;
 static final int PHDAY8_COLUMN 	= 13;
 static final int PHDAY9_COLUMN 	= 14;
 static final int PHDAY10_COLUMN 	= 15;
 static final int PHDAY11_COLUMN 	= 16;
 static final int PHDAY12_COLUMN 	= 17;
 static final int PHDAY13_COLUMN 	= 18;
 static final int PHDAY14_COLUMN 	= 19;
 static final int PHDAY15_COLUMN 	= 20;
 static final int PHDAY16_COLUMN 	= 21;
 static final int PHSALQ_COLUMN 	= 22;
 static final int PHDAYHP_COLUMN	= 23;
 static final int PHHRSORD_COLUMN 	= 24;
 static final int PHHRSEXT_COLUMN 	= 25;
 static final int PHAMTORD_COLUMN 	= 26;
 static final int PHAMTEXT_COLUMN 	= 27;
 static final int PHDAYTOTAL_COLUMN = 28;
 static final int PHAMTTOTAL_COLUMN = 29;
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/mainpayroll.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/searchemployees.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
 String proyId 		= request.getParameter("proyId")==null?"0":request.getParameter("proyId");
 
 String employeeMastId 		= request.getParameter("employeeMastId")==null?"":request.getParameter("employeeMastId");
 String	emplMastSalQ		= request.getParameter("emplMastSalQ")==null?"":request.getParameter("emplMastSalQ");
 String	employeeMastName	= request.getParameter("employeeMastName")==null?"":request.getParameter("employeeMastName");
 
/*******************************************************************************
 * In case we are comming from the command page due some error, the addCommandDBBean
 * object already exists from that page. It must be create in request scope
 *******************************************************************************/
 if (returnWithError.equals("Y"))
 {
       errMsg = (String)request.getAttribute("ErrorMessage");
 }
 
 /*******************************************************************************
 * build the sqlString with the call to the SP
 *******************************************************************************/ 
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCALENS('" + 
 					companyID + "',0,0,0," + proyId + ",'','','','',"+ employeeMastId +",0,0,'','','','DETAILEMPL',?,?)}"; 

 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="detailDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="detailDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="detailDBBean" />
</jsp:useBean>
<%
detailDBBean.execute(); 
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= contextRoot %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />
<%
String headerDescrip = "";
String fDate		 = "";
String tDate		 = "";
String days			 = "";
String custName		 = "";
String objName		 = "";

Date dDate	= null;

	 try
	 {
		days 			= (detailDBBean.valueAtColumnRowResult(DAYS_COLUMN,0,CUR_HEADINF)).toString().trim(); 
		headerDescrip 	= (String)detailDBBean.valueAtColumnRowResult(PHDESCRH_COLUMN,0,CUR_HEADINF).toString().trim(); 
		
		fDate 			= Format.displayDate(((Date)detailDBBean.valueAtColumnRowResult(PHFDATE_COLUMN,0,CUR_HEADINF)).toString());
		tDate 			= Format.displayDate(((Date)detailDBBean.valueAtColumnRowResult(PHTDATE_COLUMN,0,CUR_HEADINF)).toString());
	
		dDate	 		= (Date)detailDBBean.valueAtColumnRowResult(PHFDATE_COLUMN,0,CUR_HEADINF);
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
 %>
<FORM name = "myForm" method="post" action="<%=contextRoot%>/erp/payrollnic/confobjects/prcalens.jsp">
<INPUT type="hidden" name="action" id="action" value="DETAILAU">
<INPUT type="hidden" name="byEmployee" id="byEmployee" value="N"> 	
<INPUT type="hidden" name="proyId" id="proyId" value="<%=proyId%>">
<INPUT type="hidden" name="days" id="days" value="<%=days%>">
<INPUT type="hidden" name="employeeMastId" id="employeeMastId" value="<%=employeeMastId%>">
<INPUT type="hidden" name="employeeMastName" id="employeeMastName" value="<%=employeeMastName%>">
<INPUT type="hidden" name="emplMastSalQ" id="emplMastSalQ" value="<%=emplMastSalQ%>">


<TABLE cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="<%=days.equals("15")?"22":"23"%>">Detalle de Programacion</TD>
    </TR>
    <TR class="tableheader">
      <TD colspan="<%=days.equals("15")?"22":"23"%>"><%=employeeMastName%></TD>
    </TR>
    <TR class="tableheader">     
      <TD  colspan="<%=days.equals("15")?"22":"23"%>"><%=fDate + "-" + tDate + "(" + days + ")"%></TD>
    </TR>


   <%
   	 String day 	= fDate.substring(3,5);
   	 String dWeek	= "";

   	 int dayInt = Integer.parseInt(day);
	
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(dDate);
		cal.get(Calendar.DAY_OF_WEEK);   	 
   %> 
    <TR class="tableheader">
      <TD>Objetivo</TD>
      <TD>Dia <%=dayInt%></TD>
	<%
			dayInt = dayInt + 1;
		
	%>      
	      <TD>Dia <%=dayInt%></TD>
	<%
		dayInt = dayInt + 1;
	
	%>      
	      <TD>Dia <%=dayInt%></TD>
	<%
			dayInt = dayInt + 1;
	%>            
	      <TD>Dia <%=dayInt%></TD>
	<%
		dayInt = dayInt + 1;
	%>            
	      <TD>Dia <%=dayInt%></TD>
	<%
		dayInt = dayInt + 1;
		
	%>            
	      <TD>Dia <%=dayInt%></TD>
	<%
		dayInt = dayInt + 1;
		
	%>            
	      <TD>Dia <%=dayInt%></TD>
      <%
      	if(dayInt ==30 && days.equals("15"))
      		dayInt = 1;
      	else
      		dayInt = dayInt + 1;	 
      %>
      <TD>Dia <%=dayInt%></TD>
      <%
      	if(dayInt == 31)
      		dayInt = 1;
      	else
      		dayInt = dayInt + 1;
      		
      %>
      <TD>Dia <%=dayInt%></TD>
	<%
		dayInt = dayInt + 1;	
	%>            
	      <TD>Dia <%=dayInt%></TD>
	<%
		dayInt = dayInt + 1;	
	%>            
	      <TD>Dia <%=dayInt%></TD>
	<%
		dayInt = dayInt + 1;	
	%>                  
	      <TD>Dia <%=dayInt%></TD>
	<%
		dayInt = dayInt + 1;	
	%>                  
	      <TD>Dia <%=dayInt%></TD>
	<%
		dayInt = dayInt + 1;
	%>                  
	      <TD>Dia <%=dayInt%></TD>
	<%
		dayInt = dayInt + 1;	
	%>                  
	      <TD>Dia <%=dayInt%></TD>
	    <%  
	    	if(Integer.parseInt(days) > 15)
	    	{
	    		dayInt = dayInt + 1;    		
	    %>
	      <TD>Dia <%=dayInt%></TD>
	    <%
	    	} 
	    %>
	      <TD>HP</TD>
	      <TD>Ord.</TD>
	      <TD>Ext.</TD>    
	      <TD>Total</TD>
	      <TD>Ord. C$</TD>
	      <TD>Ext. C$</TD>                                           	   	  
	    </TR>
    
    <TR class="tableheader">
      <TD></TD>
<%
	if(cal.get(Calendar.DAY_OF_WEEK) == 1)
		dWeek = "D";
	else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
		dWeek = "L";
	else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
		dWeek = "M";
	else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
		dWeek = "M";
	else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
		dWeek = "J";
	else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
		dWeek = "V";
	else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
		dWeek = "S";
%>            
      <TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";
	
%>      
      <TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";

%>      
      <TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";
%>            
		<TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";
%>            
		<TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";
	
%>            
		<TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";
	
%>            
      <TD><%=dWeek%></TD>
      <%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";
      %>
      <TD><%=dWeek%></TD>
      <%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";      			 
      %>
      <TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";	
%>            
      <TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";	
%>            
      <TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";	
%>                  
      <TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";	
%>                  
      <TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";	
%>                  
      <TD><%=dWeek%></TD>
<%
		cal.add(Calendar.DATE, 1);
		cal.get(Calendar.DAY_OF_WEEK);   	 
	
		if(cal.get(Calendar.DAY_OF_WEEK) == 1)
			dWeek = "D";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
			dWeek = "L";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
			dWeek = "M";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
			dWeek = "J";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
			dWeek = "V";
		else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
			dWeek = "S";	
%>                  
      <TD><%=dWeek%></TD>
    <%  
    	if(Integer.parseInt(days) > 15)
    	{
			cal.add(Calendar.DATE, 1);
			cal.get(Calendar.DAY_OF_WEEK);   	 
	
			if(cal.get(Calendar.DAY_OF_WEEK) == 1)
				dWeek = "D";
			else if(cal.get(Calendar.DAY_OF_WEEK) == 2)
				dWeek = "L";
			else if(cal.get(Calendar.DAY_OF_WEEK) == 3)
				dWeek = "M";
			else if(cal.get(Calendar.DAY_OF_WEEK) == 4)
				dWeek = "M";
			else if(cal.get(Calendar.DAY_OF_WEEK) == 5)
				dWeek = "J";
			else if(cal.get(Calendar.DAY_OF_WEEK) == 6)
				dWeek = "V";
			else if(cal.get(Calendar.DAY_OF_WEEK) == 7)
				dWeek = "S";    		
    %>
      <TD><%=dWeek%></TD>
    <%
    	} 
    %>
      <TD></TD>
      <TD></TD>
      <TD></TD>    
      <TD></TD>
      <TD></TD>
      <TD></TD>                                           	   	  
    </TR>

	<%
	int i = 0;
	int numOfRows 		= 50;
	int numOfDetail		= detailDBBean.getRowsInResult(CUR_DEATINF);
	
	String employeeId   = employeeMastId;
	String employeeName = employeeMastName;
	String emplSalQ		= emplMastSalQ;
	String lineId		= "0";
	String objectId		= "0";
	
   	String day1			= "0";
   	String day2			= "0";
   	String day3			= "0";
	String day4			= "0";
   	String day5			= "0";
	String day6			= "0";
   	String day7			= "0";
   	String day8			= "0";
   	String day9			= "0";
   	String day10		= "0";
   	String day11		= "0";
   	String day12		= "0";
   	String day13		= "0";
   	String day14		= "0";
   	String day15		= "0";
   	String day16		= "0";
   	String dayHP		= "0";
   	String hrsORD		= "0";
   	String hrsEXT		= "0";
   	String amtORD		= "0";
   	String amtEXT		= "0";
   	String amtTotal		= "0";
   	String hrsTotal   	= "0";		
   	
int numOfRowsObj = detailDBBean.getRowsInResult(OBJECT_CUR);   	
	
 if (numOfRows==0) 
 {
%>
	<TR>
	 <TH colspan="23"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
   
   	if(returnWithError.equals("Y"))
   	{
   		lineId			= request.getParameter("lineId" + i)==null?"0":request.getParameter("lineId" + i);
   		employeeId 		= request.getParameter("employeeId" + i)==null?employeeMastId:request.getParameter("employeeId" + i);
   		emplSalQ		= request.getParameter("emplSalQ" + i)==null?emplMastSalQ:request.getParameter("emplSalQ" + i);
   		employeeName	= request.getParameter("employeeName" + i)==null?employeeMastName:request.getParameter("employeeName" + i);
   		
   		day1		= request.getParameter("day1Hrs" + i)==null?"0":request.getParameter("day1Hrs" + i);
   		day2		= request.getParameter("day2Hrs" + i)==null?"0":request.getParameter("day2Hrs" + i);
   		day3		= request.getParameter("day3Hrs" + i)==null?"0":request.getParameter("day3Hrs" + i);
   		day4		= request.getParameter("day4Hrs" + i)==null?"0":request.getParameter("day4Hrs" + i);
   		day5		= request.getParameter("day5Hrs" + i)==null?"0":request.getParameter("day5Hrs" + i);
   		day6		= request.getParameter("day6Hrs" + i)==null?"0":request.getParameter("day6Hrs" + i);
   		day7		= request.getParameter("day7Hrs" + i)==null?"0":request.getParameter("day7Hrs" + i);
   		day8		= request.getParameter("day8hrs" + i)==null?"0":request.getParameter("day8hrs" + i);
   		day9		= request.getParameter("day9hrs" + i)==null?"0":request.getParameter("day9hrs" + i);
   		day10		= request.getParameter("day10Hrs" + i)==null?"0":request.getParameter("day10Hrs" + i);
   		day11		= request.getParameter("day11Hrs" + i)==null?"0":request.getParameter("day11Hrs" + i);
   		day12		= request.getParameter("day12Hrs" + i)==null?"0":request.getParameter("day12Hrs" + i);
   		day13		= request.getParameter("day13Hrs" + i)==null?"0":request.getParameter("day13Hrs" + i);
   		day14		= request.getParameter("day14hrs" + i)==null?"0":request.getParameter("day14hrs" + i);
   		day15		= request.getParameter("day15Hrs" + i)==null?"0":request.getParameter("day15Hrs" + i);
   		
   		if(Integer.parseInt(days) > 15)
    	{
   			day16	= request.getParameter("day16Hrs" + i)==null?"0":request.getParameter("day16Hrs" + i);
   		}
   	}
   	else
   	{
 	 	if(i < numOfDetail)
 	 	{
 			lineId			= ((BigDecimal)detailDBBean.valueAtColumnRowResult(PHROWID_COLUMN,i,CUR_DEATINF)).toString();
 			objectId		= ((BigDecimal)detailDBBean.valueAtColumnRowResult(PHOBJID_COLUMN,i,CUR_DEATINF)).toString();
   			employeeId 		= ((BigDecimal)detailDBBean.valueAtColumnRowResult(PHEMPLID_COLUMN,i,CUR_DEATINF)).toString();
   			emplSalQ		= ((BigDecimal)detailDBBean.valueAtColumnRowResult(PHSALQ_COLUMN,i,CUR_DEATINF)).toString();
   			employeeName	= (String)detailDBBean.valueAtColumnRowResult(PHEMPLNM_COLUMN,i,CUR_DEATINF).toString();
   			day1			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY1_COLUMN,i,CUR_DEATINF));
   			day2			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY2_COLUMN,i,CUR_DEATINF));
   			day3			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY3_COLUMN,i,CUR_DEATINF));
   			day4			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY4_COLUMN,i,CUR_DEATINF));
   			day5			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY5_COLUMN,i,CUR_DEATINF));
   			day6			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY6_COLUMN,i,CUR_DEATINF));
   			day7			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY7_COLUMN,i,CUR_DEATINF));
   			day8			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY8_COLUMN,i,CUR_DEATINF));
   			day9			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY9_COLUMN,i,CUR_DEATINF));
   			day10			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY10_COLUMN,i,CUR_DEATINF));
   			day11			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY11_COLUMN,i,CUR_DEATINF));
   			day12			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY12_COLUMN,i,CUR_DEATINF));
   			day13			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY13_COLUMN,i,CUR_DEATINF));
   			day14			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY14_COLUMN,i,CUR_DEATINF));
   			day15			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY15_COLUMN,i,CUR_DEATINF));
   			day16			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAY16_COLUMN,i,CUR_DEATINF));
   			dayHP			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAYHP_COLUMN,i,CUR_DEATINF));
   			hrsORD			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHHRSORD_COLUMN,i,CUR_DEATINF));
   			hrsEXT			= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHHRSEXT_COLUMN,i,CUR_DEATINF));
   			amtORD			= Format.formatCurrency((BigDecimal)detailDBBean.valueAtColumnRowResult(PHAMTORD_COLUMN,i,CUR_DEATINF)).toString();
   			amtEXT			= Format.formatCurrency((BigDecimal)detailDBBean.valueAtColumnRowResult(PHAMTEXT_COLUMN,i,CUR_DEATINF)).toString();   			
   			hrsTotal		= Format.formatQty((BigDecimal)detailDBBean.valueAtColumnRowResult(PHDAYTOTAL_COLUMN,i,CUR_DEATINF)).toString();   			
   		}	
   		else
   		{
   			lineId			= "0";
			employeeId   	= employeeMastId;
			employeeName 	= employeeMastName;
			emplSalQ		= emplMastSalQ;
			objectId		= "0";
   			day1			= "0";
   			day2			= "0";
   			day3			= "0";
			day4			= "0";
   			day5			= "0";
			day6			= "0";
   			day7			= "0";
   			day8			= "0";
   			day9			= "0";
   			day10			= "0";
   			day11			= "0";
   			day12			= "0";
   			day13			= "0";
   			day14			= "0";
   			day15			= "0";
   			day16			= "0";
   			dayHP			= "0";
   			hrsORD			= "0";
   			hrsEXT			= "0";
   			amtORD			= "0";
   			amtEXT			= "0";   	
   			hrsTotal		= "0";		   			
   		}   	
   	}
%>
    <tr onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD>
        <INPUT type="hidden" name="lineId<%=i%>" value="<%=lineId%>">    
      	<INPUT type="hidden" name="updRec<%=i%>" value="Y">    
      	<INPUT type="hidden" name="emplSalQ<%=i%>" value="<%=emplSalQ%>">    
		<INPUT type="hidden" name="employeeId<%=i%>" id="employeeId<%=i%>" value="<%=employeeId%>">
 		<INPUT type="hidden" name="employeeName<%=i%>" id="employeeName<%=i%>" value="<%=employeeName%>">
        <SELECT size="1" name="objectId<%=i%>">
         <OPTION value="0">Seleccionar Objetivo</OPTION>
<%
String customerName    = "";
String preCustomerName = "";

   for (int j = 0; j < numOfRowsObj ; ) 
   { 
		try 
		{ 
			customerName = (String)(detailDBBean.valueAtColumnRowResult(CUSTNAME_COLUMN,j,OBJECT_CUR));
		 	if(!customerName.equals(preCustomerName) || j==0) 
      		{	
 %>
		<OPTION value="0" disabled="disabled"><%=customerName.trim()%></OPTION>       
<%
			}//END OF IF (!customerName.equals(preCustomerName) || i==0)
%>
		<OPTION value="<%=((BigDecimal)detailDBBean.valueAtColumnRowResult(COOBJID_COLUMN,j,OBJECT_CUR)).toString()%>" <%=objectId.equals(((BigDecimal)detailDBBean.valueAtColumnRowResult(COOBJID_COLUMN,j,OBJECT_CUR)).toString())?"selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=(String)(detailDBBean.valueAtColumnRowResult(COOBJCODE_COLUMN,j,OBJECT_CUR)) + "-" + ((String)(detailDBBean.valueAtColumnRowResult(COOBJNAME_COLUMN,j,OBJECT_CUR))).toString().trim()%></OPTION>
<%
		preCustomerName = customerName;
		j++; 
		}//END OF TRY
		catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
		
	}//END OF FOR
 %>         
        </SELECT>
	</TD> 
      <TD><input type="text" name="day1Hrs<%=i%>" id="day1Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day1%>"></TD>
      <TD><input type="text" name="day2Hrs<%=i%>" id="day2Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day2%>"></TD>
      <TD><input type="text" name="day3Hrs<%=i%>" id="day3Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day3%>"></TD>
      <TD><input type="text" name="day4Hrs<%=i%>" id="day4Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day4%>"></TD>
      <TD><input type="text" name="day5Hrs<%=i%>" id="day5Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day5%>"></TD>
      <TD><input type="text" name="day6Hrs<%=i%>" id="day6Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day6%>"></TD>
      <TD><input type="text" name="day7Hrs<%=i%>" id="day7Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day7%>"></TD>
      <TD><input type="text" name="day8Hrs<%=i%>" id="day8Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day8%>"></TD>
      <TD><input type="text" name="day9Hrs<%=i%>" id="day9Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day9%>"></TD>
      <TD><input type="text" name="day10Hrs<%=i%>" id="day10Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day10%>"></TD>
      <TD><input type="text" name="day11Hrs<%=i%>" id="day11Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day11%>"></TD>
      <TD><input type="text" name="day12Hrs<%=i%>" id="day12Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day12%>"></TD>
      <TD><input type="text" name="day13Hrs<%=i%>" id="day13Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day13%>"></TD>
      <TD><input type="text" name="day14Hrs<%=i%>" id="day14Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day14%>"></TD>
      <TD><input type="text" name="day15Hrs<%=i%>" id="day15Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day15%>"></TD>                
    <%  
    	if(Integer.parseInt(days) > 15)
    	{
    %>
		  <TD><input type="text" name="day16Hrs<%=i%>" id="day16Hrs<%=i%>" size="2" onBlur="cal_days(<%=i%>,'N');" maxlength="4" value="<%=day16%>"></TD>
    <%
    	} 
    %>
      <TD><input readonly type="text" name="hp<%=i%>" size="2" maxlength="4" value="<%=dayHP%>"></TD>                
      <TD><input readonly type="text" name="ord<%=i%>" size="2" maxlength="4" value="<%=hrsORD%>"></TD>                
      <TD><input readonly type="text" name="ext<%=i%>" size="2" maxlength="4" value="<%=hrsEXT%>"></TD>                
      <TD><input readonly type="text" name="total<%=i%>" size="2" maxlength="4" value="<%=hrsTotal%>"></TD>
      <TD><input readonly type="text" name="ordAMT<%=i%>" size="6" maxlength="21" value="<%=amtORD%>"></TD>
	  <TD><input readonly type="text" name="extAMT<%=i%>" size="6" maxlength="21" value="<%=amtEXT%>"></TD>      
    </TR>
<%
		i++; 
 	}//END OF FOR  
}//END OF ELSE
detailDBBean.closeResultSet();
%>
<TR>
      <TD class="label" align="right"> TOTAL:</TD> 
      <TD><input readonly type="text" name="day1Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day2Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day3Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day4Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day5Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day6Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day7Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day8Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day9Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day10Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day11Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day12Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day13Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day14Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day15Total" size="2" maxlength="4" value="0"></TD>                
    <%  
    	if(Integer.parseInt(days) > 15)
    	{
    %>
		  <TD><input readonly type="text" name="day16Total" size="2"  maxlength="4" value="0"></TD>
    <%
    	} 
    %>
      <TD><input readonly type="text" name="hpTotal" size="2" maxlength="4" value="0"></TD>                
      <TD><input readonly type="text" name="ordTotal" size="2" maxlength="4" value="0"></TD>                
      <TD><input readonly type="text" name="extTotal" size="2" maxlength="4" value="0"></TD>                
      <TD><input readonly type="text" name="totalGRAND" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="ordAMTTotal" size="6" maxlength="21" value="0"></TD>
	  <TD><input readonly type="text" name="extAMTTotal" size="6" maxlength="21" value="0"></TD>      
</TR>
</TABLE>
<TABLE border="0" cellspacing="0" cellpadding="0">
    <TR>
    <TD width="30%" height="30">
		  <INPUT type="hidden" name="rows" value="<%=i%>">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00008")%>" class="button">
	</TD>
    <TD align="center" width="35%" height="30">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="button" name="cancel" value="Cerrar Ventana" class="button" onclick="top.close();">
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>