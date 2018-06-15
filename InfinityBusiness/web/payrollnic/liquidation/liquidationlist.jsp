<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Lista de Liquidaciones</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Lista de Liquidaciones";

static final int LIQLST_CUR = 1;

static final int LQLIQUID_COLUMN	= 1;
static final int LQLIQUNUM_COLUMN	= 2;
static final int LQDATE_COLUMN 		= 3;
static final int LQEMPLID_COLUMN 	= 4;
static final int LQEMPLNUM_COLUMN	= 5;
static final int LQEMPLNM_COLUMN	= 6;     
static final int LQPROFNM_COLUMN	= 8;
static final int LQTOPMNGRDS_COLUMN	= 9;
static final int LQCOMPSCTDS_COLUMN = 10;
static final int LQCC_COLUMN		= 14;
static final int LQSALTYPE_COLUMN	= 16;           
static final int LQINTDATE_COLUMN	= 17;
static final int LQENDDATE_COLUMN	= 18;
static final int LQDECDATE_COLUMN	= 19;
static final int LQPAYDATE_COLUMN	= 20;
static final int LQREAZON_COLUMN	= 21;
static final int LQSTATUS_COLUMN	= 27;
static final int USERLOGGED_COLUMN	= 32;
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
<SCRIPT language="JavaScript" src="../js/employee.js"></SCRIPT>
<%
 String contextRoot = request.getContextPath(); 
 
 String filter 			= request.getParameter("filter")==null?"0":request.getParameter("filter");
 String employeeNum 	= request.getParameter("employeeNum")==null?"":request.getParameter("employeeNum");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName"); 

 String fDate			= request.getParameter("fDate")==null?Format.getSysDate():request.getParameter("fDate");
 String tDate			= request.getParameter("tDate")==null?Format.getSysDate():request.getParameter("tDate");
 
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLLIQS('" + 
 					companyID + "',0,0,'" + employeeName + "','" + employeeNum + "',0,'" + Format.strDatetoSQLDate(fDate) + "','" + Format.strDatetoSQLDate(tDate) + "','','" + user_ID + "','','EMPLIQLST','','','',0,?,?)}";
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

 String baseLink = contextRoot + "/erp/payrollnic/liquidation/";
 					
 String link1 = baseLink + "liquidationdetail.jsp?liquidationId=";
 String link2 = baseLink + "premplliqs.jsp?liquidationId=";
 String link3 = contextRoot + "/servlet/com.cap.erp.report.PayRollInfoPDF?liquidationId=";
 String link4 = baseLink + "premplliqs.jsp?liquidationId="; 
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(LIQLST_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="13">Lista de Liquidaciones</TD>
    </TR>
    <TR class="tableheader">
      <TD>Liquidacion No.</TD>
      <TD>Fecha</TD>
      <TD>No. Empleado</TD>
      <TD>Nombre Completo</TD>      
      <TD>Puesto</TD>            
      <TD>Gerencia</TD> 
      <TD>Departamento</TD>       
      <TD>Centro de Costo</TD>
      <TD>Tipo de Salario</TD>
      <TD>Fecha de Inicio</TD>
	  <TD>Fecha de Retiro</TD>
	  <TD>Fecha Ult. Aguinaldo</TD>
	  <TD>Fecha Ult. Nomina</TD>	  
    </TR>
<%
 if (listDBBean.RowCountResult(LIQLST_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="13"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
	
		String link1s = link1 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString();	
		String link2s = link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString() + "&action=CALIR";
		String link3s = link3 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString() + "&action=EMPLIQRPT";
		String link4s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString() + "&action=EMPLIQDEL";
		String link5s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString() + "&action=REVISED&employeeId="+((BigDecimal)listDBBean.valueAtColumnRowResult(USERLOGGED_COLUMN,i,LIQLST_CUR)).toString();
		String link6s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString() + "&action=AUTHORIZE&employeeId="+((BigDecimal)listDBBean.valueAtColumnRowResult(USERLOGGED_COLUMN,i,LIQLST_CUR)).toString();
		String link7s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString() + "&action=APPROVE&employeeId="+((BigDecimal)listDBBean.valueAtColumnRowResult(USERLOGGED_COLUMN,i,LIQLST_CUR)).toString();
		String link8s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString() + "&action=VALINDM&employeeId="+((BigDecimal)listDBBean.valueAtColumnRowResult(LQEMPLID_COLUMN,i,LIQLST_CUR)).toString()+"&reazonId="+((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,i,LIQLST_CUR)).toString();
		String link9s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString() + "&action=GENJRN";
		String link10s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString() + "&action=LIQRELOAD&employeeId="+((BigDecimal)listDBBean.valueAtColumnRowResult(LQEMPLID_COLUMN,i,LIQLST_CUR)).toString()+"&reazonId="+((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,i,LIQLST_CUR)).toString();;
		
		String link11s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LQLIQUID_COLUMN,i,LIQLST_CUR)).toString() + "&action=REOPEN";
		
		String status = ((String)listDBBean.valueAtColumnRowResult(LQSTATUS_COLUMN,i,LIQLST_CUR)).toString();

		if(status.equals("DR"))
		{	
		    link = ConstantValue.PRE_TAG + link10s + ConstantValue.MID_TAG + "Regenerar Liquidacion" + ConstantValue.END_TAG;	
			link = link + ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Trabajar Liquidacion" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Calcular IR" + ConstantValue.END_TAG;	
			link = link + ConstantValue.PRE_TAG + link5s + ConstantValue.MID_TAG + "Liquidacion Revisada" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link8s + ConstantValue.MID_TAG + "Validar Indemnizacion" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link3s + ConstantValue.MID_TAG + "Reporte Liquidacion" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link4s + ConstantValue.MIDDEL_TAG + "Anular Liquidacion" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link9s + ConstantValue.MID_TAG + "Generar Comprobante" + ConstantValue.END_TAG;
		}	
		else if(status.equals("RV"))
		{		
			link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Trabajar Liquidacion" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Calcular IR" + ConstantValue.END_TAG;	
			link = link + ConstantValue.PRE_TAG + link6s + ConstantValue.MID_TAG + "Autorizar Liquidacion" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link3s + ConstantValue.MID_TAG + "Reporte Liquidacion" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link4s + ConstantValue.MIDDEL_TAG + "Anular Liquidacion" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link9s + ConstantValue.MID_TAG + "Generar Comprobante" + ConstantValue.END_TAG;
		}			
		else
		{
			if(user_ID.trim().equals("RCROMERO") || user_ID.trim().equals("JMENDOZA"))
			{
				link = ConstantValue.PRE_TAG + link11s + ConstantValue.MID_TAG + "Reabrir Liquidacion" + ConstantValue.END_TAG;
				link = link + ConstantValue.PRE_TAG + link3s + ConstantValue.MID_TAG + "Reporte Liquidacion" + ConstantValue.END_TAG;
			}
			else
				link = ConstantValue.PRE_TAG + link3s + ConstantValue.MID_TAG + "Reporte Liquidacion" + ConstantValue.END_TAG;
		}
		
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF'"];">
      <TD nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 120, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,11000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(String)(listDBBean.valueAtColumnRowResult(LQLIQUNUM_COLUMN,i,LIQLST_CUR))%></A></TD>
      <TD nowrap align="center"><%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQDATE_COLUMN,i,LIQLST_CUR).toString())%></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(LQEMPLNUM_COLUMN,i,LIQLST_CUR).toString().trim()%></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(LQEMPLNM_COLUMN,i,LIQLST_CUR).toString().trim()%></TD>
      <TD nowrap><%=((String)listDBBean.valueAtColumnRowResult(LQPROFNM_COLUMN,i,LIQLST_CUR).toString().trim())%></TD> 
      <TD nowrap><%=((String)listDBBean.valueAtColumnRowResult(LQTOPMNGRDS_COLUMN,i,LIQLST_CUR).toString().trim())%></TD> 
      <TD nowrap><%=((String)listDBBean.valueAtColumnRowResult(LQCOMPSCTDS_COLUMN,i,LIQLST_CUR).toString().trim())%></TD>      
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(LQCC_COLUMN,i,LIQLST_CUR).toString().trim()%></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(LQSALTYPE_COLUMN,i,LIQLST_CUR).toString().trim()%></TD>
      <TD nowrap align="center"><%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQINTDATE_COLUMN,i,LIQLST_CUR).toString())%></TD>
      <TD nowrap align="center"><%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQENDDATE_COLUMN,i,LIQLST_CUR).toString())%></TD>
      <TD nowrap align="center"><%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQDECDATE_COLUMN,i,LIQLST_CUR).toString())%></TD>
      <TD nowrap align="center"><%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQPAYDATE_COLUMN,i,LIQLST_CUR).toString())%></TD>
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/liquidation/liquidationentry.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD width="20%" align="center" height="30" class="label">Numero de Empleado:
		<FORM name="Buscar1" method="post" action="<%=contextRoot%>/erp/payrollnic/liquidation/liquidationlist.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="action" value="EMPLIQLST">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="hidden" name="filter" value="1">
		  <INPUT type="text" name="employeeNum" size="10" maxlength="10" value="<%=employeeNum%>">
		  <INPUT type="submit" name="GO" value="<%=rb.getString("B00015")%>" class="button" onClick="form.Buscar2.employeeName.value = '';">
		</FORM>    
    </TD>
    <TD width="20%" align="center" height="30" class="label">Nombre de Empleado:
		<FORM name="Buscar2" method="post" action="<%=contextRoot%>/erp/payrollnic/liquidation/liquidationlist.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="action" value="EMPLIQLST">
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
</HTML>