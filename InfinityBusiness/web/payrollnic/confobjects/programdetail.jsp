<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<link rel="stylesheet" href="css/style.css" type="text/css">
<TITLE>Detalle de Programacion</TITLE>
</HEAD> 
<BODY onload="cal_total_days();">
<%! 
 static final String title = "Detalle de Programacion";
 
 static final int CUR_HEADINF = 1;
 static final int CUR_DEATINF = 2;
 
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

<!--script to disable the submit button -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">  
</script>
<script type="text/javascript">

$(document).ready(function () {
    $(".submitBtn").click(function () {
        $(".submitBtn").attr("disabled", true);
        return true;
    });
});

</script>
<!--script ends here-->

<SCRIPT type="text/javascript" src="js/jquery-1.3.2.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="js/scrolltable.js"></SCRIPT>
<SCRIPT type="text/javascript">
	    $(document).ready(function() {
			/* zebra stripe the tables (not necessary for scrolling) */
	        var tbl = $("table.tbl1");
	        addZebraStripe(tbl);
	        addMouseOver(tbl);
			
			/* make the table scrollable with a fixed header */
	        $("table.scroll").createScrollableTable({
	            width: '1200px',
	            height: '500px'
	        });

	    });

	    function addZebraStripe(table) {
            table.find("tbody tr:odd").addClass("alt");
        }

        function addMouseOver(table) {
            table.find("tbody tr").hover(
                    function() {
                        $(this).addClass("over");
                    },
                    function() {
                        $(this).removeClass("over");
                    }
                );
        }
</SCRIPT>

<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
 String custEid 	= request.getParameter("custEid")==null?"0":request.getParameter("custEid");
 String objectId 	= request.getParameter("objectId")==null?"0":request.getParameter("objectId");
 String proyId 		= request.getParameter("proyId")==null?"0":request.getParameter("proyId");
 
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
 					companyID + "',0," + custEid + "," + objectId + "," + proyId + ",'','','','',0,0,0,'','','','DETAIL',?,?)}"; 

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
<INPUT type="hidden" name="returnEid" id="returnEid" value="Y"> 
<INPUT type="hidden" name="byEmployee" id="byEmployee" value="Y"> 
<INPUT type="hidden" name="custEid" id="custEid" value="<%=custEid%>">	
<INPUT type="hidden" name="objectId" id="objectId" value="<%=objectId%>">	
<INPUT type="hidden" name="proyId" id="proyId" value="<%=proyId%>">
<INPUT type="hidden" name="days" id="days" value="<%=days%>">
<INPUT type="hidden" name="custName" id="custName" value="<%=request.getParameter("custName")==null?"":request.getParameter("custName")%>">
<INPUT type="hidden" name="objName" id="objName" value="<%=request.getParameter("objName")==null?"":request.getParameter("objName")%>">

<DIV style="width: 1200px;vertical-align: baseline;">
<TABLE width="1200px">
    <TR class="tableheader">
    	<TD colspan="<%=days.equals("15")?"22":"23"%>">Detalle de Programacion</TD>
    </TR>
    <TR class="tableheader">
      <TD colspan="<%=days.equals("15")?"22":"23"%>"><%=request.getParameter("custName")==null?"":request.getParameter("custName")%></TD>
    </TR>
    <TR class="tableheader">     
      <TD colspan="<%=days.equals("15")?"22":"23"%>"><%=request.getParameter("objName")==null?"":request.getParameter("objName")%></TD>
    </TR>
    <TR class="tableheader">     
      <TD colspan="<%=days.equals("15")?"22":"23"%>"><%=fDate + "-" + tDate + "(" + days + ")"%></TD>
    </TR>
</TABLE>   
</DIV>
<TABLE class="tbl1 scroll">
 <THEAD>
    <TR class="tableheader">
      <%
   	 String day 	= fDate.substring(3,5);
   	 String month   = fDate.substring(0,2);
   	 String dWeek	= "";
   	 int j = 1;
   	 int dayInt = Integer.parseInt(day);
	
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(dDate);
		cal.get(Calendar.DAY_OF_WEEK);   	 
   %> 
    
      <TH>Empleado</TH>
      <TH>Dia <%=dayInt%></TH>
	<%
			dayInt = dayInt + 1;
		
	%>      
	      <TH>Dia <%=dayInt%></TH>
	<%
		dayInt = dayInt + 1;
	
	%>      
	      <TH>Dia <%=dayInt%></TH>
	<%
			dayInt = dayInt + 1;
	%>            
	      <TH>Dia <%=dayInt%></TH>
	<%
		dayInt = dayInt + 1;
	%>            
	      <TH>Dia <%=dayInt%></TH>
	<%
	   if(month.equals("02"))
	   {
	   		dayInt = 0 ;
	   }
		dayInt = dayInt + 1;		
	%>            
	      <TH>Dia <%=dayInt%></TH>
	<%
		dayInt = dayInt + 1;
		
	%>            
	      <TH>Dia <%=dayInt%></TH>
      <%
      	if(dayInt ==30 && days.equals("15"))
      		dayInt = 1;
      	else
      		dayInt = dayInt + 1;	 
      %>
      <TH>Dia <%=dayInt%></TH>
      <%
      	if(dayInt == 31)
      		dayInt = 1;
      	else
      		dayInt = dayInt + 1;
      		
      %>
      <TH>Dia <%=dayInt%></TH>
	<%
		dayInt = dayInt + 1;	
	%>            
	      <TH>Dia <%=dayInt%></TH>
	<%
		dayInt = dayInt + 1;	
	%>            
	      <TH>Dia <%=dayInt%></TH>
	<%
		dayInt = dayInt + 1;	
	%>                  
	      <TH>Dia <%=dayInt%></TH>
	<%
		dayInt = dayInt + 1;	
	%>                  
	      <TH>Dia <%=dayInt%></TH>
	<%	
		if(!month.equals("02"))
		{
				dayInt = dayInt + 1;
	%>                  
	      <TH>Dia <%=dayInt%></TH>
	<%
		dayInt = dayInt + 1;	
	%>                  
	      <TH>Dia <%=dayInt%></TH>
	<%  
	    	if(Integer.parseInt(days) > 15)
	    	{
	    		dayInt = dayInt + 1;    		
	   %>
	      <TH>Dia <%=dayInt%></TH>
	   <%
	    	}
	  }// END OF MONTH EQUALS 2
	  else
	  { 	 
		%>                  
	      <TH></TH> 
	      <TH></TH>
	      <TH></TH>
	   	<%    	
	   }//END OF ELSE
	   	%> 
	      <TH>HP</TH>
	      <TH>Ord.</TH>
	      <TH>Ext.</TH>    
	      <TH>Total</TH>
	      <TH>Ord. C$</TH>
	      <TH>Ext. C$</TH>                                           	   	  
	  </TR>
      <TR class="tableheader">
      <TH></TH>
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
      <TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
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
		<TH><%=dWeek%></TH>
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
		<TH><%=dWeek%></TH>
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
		<TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
