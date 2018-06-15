<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Formacion Academica</TITLE>
</HEAD> 
 <BODY onload="javascript: document.myForm.centerName0.focus()">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Formacion Academica";

 static final int INFDTA_CUR 	= 1;
 static final int COUNTRY_CUR	= 2;
    
 static final int AFFORMID_COLUMN	= 1; //ACADEMY FORM ID
 static final int AFALEVID_COLUMN	= 2; //ACADEMY LEVEL ID
 static final int AFCENTNM_COLUMN	= 3; //ACADEMY CENTER NAME
 static final int AFCOUNTRY_COLUMN	= 4; //ACADEMY COUNTRY ID  
 static final int AFFDATE_COLUMN	= 5; //ACADEMY FROM DATE
 static final int AFTDATE_COLUMN	= 6; //ACADEMY TO DATE
 static final int AFTITLE_COLUMN	= 7; //ACADEMY TITLE ACHIEVE                                       
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
 
 String action	  		= request.getParameter("action")==null?"EMPACDNEW":request.getParameter("action");
  
 int linesNumber = request.getParameter("linesNumber")==null?10:((new Integer(request.getParameter("linesNumber"))).intValue());
 
 String formId	= request.getParameter("formId")==null?"0":request.getParameter("formId");
 
 if(!formId.equals("0"))
  action = "EMPACDEDT";

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
 					companyID + "',0," + employeeId + ",'','','','',0,0,0,0,'',0,'','',0,0,'',0,0,0,'','','','','',0,0,'','','" + action + "','','','','','','','',0,'',0,?,?)}";
  					
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

String levelId		= "";
String centerName	= "";
String countryId	= "";
String fDate		= "";
String tDate		= "";
String title		= "";
 					
 listDBBean.execute(); 
	 
int detRows = 0;

if(action.equals("EMPACDEDT"))
	detRows = listDBBean.getRowsInResult(INFDTA_CUR);	

if(detRows > 0 && !action.equals("ALINESACD"))
	linesNumber = detRows; 
%>
<FORM name = "myForm" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/premplsets.jsp">
<TABLE width="600" cellpadding="0" cellspacing="1" class="Border" border="0">
<INPUT type="hidden" name="callF" value="<%=callF%>">
    <TR class="tableheader">
    	<TD colspan="6">Formacion Academica</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label">Nombre de Empleado</TD>
      <TD colspan="5"><%=employeeName%></TD>
	</TR>       
    <TR class="tableheader">
      <TD>Nivel Academico</TD>
      <TD>Nombre del Centro Estudio</TD>      
      <TD>Pais</TD> 
      <TD>Año Inicio</TD>
	  <TD>Año Final</TD>                
	  <TD>Carrera</TD>	  
    </TR>
