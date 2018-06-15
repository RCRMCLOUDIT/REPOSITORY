<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Nomina Quincenal x Seccion</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Nomina Quincenal x Seccion";

 static final int PAYROLLS_CUR = 1;
 static final int OBJECTS_CUR  = 2;

 static final int CSCOMPSCTDS_COLUMN	= 1; 
 static final int PLEMPLSAL_COLUMN		= 2; 
 static final int PLEMPLSALQT_COLUMN	= 3; 
 static final int PLMISSAMT_COLUMN		= 4;  
 static final int PLEXHRAMT_COLUMN		= 5;  
 static final int PLVACSAMT_COLUMN		= 6;    
 static final int PLRVACAMT_COLUMN		= 7;    
 static final int PLTOTAL_COLUMN		= 8;
 static final int PLSICKAMT_COLUMN		= 9;    
 static final int PLSEPHRAMT_COLUMN		= 10;
 static final int PLEMPLAGNQT_COLUMN	= 11;
 static final int PLFERHRAMT_COLUMN		= 12;
 static final int PLCOMPSCTID_COLUMN	= 13;  
 static final int CSCOMPSCTAV_COLUMN	= 16;

 //BY OBJECT
 static final int PLEMPLSALOB_COLUMN	= 1; 
 static final int PLEMPLSALQTOB_COLUMN	= 2; 
 static final int PLMISSAMTOB_COLUMN	= 3;  
 static final int PLEXHRAMTOB_COLUMN	= 4;  
 static final int PLVACSAMTOB_COLUMN	= 5;    
 static final int PLRVACAMTOB_COLUMN	= 6;    
 static final int PLTOTALOB_COLUMN		= 7;
 static final int PLSICKAMTOB_COLUMN	= 8;    
 static final int PLSEPHRAMTOB_COLUMN	= 9;
 static final int PLEMPLAGNQTOB_COLUMN	= 10;
 static final int PLFERHRAMTOB_COLUMN	= 11;
 static final int OBJNAME_COLUMN		= 14;
 static final int COOBJID_COLUMN		= 15;  
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 

 String payrollId = request.getParameter("payrollId")==null?"0":request.getParameter("payrollId");

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRPAYSALAS('" + 
 					companyID + "'," + 
 					companyEID + ",0," + payrollId + ",0,0,'',0,0,'','','','LSTSECTSL',?,?)}"; 
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
int startIndex = (request.getParameter("startIndex")==null) ? 0 : Integer.parseInt(request.getParameter("startIndex").trim());
int i = 0;
int j = 0;

 String link 	= null;//MAIN LINK
 String linkOBJ = null;//OBJ LINK

 String baseLink = contextRoot + "/erp/payrollnic/mainpayroll/";
 					
 String link1 = baseLink + "wrkpaysalary.jsp?startIndex=" + startIndex + "&payrollId=";  
 String link2 = contextRoot + "/servlet/com.cap.erp.report.PayRollInfoPDF?payrollId="; 
  
 listDBBean.execute(); 

 int numOfRows  = listDBBean.getRowsInResult(PAYROLLS_CUR);
 int numOfRows2 = listDBBean.getRowsInResult(OBJECTS_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="12">Nomina Quincenal x Seccion</TD>
    </TR>
    <TR class="tableheader">
      <TD>Departamento</TD>
      <TD>Total Sueldo Basico(Mensual)</TD>      
      <TD>Total Sueldo Basico(Quincenal)</TD>      
      <TD>Total Monto Antiguedad</TD> 
      <TD>Total Monto Dias Falta</TD> 
      <TD>Total Monto Horas Extras</TD> 
      <TD>Total Monto Vacaciones Pagadas</TD>             
      <TD>Total Monto Vacaciones Descansadas</TD>             
      <TD>Total Monto Subsidio</TD>             
      <TD>Total Monto Feriado
      <TD>Total Monto Septimo Laboral</TD>             
      <TD>Total Quincena</TD>             
    </TR>
<%

 if (listDBBean.RowCountResult(PAYROLLS_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="12"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{
		String link1s = link1 + payrollId + "&sectionId=" + ((BigDecimal)listDBBean.valueAtColumnRowResult(PLCOMPSCTID_COLUMN,i,PAYROLLS_CUR)).toString();	
		String link2s = link2 + payrollId + "&sectionId=" + ((BigDecimal)listDBBean.valueAtColumnRowResult(PLCOMPSCTID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=LSTPAYSAL";
		String link4s = "";
		
		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Trabajar Planilla Quincenal" + ConstantValue.END_TAG;	
		link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Formato Planilla Quincenal(XLS)" + ConstantValue.END_TAG;			


%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
 <%
 		if(((String)listDBBean.valueAtColumnRowResult(CSCOMPSCTAV_COLUMN,i,PAYROLLS_CUR)).toString().trim().equals("VIG"))
		{
  %>
 		<TD align="left" nowrap><%=(String)listDBBean.valueAtColumnRowResult(CSCOMPSCTDS_COLUMN,i,PAYROLLS_CUR)%></TD>
  <%	} 
  		else
  		{ 
  %>   
      	<TD align="left" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 200, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,6000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(String)listDBBean.valueAtColumnRowResult(CSCOMPSCTDS_COLUMN,i,PAYROLLS_CUR)%></A></TD>    
<%		} %>
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLSAL_COLUMN,i,PAYROLLS_CUR))%></TD>
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLSALQT_COLUMN,i,PAYROLLS_CUR))%></TD> 
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLAGNQT_COLUMN,i,PAYROLLS_CUR))%></TD> 
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLMISSAMT_COLUMN,i,PAYROLLS_CUR))%></TD>
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEXHRAMT_COLUMN,i,PAYROLLS_CUR))%></TD>            
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLVACSAMT_COLUMN,i,PAYROLLS_CUR))%></TD>
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLRVACAMT_COLUMN,i,PAYROLLS_CUR))%></TD>                  
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLSICKAMT_COLUMN,i,PAYROLLS_CUR))%></TD>
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLFERHRAMT_COLUMN,i,PAYROLLS_CUR))%></TD> 
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLSEPHRAMT_COLUMN,i,PAYROLLS_CUR))%></TD> 
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLTOTAL_COLUMN,i,PAYROLLS_CUR))%></TD>                  
    </TR>
