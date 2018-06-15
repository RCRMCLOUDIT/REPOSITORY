<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Experiencia Laboral</TITLE>
</HEAD> 
 <BODY onload="javascript: document.myForm.centerName0.focus()">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Experiencia Laboral";

 static final int INFDTA_CUR 	= 1;
 static final int COUNTRY_CUR	= 2;
 static final int CURRENCY_CUR	= 3;
    
 static final int LEEXPRID_COLUMN	= 1; //EXPERIENCE ID
 static final int LECENTNM_COLUMN	= 2; //EXPERIENCE CENTER NAME
 static final int LECOUNTRY_COLUMN	= 3; //EXPERIENCE COUNTRY ID
 static final int LEFDATE_COLUMN	= 4; //EXPERIENCE FROM DATE
 static final int LETDATE_COLUMN	= 5; //EXPERIENCE TO DATE
 static final int LEJOBPR_COLUMN	= 6; //EXPERIENCE JOB PROFILE
 static final int LEJOBSL_COLUMN	= 7; //EXPERIENCE JOB SALARY
 static final int LECURRID_COLUMN	= 8; //EXPERIENCE CURRENCY ID                                        
 static final int LEREAZON_COLUMN	= 9; //EXPERIENCE REAZON
 static final int LEAREAS_COLUMN	= 10; //EXPERIENCE AREAS
 static final int CURRENCY_COLUMN	= 11; //EXPERIENCE CURRENCY
 static final int COUNTRY_COLUMN	= 12; //EXPERIENCE COUNTRY
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/searchemployees.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
 String employeeId 		= request.getParameter("employeeId")==null?"":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 
 String action	  		= request.getParameter("action")==null?"EMPLEXNEW":request.getParameter("action");
  
 int linesNumber = request.getParameter("linesNumber")==null?10:((new Integer(request.getParameter("linesNumber"))).intValue());
 
 String experienceId	= request.getParameter("experienceId")==null?"0":request.getParameter("experienceId");
 
 if(!experienceId.equals("0"))
  action = "EMPLEXEDT";

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
 					companyID + "'," + companyEID + "," + employeeId + ",'','','','',0,0,0,0,'',0,'','',0,0,'',0,0,0,'','','','','',0,0,'','','" + action + "','','','','','','','',0,'',0,?,?)}";
  					
 System.out.println("sqlString = " + sqlString); 				
 
 String callF = request.getParameter("callF")==null?"":request.getParameter("callF");	
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
 String link = null;

 String baseLink = contextRoot + "/erp/payrollnic/mainpayroll/";
	
String lineId		= "";

String centerName	= "";
String countryId	= "";
String currencyId	= "";
String jobProfile	= "";
String jobSalary	= "";
String fDate		= "";
String tDate		= "";
String reazon		= "";
String areas		= "";
 					
 listDBBean.execute(); 
	 
int detRows = 0;

if(action.equals("EMPLEXEDT"))
	detRows = listDBBean.getRowsInResult(INFDTA_CUR);	

if(detRows > 0 && !action.equals("ALINESLEX"))
	linesNumber = detRows; 
%>
<FORM name = "myForm" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/premplsets.jsp">
<INPUT type="hidden" name="callF" value="<%=callF%>">	
	<TABLE width="600" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="9">Experiencia Laboral</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label">Nombre de Empleado</TD>
      <TD colspan="8"><%=employeeName%></TD>
	</TR>       
    <TR class="tableheader">
      <TD>Empresa donde Trabajo</TD>
      <TD>Pais</TD>
      <TD>Desde</TD>
      <TD>Hasta</TD>
	  <TD>Cargo Desempeñado</TD>
	  <TD>Sueldo</TD>
	  <TD>Moneda</TD>
	  <TD>Causa de Retiro</TD>
	  <TD>Areas Desarrolladas</TD>	              
    </TR>

<%
	String code  = "";
	String descr = "";

	String updRec = "";
	for(int j=0;j<linesNumber;j++)
  	{ 
	try 
	{ 
		centerName		= request.getParameter("centerName"+j)==null?"":request.getParameter("centerName"+j);
		countryId		= request.getParameter("countryId"+j)==null?"":request.getParameter("countryId"+j);	
		fDate			= request.getParameter("fDate"+j)==null?"":request.getParameter("fDate"+j);			
		tDate			= request.getParameter("tDate"+j)==null?"":request.getParameter("tDate"+j);
		currencyId		= request.getParameter("currencyId"+j)==null?"":request.getParameter("currencyId"+j); 
		jobProfile		= request.getParameter("jobProfile"+j)==null?"":request.getParameter("jobProfile"+j);
		jobSalary		= request.getParameter("jobSalary"+j)==null?"":request.getParameter("jobSalary"+j);  		
		lineId			= request.getParameter("lineId"+j)==null?String.valueOf(j):request.getParameter("lineId"+j);
		updRec			= request.getParameter("updRec"+j)==null?"N":request.getParameter("updRec"+j);
		reazon			= request.getParameter("reazon"+j)==null?"":request.getParameter("reazon"+j);  		
		areas			= request.getParameter("areas"+j)==null?"":request.getParameter("areas"+j);  		

 		if(action.equals("EMPLEXEDT"))
		{
			centerName		= (String)listDBBean.valueAtColumnRowResult(LECENTNM_COLUMN,j,INFDTA_CUR).toString().trim();
			countryId		= ((String)listDBBean.valueAtColumnRowResult(LECOUNTRY_COLUMN,j,INFDTA_CUR)).toString().trim();
			fDate			= ((Date)listDBBean.valueAtColumnRowResult(LEFDATE_COLUMN,j,INFDTA_CUR)).toString().trim();
			tDate			= ((Date)listDBBean.valueAtColumnRowResult(LETDATE_COLUMN,j,INFDTA_CUR)).toString().trim();						
			lineId			= ((BigDecimal)listDBBean.valueAtColumnRowResult(LEEXPRID_COLUMN,j,INFDTA_CUR)).toString().trim();	
			jobProfile		= ((String)listDBBean.valueAtColumnRowResult(LEJOBPR_COLUMN,j,INFDTA_CUR)).toString().trim();
			jobSalary		= Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LEJOBSL_COLUMN,j,INFDTA_CUR));
			currencyId		= ((String)listDBBean.valueAtColumnRowResult(LECURRID_COLUMN,j,INFDTA_CUR)).toString().trim();
			reazon			= ((String)listDBBean.valueAtColumnRowResult(LEREAZON_COLUMN,j,INFDTA_CUR)).toString().trim();
			areas			= ((String)listDBBean.valueAtColumnRowResult(LEAREAS_COLUMN,j,INFDTA_CUR)).toString().trim();
			
			updRec			= "Y";					
		}	
