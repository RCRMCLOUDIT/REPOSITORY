<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Datos Familiares</TITLE>
</HEAD> 
 <BODY onload="javascript: document.myForm.famName0.focus()">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Datos Familiares";

 static final int INFDTA = 1;
    
 static final int EFFAMID_COLUMN 		= 1; 
 static final int EFNAME_COLUMN 		= 2; 
 static final int EFTYPE_COLUMN 		= 3; 
 static final int EFSEX_COLUMN 			= 4; 
 static final int EFBRTHDAY_COLUMN 		= 5;                                                                  
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
 
 String action	  		= request.getParameter("action")==null?"EMPFAMNEW":request.getParameter("action");
  
 int linesNumber = request.getParameter("linesNumber")==null?10:((new Integer(request.getParameter("linesNumber"))).intValue());
 
 String famId	= request.getParameter("famId")==null?"0":request.getParameter("famId");
 
 if(!famId.equals("0"))
  action = "EMPFAMEDT";

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
 					companyID + "',0," + employeeId + ",'','','','',0,0,0,0,'',0,'','',0,0,'',0,0,0,'','','','','',0,0,'','','" + action + "','','','','','','','',0,'',0,?,?)}";

 					
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
 String link = null;

 String baseLink = contextRoot + "/erp/payrollnic/mainpayroll/";
	
String lineId		= "";

String famName		= "";
String famType		= "";
String famSex		= "";
String famBrthDate	= "";
 					
 listDBBean.execute(); 
	 
int detRows = 0;

if(action.equals("EMPFAMEDT"))
	detRows = listDBBean.getRowsInResult(INFDTA);	

if(detRows > 0 && !action.equals("ALINES"))
	linesNumber = detRows; 
	
String callF = request.getParameter("callF")==null?"":request.getParameter("callF");	
%>
<FORM name = "myForm" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/premplsets.jsp">
<INPUT type="hidden" name="callF" value="<%=callF%>">
<TABLE width="600" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="4">Datos Familiarares</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label">Nombre de Empleado</TD>
      <TD colspan="3"><%=employeeName%></TD>
	</TR>       
    <TR class="tableheader">
      <TD>Nombre de Familiar</TD>
      <TD>Parentesco</TD>      
      <TD>Sexo</TD> 
      <TD>Fecha de Nacimiento</TD>          
    </TR>
<%
	String updRec = "";
	for(int j=0;j<linesNumber;j++)
  	{ 
	try 
	{ 
		famName			= request.getParameter("famName"+j)==null?"":request.getParameter("famName"+j);
		famType			= request.getParameter("famType"+j)==null?"":request.getParameter("famType"+j);	
		famSex			= request.getParameter("famSex"+j)==null?"":request.getParameter("famSex"+j);	
		famBrthDate		= request.getParameter("famBrthDate"+j)==null?"":request.getParameter("famBrthDate"+j);			
		lineId			= request.getParameter("lineId"+j)==null?String.valueOf(j):request.getParameter("lineId"+j);
		updRec			= request.getParameter("updRec"+j)==null?String.valueOf(j):request.getParameter("updRec"+j);
		
		if(action.equals("EMPFAMEDT"))
		{
			famName			= (String)listDBBean.valueAtColumnRowResult(EFNAME_COLUMN,j,INFDTA).toString().trim();
			famType			= ((String)listDBBean.valueAtColumnRowResult(EFTYPE_COLUMN,j,INFDTA)).toString().trim();		
			famSex			= ((String)listDBBean.valueAtColumnRowResult(EFSEX_COLUMN,j,INFDTA)).toString().trim();
			famBrthDate		= ((Date)listDBBean.valueAtColumnRowResult(EFBRTHDAY_COLUMN,j,INFDTA)).toString().trim();						
			lineId			= ((BigDecimal)listDBBean.valueAtColumnRowResult(EFFAMID_COLUMN,j,INFDTA)).toString().trim();	
			updRec			= "Y";					
		}	
%>
    <TR class="<%=j%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap align="left">
        <INPUT type="hidden" name="updRec<%=j%>" value="<%=updRec%>"> 
    	<INPUT type="hidden" name="lineId<%=j%>" value="<%=lineId%>">
 		<INPUT type="text" class="text"	size="50" maxlength="40" name="famName<%=j%>" id="famName<%=j%>" value="<%=famName%>">
      </TD>    
      <TD nowrap align="center">
      	<select size="1" name="famType<%=j%>">
      	    <option value=""   <%=famType.equals("")?"selected":""%>></option>
      	    <option value="ES" <%=famType.equals("ES")?"selected":""%>>Espos@</option>
      		<option value="MA" <%=famType.equals("MA")?"selected":""%>>Madre</option>
			<option value="PA" <%=famType.equals("PA")?"selected":""%>>Padre</option>
			<option value="HO" <%=famType.equals("HO")?"selected":""%>>Hijo</option>
			<option value="HA" <%=famType.equals("HA")?"selected":""%>>Hija</option>
		</select>
	  </TD>
	  <TD> 	
	    <select size="1" name="famSex<%=j%>">
      	    <option value=""  <%=famSex.equals("")?"selected":""%>></option>
      		<option value="M" <%=famSex.equals("M")?"selected":""%>>M</option>
			<option value="F" <%=famSex.equals("F")?"selected":""%>>F</option>
		</select>
      </TD>
      <TD nowrap align=center>
       <INPUT size="12" maxlength="10" type="text" name="famBrthDate<%=j%>" class="pcrInfo" value="<%=famBrthDate%>" onKeyUp="addSlash(myForm.famBrthDate<%=j%>)" onChange="formatDate(myForm.famBrthDate<%=j%>)" onKeyPress="OnlyDigits();addSlash(myForm.famBrthDate<%=j%>)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.famBrthDate<%=j%>, 'mm/dd/yyyy', 350, -1);" alt="Calendar">        
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
					<TD><INPUT type="button" name="addLines" value="<%=rb.getString("B00034")%>" class="button" onclick="document.myForm.action.value='ALINES';document.myForm.linesNumber.value='<%=linesNumber+4%>';document.myForm.submit();"></TD>
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
		  <INPUT type="hidden" name="action" value="EMPFAMADD">
		  <INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
		  <INPUT type="hidden" name="employeeName" id="employeeName" value="<%=employeeName%>">		  		  
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00008")%>" class="button">
	</TD>
    <TD align="center" width="35%" height="30"> 
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">  
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="button" name="addnew" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/employee/employeefamlist.jsp?contextRoot=<%=request.getContextPath()%>&employeeId=<%=employeeId%>&employeeName=<%=employeeName%>';">
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