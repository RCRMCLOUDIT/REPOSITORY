<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css"> 	
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<link rel="stylesheet" href="blue/style.css" type="text/css">

<TITLE>Empleados Configurados</TITLE>
<SCRIPT language="JavaScript" src="js/jquery-latest.js"></SCRIPT>
<SCRIPT language="JavaScript" src="js/jquery.tablesorter.js"></SCRIPT>
<SCRIPT language="JavaScript">
$(document).ready(function() 
    { 
        $("#myTable").tablesorter(); 
    } 
); 
</SCRIPT>
</HEAD> 
<BODY onkeydown="return change_tab(event,'<%=request.getContextPath()%>');">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Empleados Configurados";

 static final int EMPLOY_CUR = 1;

 static final int EDEMPLID_COLUMN		= 1; //EMPLOYEE ID COLUMN
 static final int EDEMPLNM_COLUMN		= 2; //EMPLOYEE NAME COLUMN
 static final int ETEMPTYPDS_COLUMN		= 3; //EMPLOYEE TYPE
 static final int TMTOPMNGRDS_COLUMN	= 4; //TOP MANAGER COLUMN
 static final int CSCOMPSCTDS_COLUMN	= 5; //DEPARTMEN COLUMN 
 static final int JPPROFNM_COLUMN		= 6; //JOB PROFILE COLUMN
 static final int EDJBPRFSAL_COLUMN		= 7; //JOB PROFILE SALARY COLUMN
 static final int EDEMPLSAL_COLUMN		= 8; //EMP SALARY COLUMN
 static final int EDEMPLSEX_COLUMN		= 9; //EMP SEX COLUMN
 static final int EDINTDATE_COLUMN		= 10; //INT DATECOLUMN 
 static final int EDEMPLNUM_COLUMN		= 11; //EMP NUM DATECOLUMN 
 static final int CC_COLUMN				= 12; //COST CENTER DATECOLUMN  

%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/employee.js"></SCRIPT>
<%
 String _tabName = "Empleados Activos (F2)";

 String contextRoot = request.getContextPath(); 
 
 String filter 		= request.getParameter("filter")==null?"0":request.getParameter("filter");
 String employeeNum 	= request.getParameter("employeeNum")==null?"":request.getParameter("employeeNum");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName"); 
 String emplFLetter 	= request.getParameter("emplFLetter")==null?"":request.getParameter("emplFLetter"); 
 
 if(employeeNum.length() != 0 && !employeeNum.equals(""))
 	filter = "1";
 else if(employeeName.length() != 0 && !employeeName.equals(""))
 	filter = "2";
 else if(!emplFLetter.equals(""))
 	filter = "3";
 else	
	filter = "0";

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
 					companyID + "',0,0,'" + employeeName + "','','" + employeeNum + "','',0,0,0,0,'',0,'','',0,0,'',0,0,0,'" + emplFLetter + "','" + filter + "','','','',0,0,'','','EMPLOYLST','','','','','','','',0,'',0,?,?)}";
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
int startIndex = (request.getParameter("startIndex")==null) ? 0 : Integer.parseInt(request.getParameter("startIndex").trim());
int i = 0;

 String link = null;

 String baseLink = contextRoot + "/erp/payrollnic/employee/";
 					
 String link1 = baseLink + "employeeupd.jsp?startIndex=" + startIndex + "&employeeId=";
 String link2 = baseLink + "employeefamlist.jsp?employeeId=";
 String link3 = baseLink + "employeeacademylist.jsp?employeeId=";
 String link4 = baseLink + "employeeexperiencelist.jsp?employeeId=";
 String link5 = baseLink + "employeescalelist.jsp?employeeId=";
 String link6 = baseLink + "employeemoperlist.jsp?employeeId=";
 
 String link7 = contextRoot + "/servlet/com.cap.erp.report.PayRollInfoPDF?action=EMPLINFO&employeeId=";
 
 String aFilter = request.getParameter("aFilter")==null?"":request.getParameter("aFilter");
 
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(EMPLOY_CUR); 
%>
<TABLE width="750" cellpadding="0" cellspacing="1" id="myTable" class="tablesorter" border="0">
<THEAD>
    <TR><TD colspan="9"><%@ include file="scaletab.jspf" %></TD></TR>
    <TR class="tableheader">
    	<TD colspan="9">Empleados Configurados</TD>
    </TR>
    <TR>
      <TH>Numero</TH>
      <TH>Nombre</TH>
      <TH>Tipo</TH>
      <TH>Gerencia/Departamento/Cargo</TH>      
      <TH>Salario de Cargo</TH>            
      <TH>Salario de Empleado</TH> 
      <TH>Sexo</TH>       
      <TH>Fecha de Inicio</TH>             
      <TH>CC</TH>                   
    </TR>