<%
	String updRec = "";
	for(int j=0;j<linesNumber;j++)
  	{ 
	try 
	{ 
		levelId			= request.getParameter("levelId"+j)==null?"":request.getParameter("levelId"+j);
		centerName		= request.getParameter("centerName"+j)==null?"":request.getParameter("centerName"+j);
		countryId		= request.getParameter("countryId"+j)==null?"":request.getParameter("countryId"+j);	
		fDate			= request.getParameter("fDate"+j)==null?"":request.getParameter("fDate"+j);			
		tDate			= request.getParameter("tDate"+j)==null?"":request.getParameter("tDate"+j);
		title			= request.getParameter("title"+j)==null?"":request.getParameter("title"+j);	
		lineId			= request.getParameter("lineId"+j)==null?String.valueOf(j):request.getParameter("lineId"+j);
		updRec			= request.getParameter("updRec"+j)==null?"N":request.getParameter("updRec"+j);
		
		if(action.equals("EMPACDEDT"))
		{
 			levelId			= ((BigDecimal)listDBBean.valueAtColumnRowResult(AFALEVID_COLUMN,j,INFDTA_CUR)).toString().trim();		
			centerName		= (String)listDBBean.valueAtColumnRowResult(AFCENTNM_COLUMN,j,INFDTA_CUR).toString().trim();
			countryId		= ((String)listDBBean.valueAtColumnRowResult(AFCOUNTRY_COLUMN,j,INFDTA_CUR)).toString().trim();
			fDate			= ((Date)listDBBean.valueAtColumnRowResult(AFFDATE_COLUMN,j,INFDTA_CUR)).toString().trim();
			tDate			= ((Date)listDBBean.valueAtColumnRowResult(AFTDATE_COLUMN,j,INFDTA_CUR)).toString().trim();						
			lineId			= ((BigDecimal)listDBBean.valueAtColumnRowResult(AFFORMID_COLUMN,j,INFDTA_CUR)).toString().trim();	
			title		= ((String)listDBBean.valueAtColumnRowResult(AFTITLE_COLUMN,j,INFDTA_CUR)).toString().trim();
			
			updRec			= "Y";					
		}	
%>
    <TR class="<%=j%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap align="left">
        <INPUT type="hidden" name="updRec<%=j%>" value="<%=updRec%>"> 
    	<INPUT type="hidden" name="lineId<%=j%>" value="<%=lineId%>">
      	<SELECT size="1" name="levelId<%=j%>">
      	    <OPTION value=""  <%=levelId.equals("")?"selected":""%>></option>
      		<OPTION value="1" <%=levelId.equals("1")?"selected":""%>>Primaria Incompleta</option>
      		<OPTION value="2" <%=levelId.equals("2")?"selected":""%>>Primaria Completa</OPTION>
			<OPTION value="3" <%=levelId.equals("3")?"selected":""%>>Secundaria Incompleta</OPTION>
			<OPTION value="4" <%=levelId.equals("4")?"selected":""%>>Secundaria Completa</OPTION>
			<OPTION value="5" <%=levelId.equals("5")?"selected":""%>>Tecnico</OPTION>
			<OPTION value="6" <%=levelId.equals("6")?"selected":""%>>Universidad Incompleta</OPTION>
			<OPTION value="7" <%=levelId.equals("7")?"selected":""%>>Universidad Completa</OPTION>
			<OPTION value="8" <%=levelId.equals("8")?"selected":""%>>Post-Grados Incompletos</OPTION>
			<OPTION value="9" <%=levelId.equals("9")?"selected":""%>>Post-Grados Completos</OPTION>
			<OPTION value="10" <%=levelId.equals("10")?"selected":""%>>Maestria Imcompleta</OPTION>
			<OPTION value="11" <%=levelId.equals("11")?"selected":""%>>Maestria Completa</OPTION>
		</SELECT>
      </TD>    
      <TD nowrap align="center">
 		<INPUT type="text" class="text"	size="50" maxlength="40" name="centerName<%=j%>" id="centerName<%=j%>" value="<%=centerName%>">
	  </TD>
	  <TD> 	
	            <SELECT size="1" name="countryId<%=j%>" class="text">
	            <OPTION value="" <%=countryId.length()==0?"selected": ""%>></OPTION>
<%
		int countries = listDBBean.getRowsInResult(COUNTRY_CUR);
		String code  = "";
		String descr = "";
		
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
 		<INPUT type="text" class="text"	size="50" maxlength="40" name="title<%=j%>" id="title<%=j%>" value="<%=title%>">
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
					<TD><INPUT type="button" name="addLines" value="<%=rb.getString("B00034")%>" class="button" onclick="document.myForm.action.value='ALINESACD';document.myForm.linesNumber.value='<%=linesNumber+4%>';document.myForm.submit();"></TD>
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
		  <INPUT type="hidden" name="action" value="EMPACDADD">
		  <INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
		  <INPUT type="hidden" name="employeeName" id="employeeName" value="<%=employeeName%>">		  		  
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00008")%>" class="button">
	</TD>
    <TD align="center" width="35%" height="30"> 
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">  
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="button" name="addnew" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/employee/employeeacademylist.jsp?contextRoot=<%=request.getContextPath()%>&employeeId=<%=employeeId%>&employeeName=<%=employeeName%>';">
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