<%
if(!month.equals("02"))
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
      <TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
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
      <TH><%=dWeek%></TH>
    <%
    	} 
  }//END OF IF
  else
  {  	
    %>
      <TH></TH>
      <TH></TH>
      <TH></TH>    

    <% 
   }//END OF ELSE
    %>
      <TH></TH>
      <TH></TH>
      <TH></TH>    
      <TH></TH>
      <TH></TH>
      <TH></TH>    
    </TR>
 </THEAD>
 <TBODY>   
	<%
	int i = 0;
	int numOfRows 		= 50;
	int numOfDetail		= detailDBBean.getRowsInResult(CUR_DEATINF);
	
	String employeeId   = "0";
	String employeeName = "";
	String emplSalQ		= "0.00";
	String lineId		= "0";
	
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
   		employeeId 		= request.getParameter("employeeId" + i)==null?"0":request.getParameter("employeeId" + i);
   		emplSalQ		= request.getParameter("emplSalQ" + i)==null?"0.00":request.getParameter("emplSalQ" + i);
   		employeeName	= request.getParameter("employeeName" + i)==null?"":request.getParameter("employeeName" + i);;
   	}
   	else
   	{
 /*static final int PHCUSTEID_COLUMN 	= 2;
 static final int PHOBJID_COLUMN 	= 3;

 static final int PHDAYTOTAL_COLUMN = 28;
 static final int PHAMTTOTAL_COLUMN = 29;*/
 	 	if(i < numOfDetail)
 	 	{
 			lineId			= ((BigDecimal)detailDBBean.valueAtColumnRowResult(PHROWID_COLUMN,i,CUR_DEATINF)).toString();
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
   			employeeId 		= "0";
   			emplSalQ		= "0.00";
   			employeeName	= "";
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
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD>
        <INPUT type="hidden" name="lineId<%=i%>" value="<%=lineId%>">    
      	<INPUT type="hidden" name="updRec<%=i%>" value="Y">    
      	<INPUT type="hidden" name="emplSalQ<%=i%>" value="<%=emplSalQ%>">    
		<INPUT type="hidden" name="employeeId<%=i%>" id="employeeId<%=i%>" value="<%=employeeId%>">
 		<INPUT size="30" name="employeeName<%=i%>" type="text" class="text"	maxlength="50" value="<%=employeeName%>" id="employeeName<%=i%>"  onchange="this.form.employeeId<%=i%>.value='';" onkeypress='if(isEnterPressed()) openSEmployeesDialog("myForm", "employeeId<%=i%>", "employeeName<%=i%>", "", "<%= request.getContextPath()%>","emplSalQ<%=i%>");' autocomplete="off" class="search search-icon">
		<INPUT type="button" class="button" name="searchEmp<%=i%>" value=" v " onclick='openSEmployeesDialog("myForm", "employeeId<%=i%>", "employeeName<%=i%>", "" , "<%= request.getContextPath()%>","emplSalQ<%=i%>");'>            
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
      <TD><input readonly type="text" name="day1Total" id = "day1Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day2Total" id = "day2Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day3Total" id = "day3Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day4Total" id = "day4Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day5Total" id = "day5Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day6Total" id = "day61Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day7Total" id = "day7Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day8Total" id = "day8Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day9Total" id = "day9Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day10Total" id = "day10Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day11Total" id = "day11Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day12Total" id = "day12Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day13Total" id = "day13Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day14Total" id = "day14Total" size="2" maxlength="4" value="0"></TD>
      <TD><input readonly type="text" name="day15Total" id = "day15Total" size="2" maxlength="4" value="0"></TD>                
    <%  
    	if(Integer.parseInt(days) > 15)
    	{
    %>
		  <TD><input readonly type="text" name="day16Total" id = "day16Total" size="2"  maxlength="4" value="0"></TD>
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
</TBODY>
</TABLE>
<TABLE border="0" cellspacing="0" cellpadding="0">
    <TR>
    <TD width="30%" height="30">
		  <INPUT type="hidden" name="rows" value="<%=i%>">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" class="button submitBtn" name="addnew" value="<%=rb.getString("B00008")%>">
	</TD>
    <TD width="30%" height="30">
		  <INPUT type="hidden" name="rows" value="<%=i%>">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="button" name="print" value="Imprimir" class="button" onclick="window.open('<%=contextRoot%>/servlet/com.cap.erp.report.PayRollInfoPDF?action=PRTPRG&objectId=<%=objectId%>&proyId=<%=proyId%>');">
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