</THEAD>   
<TBODY>
<%
 if (listDBBean.RowCountResult(EMPLOY_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="9"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
		String link1s = link1 + ((BigDecimal)listDBBean.valueAtColumnRowResult(EDEMPLID_COLUMN,i,EMPLOY_CUR)).toString();	
		String link2s = link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(EDEMPLID_COLUMN,i,EMPLOY_CUR)).toString() + "&employeeName=" + (String)listDBBean.valueAtColumnRowResult(EDEMPLNM_COLUMN,i,EMPLOY_CUR).toString().trim();	
		String link3s = link3 + ((BigDecimal)listDBBean.valueAtColumnRowResult(EDEMPLID_COLUMN,i,EMPLOY_CUR)).toString() + "&employeeName=" + (String)listDBBean.valueAtColumnRowResult(EDEMPLNM_COLUMN,i,EMPLOY_CUR).toString().trim();
		String link4s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(EDEMPLID_COLUMN,i,EMPLOY_CUR)).toString() + "&employeeName=" + (String)listDBBean.valueAtColumnRowResult(EDEMPLNM_COLUMN,i,EMPLOY_CUR).toString().trim();
		String link5s = link5 + ((BigDecimal)listDBBean.valueAtColumnRowResult(EDEMPLID_COLUMN,i,EMPLOY_CUR)).toString() + "&employeeName=" + (String)listDBBean.valueAtColumnRowResult(EDEMPLNM_COLUMN,i,EMPLOY_CUR).toString().trim();
		String link6s = link6 + ((BigDecimal)listDBBean.valueAtColumnRowResult(EDEMPLID_COLUMN,i,EMPLOY_CUR)).toString() + "&employeeName=" + (String)listDBBean.valueAtColumnRowResult(EDEMPLNM_COLUMN,i,EMPLOY_CUR).toString().trim();

		String link7s = link7 + ((BigDecimal)listDBBean.valueAtColumnRowResult(EDEMPLID_COLUMN,i,EMPLOY_CUR)).toString() + "&employeeNum=" + (String)listDBBean.valueAtColumnRowResult(EDEMPLNUM_COLUMN,i,EMPLOY_CUR).toString().trim();
				
		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;	
		link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Datos Familiares" + ConstantValue.END_TAG;
		link = link + ConstantValue.PRE_TAG + link3s + ConstantValue.MID_TAG + "Formacion Academica" + ConstantValue.END_TAG;
		link = link + ConstantValue.PRE_TAG + link4s + ConstantValue.MID_TAG + "Experiencia Laboral" + ConstantValue.END_TAG;
		link = link + ConstantValue.PRE_TAG + link5s + ConstantValue.MID_TAG + "Registro de Ausencias" + ConstantValue.END_TAG;		
		link = link + ConstantValue.PRE_TAG + link6s + ConstantValue.MID_TAG + "MOPER" + ConstantValue.END_TAG;
		link = link + ConstantValue.PRE_TAG + link7s + ConstantValue.MID_TAG + "Ficha de Colaborador" + ConstantValue.END_TAG;				
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>" onMouseOver="this.style.cursor='hand';">
      <TD nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 120, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,8000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(String)(listDBBean.valueAtColumnRowResult(EDEMPLNUM_COLUMN,i,EMPLOY_CUR))%></A></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(EDEMPLNM_COLUMN,i,EMPLOY_CUR).toString().trim()%></TD>    
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(ETEMPTYPDS_COLUMN,i,EMPLOY_CUR).toString().trim()%></TD>
      <TD nowrap><%=((String)listDBBean.valueAtColumnRowResult(TMTOPMNGRDS_COLUMN,i,EMPLOY_CUR).toString().trim()) + "/" + ((String)listDBBean.valueAtColumnRowResult(CSCOMPSCTDS_COLUMN,i,EMPLOY_CUR)) + "/" + ((String)listDBBean.valueAtColumnRowResult(JPPROFNM_COLUMN,i,EMPLOY_CUR).toString().trim())%></TD>      
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(EDJBPRFSAL_COLUMN,i,EMPLOY_CUR))%></TD>      
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(EDEMPLSAL_COLUMN,i,EMPLOY_CUR))%></TD> 
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(EDEMPLSEX_COLUMN,i,EMPLOY_CUR).toString().trim()%></TD>     
      <TD nowrap align="center"><%=Format.date_Str(listDBBean.valueAtColumnRowResult(EDINTDATE_COLUMN,i,EMPLOY_CUR).toString())%></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(CC_COLUMN,i,EMPLOY_CUR).toString().trim()%></TD>               
    </TR>
<%
	i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
 startIndex = i;
}
listDBBean.closeResultSet();
%>
</TBODY> 
</TABLE>

<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR><TD width="30%" height="30">
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/employeeadd.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD width="20%" align="center" height="30" class="label">Numero de Empleado:
		<FORM name="Buscar1" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/employeelist.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="hidden" name="filter" value="1">
		  <INPUT type="text" name="employeeNum" size="10" maxlength="10" value="<%=employeeNum%>">
		  <INPUT type="submit" name="GO" value="<%=rb.getString("B00015")%>" class="button" onClick="form.Buscar2.employeeName.value = '';">
		</FORM>    
    </TD>
    <TD width="20%" align="center" height="30" class="label">Nombre de Empleado:
		<FORM name="Buscar2" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/employeelist.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="hidden" name="filter" value="1">
		  <INPUT type="text" name="employeeName" size="10" maxlength="10" value="<%=employeeName%>">
		  <INPUT type="submit" name="GO" value="<%=rb.getString("B00015")%>" class="button" onClick="form.Buscar1.employeeNum.value = '';">
		</FORM>    
    </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</BODY>
</HTML>