<%
		if(((String)listDBBean.valueAtColumnRowResult(CSCOMPSCTAV_COLUMN,i,PAYROLLS_CUR)).toString().trim().equals("VIG"))
		{
%>
		<TR class="label">
			<TD colspan = "12">Objetivos</TD>
		</TR>	
<% 		
			   for (j = 0; j < numOfRows2 ; ) 
   			   { 
			   	try 
			    {
					link4s	= link1s + "&objectId=" + ((BigDecimal)listDBBean.valueAtColumnRowResult(COOBJID_COLUMN,j,OBJECTS_CUR)).toString();
					linkOBJ = ConstantValue.PRE_TAG + link4s + ConstantValue.MID_TAG + "Trabajar Planilla Quincenal" + ConstantValue.END_TAG;				
%>
			<TR class="<%=j%2==0?"pcrinfo":"pcrinfo1"%>">
      			<TD nowrap class="label"  align="right" ><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=linkOBJ%>', STICKY, WIDTH, 200, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,6000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(String)listDBBean.valueAtColumnRowResult(OBJNAME_COLUMN,j,OBJECTS_CUR)%></A></TD>    
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLSALOB_COLUMN,j,OBJECTS_CUR))%></TD>
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLSALQTOB_COLUMN,j,OBJECTS_CUR))%></TD> 
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLAGNQTOB_COLUMN,j,OBJECTS_CUR))%></TD> 
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLMISSAMTOB_COLUMN,j,OBJECTS_CUR))%></TD>
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEXHRAMTOB_COLUMN,j,OBJECTS_CUR))%></TD>            
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLVACSAMTOB_COLUMN,j,OBJECTS_CUR))%></TD>
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLRVACAMTOB_COLUMN,j,OBJECTS_CUR))%></TD>                  
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLSICKAMTOB_COLUMN,j,OBJECTS_CUR))%></TD>
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLFERHRAMTOB_COLUMN,j,OBJECTS_CUR))%></TD> 
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLSEPHRAMTOB_COLUMN,j,OBJECTS_CUR))%></TD> 
      			<TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLTOTALOB_COLUMN,j,OBJECTS_CUR))%></TD>                  
   	 		</TR>		
<%
					j++;		
				}//END OF TRY object
				catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
			}//END OF FOR FOR OBJECTS	
		}//END OF IF VIG
		i++; 
	}//END OF TRY
	catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 }//END OF FOR
  
 startIndex = i;
}//END OF ELSE
listDBBean.closeResultSet();
%>
</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR><TD width="30%" height="30">
		<FORM name="Cancel" method="post" action="<%=contextRoot%>/erp/payrollnic/mainpayroll/mainpayrolllist.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="cancel" value="<%=rb.getString("B00010")%>" class="button">
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