%>
    <TR class="<%=j%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap align="left">
        <INPUT type="hidden" name="updRec<%=j%>" value="<%=updRec%>"> 
    	<INPUT type="hidden" name="lineId<%=j%>" value="<%=lineId%>">
 		<INPUT type="text" class="text"	size="50" maxlength="40" name="centerName<%=j%>" id="centerName<%=j%>" value="<%=centerName%>">
	  </TD>
	  <TD> 	
	            <SELECT size="1" name="countryId<%=j%>" class="text">
	            <OPTION value="" <%=countryId.length()==0?"selected": ""%>></OPTION>
<%
		int countries = listDBBean.getRowsInResult(COUNTRY_CUR);

   		for (int k = 0; k < countries; k++) { 
 			code 	= ((String)listDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,k,COUNTRY_CUR)).toString().trim();
			descr	= (String)listDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,k,COUNTRY_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=countryId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
      </TD>
      <TD nowrap align=center>
       <INPUT size="12" maxlength="10" type="text" name="fDate<%=j%>" class="pcrInfo" value="<%=Format.displayDate(fDate)%>" onKeyUp="addSlash(myForm.fDate<%=j%>)" onChange="formatDate(myForm.fDate<%=j%>)" onKeyPress="OnlyDigits();addSlash(myForm.fDate<%=j%>)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.fDate<%=j%>, 'mm/dd/yyyy', 350, -1);" alt="Calendar">        
      </TD>
      <TD nowrap align=center>
       <INPUT size="12" maxlength="10" type="text" name="tDate<%=j%>" class="pcrInfo" value="<%=Format.displayDate(tDate)%>" onKeyUp="addSlash(myForm.tDate<%=j%>)" onChange="formatDate(myForm.tDate<%=j%>)" onKeyPress="OnlyDigits();addSlash(myForm.tDate<%=j%>)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.tDate<%=j%>, 'mm/dd/yyyy', 350, -1);" alt="Calendar">        
      </TD>
	  <TD nowrap align="center">
		<INPUT type="text" class="text"	size="50" maxlength="40" name="jobProfile<%=j%>" id="jobProfile<%=j%>" value="<%=jobProfile%>">
	  </TD>
	  <TD nowrap align="center">
		<INPUT type="text" class="text"	size="20" maxlength="21" name="jobSalary<%=j%>" id="jobSalary<%=j%>" value="<%=jobSalary%>">
	  </TD>            		      	              		      
	  <TD> 	
	            <SELECT size="1" name="currencyId<%=j%>" class="text">
	            <OPTION value="" <%=currencyId.length()==0?"selected": ""%>></OPTION>
<%
		int currencies = listDBBean.getRowsInResult(CURRENCY_CUR);
		
   		for (int k = 0; k < currencies; k++) { 
 			code 	= ((String)listDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,k,CURRENCY_CUR)).toString().trim();
			descr	= (String)listDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,k,CURRENCY_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=currencyId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
      </TD>
      <TD nowrap align="center">
      	<TEXTAREA class="text" rows="2" cols="20" name="reazon<%=j%>" id="reazon<%=j%>"><%=reazon%></textarea>
	  </TD>
      <TD nowrap align="center">
	      <TEXTAREA class="text" rows="2" cols="20" name="areas<%=j%>" id="areas<%=j%>"><%=areas%></textarea>
	  </TD>            
	              
    </TR>  
<%
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
listDBBean.closeResultSet();
%>
    <TR>
		<TD colspan="5">
			<TABLE width="100%" border="0" cellpadding="0" cellspacing="1" height="30">
				<TR>
					<TD><INPUT type="button" name="addLines" value="<%=rb.getString("B00034")%>" class="button" onclick="document.myForm.action.value='ALINESLEX';document.myForm.linesNumber.value='<%=linesNumber+4%>';document.myForm.submit();"></TD>
					<TD align="right" class="label"></TD>
                </TR>
            </TABLE>
		</TD>
	</TR>  
</TABLE>
<TABLE border="0" width="600" cellspacing="0" cellpadding="0">
    <TR>
    <TD width="30%" height="30">
		  <INPUT type="hidden" name="linesNumber" id="linesNumber" value="<%=linesNumber%>">
		  <INPUT type="hidden" name="action" value="EMPLEXADD">
		  <INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
		  <INPUT type="hidden" name="employeeName" id="employeeName" value="<%=employeeName%>">		  		  
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00008")%>" class="button">
	</TD>
    <TD align="center" width="35%" height="30"> 
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">  
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="button" name="addnew" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/employee/employeeexperiencelist.jsp?contextRoot=<%=request.getContextPath()%>&employeeId=<%=employeeId%>&employeeName=<%=employeeName%>';">
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