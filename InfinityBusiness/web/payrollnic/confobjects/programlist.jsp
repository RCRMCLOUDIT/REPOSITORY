<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Lista de Programacion</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Lista de Programacion";

 static final int PRGLIST_CUR = 1;

 static final int PHPROYID_COLUMN		= 1; //PROGRAM ID
 static final int PHDESCRH_COLUMN		= 2; //PROGRAM DESCR
 static final int PHFDATE_COLUMN		= 3; //FROM DATE
 static final int PHTDATE_COLUMN		= 4; //TO DATE
 static final int DONEBY_COLUMN			= 5; //DONE BYE EMPLOYEE
 static final int REVBY_COLUMN			= 6; //REVISE BY EMPLOYEE
 static final int AUTBY_COLUMN			= 7; //AUTHORIZE BY EMPLOYEE
 static final int PHSTATUS_COLUMN		= 8; //STATUS
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
  String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCALENS('" + 
 					companyID + "',0,0,0,0,'','','','',0,0,0,'','','','LISTPRG',?,?)}"; 

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

 String baseLink = contextRoot + "/erp/payrollnic/confobjects/";
 					
 String link1 = baseLink + "updprogram.jsp?startIndex=" + startIndex + "&proyId=";
 String link2 = baseLink + "objectslist.jsp?startIndex=" + startIndex + "&proyId=";
 String link3 = baseLink + "prcalens.jsp?action=CHGSTATUS&startIndex=" + startIndex + "&proyId=";
 
 String link4 = contextRoot + "/servlet/com.cap.erp.report.PayRollInfoPDF?action=PRTPRG&proyId=";
 String link5 = baseLink + "prcalens.jsp?action=GENPAY&startIndex=" + startIndex + "&proyId=";
 
 String link6 = baseLink + "prcalens.jsp?action=VALSAL&startIndex=" + startIndex + "&proyId=";
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(PRGLIST_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="8">Lista de Programas</TD>
    </TR>
    <TR class="tableheader">
      <TD width="10%">Id de Programa</TD>
      <TD width="50%">Descripcion</TD>
      <TD width="20%">Fecha De</TD>      
      <TD width="20%">Fecha A</TD>
      <TD width="30%">Elaborado Por</TD>
      <TD width="30%">Revisado Por</TD>
      <TD width="30%">Autorizado Por</TD>         
      <TD width="30%">Status</TD>            
    </TR>
<%
 String status = "";

 //if (listDBBean.RowCountResult(PRGLIST_CUR)==0) 
 if (numOfRows==0)
 {
%>
	<TR>
	 <TH colspan="8"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
		String link1s = link1 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)).toString();	
		String link2s = link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)).toString();
		String link3s = link3 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)).toString();
		String link4s = link3 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)).toString() + "&startValidate=Y";
		String link7s = link3 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)).toString() + "&startValidate=N";
		String link8s = link5 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)).toString();

		//REPORTS
		String link5s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)).toString() + "&rptXLS=N";
		String link6s = link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)).toString() + "&onlyReport=Y";
		String link9s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)).toString() + "&rptXLS=Y";
				
		//VALIDATE EMPLOYEE SALARIES
		String link10s = link6 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)).toString();

		
		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;
		link = link + ConstantValue.PRE_TAG + link5s + ConstantValue.MID_TAG + "Imprimir Toda Programacion" + ConstantValue.END_TAG;
		link = link + ConstantValue.PRE_TAG + link9s + ConstantValue.MID_TAG + "Imprimir Toda Programacion XLS" + ConstantValue.END_TAG;
		link = link + ConstantValue.PRE_TAG + link6s + ConstantValue.MID_TAG + "Imprimir Programacion x Objetivo" + ConstantValue.END_TAG;
		
		status = ((String)listDBBean.valueAtColumnRowResult(PHSTATUS_COLUMN,i,PRGLIST_CUR)).toString();
		
		if(status.equals("DR"))
		{
			status = "Borrador";
			link = link+ ConstantValue.PRE_TAG + link10s + ConstantValue.MID_TAG + "Validar Salarios" + ConstantValue.END_TAG;
			link = link+ ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Detalle Proyeccion" + ConstantValue.END_TAG;			
			link = link+ ConstantValue.PRE_TAG + link3s + ConstantValue.MID_TAG + "Cerrar Proyeccion" + ConstantValue.END_TAG;
		}
		else if(status.equals("PR"))
		{
			status = "Proyectado";
			link = link+ ConstantValue.PRE_TAG + link10s + ConstantValue.MID_TAG + "Validar Salarios" + ConstantValue.END_TAG;
			link = link+ ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Detalle Proyeccion" + ConstantValue.END_TAG;			
			link = link+ ConstantValue.PRE_TAG + link4s + ConstantValue.MID_TAG + "Comenzar Validacion" + ConstantValue.END_TAG;						
		}	
		else if(status.equals("VL"))
		{
			status = "En Validacion";
			link = link+ ConstantValue.PRE_TAG + link10s + ConstantValue.MID_TAG + "Validar Salarios" + ConstantValue.END_TAG;			
			link = link+ ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Detalle Validacion" + ConstantValue.END_TAG;			
			link = link+ ConstantValue.PRE_TAG + link7s + ConstantValue.MID_TAG + "Cerrar Validacion" + ConstantValue.END_TAG;									
		}
		else if(status.equals("VC"))
		{
			status = "Validado";
			link = link+ ConstantValue.PRE_TAG + link8s + ConstantValue.MID_TAG + "Generar Nomina" + ConstantValue.END_TAG;									
		}
		else if(status.equals("CL"))
			status = "Cerrado";			
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      	<TD align="center" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 180, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,4000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(BigDecimal)listDBBean.valueAtColumnRowResult(PHPROYID_COLUMN,i,PRGLIST_CUR)%></A></TD>    
      	<TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(PHDESCRH_COLUMN,i,PRGLIST_CUR))%></TD>
      	<TD nowrap><%=Format.date_Str(listDBBean.valueAtColumnRowResult(PHFDATE_COLUMN,i,PRGLIST_CUR).toString())%></TD>      
      	<TD nowrap><%=Format.date_Str(listDBBean.valueAtColumnRowResult(PHTDATE_COLUMN,i,PRGLIST_CUR).toString())%></TD>
		<TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(DONEBY_COLUMN,i,PRGLIST_CUR))%></TD>
		<TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(REVBY_COLUMN,i,PRGLIST_CUR))%></TD>
		<TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(AUTBY_COLUMN,i,PRGLIST_CUR))%></TD>
		<TD nowrap><%=status%></TD>
    </TR>

<%		
		i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
 startIndex = i;
}
listDBBean.closeResultSet();
%>
</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR><TD width="30%" height="30">
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/confobjects/newprogram.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD align="center" width="35%" height="30">
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>