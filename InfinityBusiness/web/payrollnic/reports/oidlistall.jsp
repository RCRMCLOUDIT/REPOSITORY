<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Reporte Otros Ingresos/Deducciones</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Reporte Otros Ingresos/Deducciones";

 static final int OICD_CUR = 1;

	//OTHER INCOME AND OUTCOME REPORT
	 static final int OITLCONCID_COLUMN			= 1;
	 static final int OITLEMPLNUM_COLUMN		= 2;
	 static final int OITLEMPLNM_COLUMN			= 3;
	 static final int OITLNAME_COLUMN			= 4;
	 static final int OITLCONCTYP_COLUMN		= 5;
	 static final int OITLAMOUNT_COLUMN			= 6;
	 static final int OIPYDTFROM_COLUMN 	 	= 7;
	 static final int OIPYDTTO_COLUMN 	 		= 8;
	 static final int OIPROFNM_COLUMN			= 9;
	 static final int OITOPMNGRDS_COLUMN		= 10;
	 static final int OICOMPSCTDS_COLUMN		= 11;	 
	 static final int OICC_COLUMN				= 12;	
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
 String contextRoot = request.getContextPath(); 
 
 String employeeId 		= request.getParameter("employeeId")==null?"0":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 String employeeTypeId 	= request.getParameter("employeeTypeId")==null?"0":request.getParameter("employeeTypeId");    
 String conceptId		= request.getParameter("conceptId")==null?"":request.getParameter("conceptId"); 
 
 String fDate		= request.getParameter("fDate")==null?"":request.getParameter("fDate");
 String tDate		= request.getParameter("tDate")==null?"":request.getParameter("tDate");
 
 
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
    	  	companyID + "'," + 														
    	  	companyEID + "," + employeeId + ",'','','',''," + employeeTypeId + "," + conceptId + ",0,0,'',0,'" + 
 					Format.strDatetoSQLDate(fDate) + "','" +
 					Format.strDatetoSQLDate(tDate) + "',0,0,'',0,0,0,'','','','','',0,0,'','','RPTIDRPT','','','','','','','',0,'',?,?)}";
 

 
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

 String baseLink = contextRoot + "/erp/payrollnic/reports/";
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(OICD_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="10">Reporte Otros Ingresos/Deducciones</TD>
    </TR>
    <TR class="tableheader">
    	<TD colspan="10">Desde <%=fDate%> - Hasta <%=tDate%></TD>
    </TR>    
    <TR class="tableheader">
      <TD>#Empleado</TD>      
      <TD>Nombre de Empleado</TD>
      <TD>Puesto</TD>
      <TD>Moneda</TD>      
      <TD>Monto</TD>
	  <TD>Gerencia</TD>
	  <TD>Departamento</TD>
	  <TD>Centro de Costo</TD>	  
	  <TD>Fecha de Movimiento</TD>      
    </TR>
<%
    String preConceptId		= "";
    String preConceptNM		= "";
    String conceptType		= "";
    BigDecimal tlTot		= new BigDecimal("0.00");
    BigDecimal tlTotGN		= new BigDecimal("0.00");
    int pRows				= 0;

 if (listDBBean.RowCountResult(OICD_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="10"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
				conceptId		= ((BigDecimal)listDBBean.valueAtColumnRowResult(OITLCONCID_COLUMN,i,OICD_CUR)).toString().trim();
				conceptType		= (String)listDBBean.valueAtColumnRowResult(OITLCONCTYP_COLUMN,i,OICD_CUR).toString().trim();

				if(conceptType.equals("I") || conceptType.equals("D"))
				{	
					if(!preConceptId.equals(conceptId))
					{
						if(i > 0)
						{
%>
		    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
		 	   <TD colspan = "4" nowrap>TOTAL <%=preConceptNM%> (<%=pRows%>):</TD>
				<TD nowrap><%=Format.displayCurrency(tlTot)%></TD>
			</TR>	
<%
							tlTot = new BigDecimal("0.00");
							pRows = 0;
						}
 %>
 		    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
		 	   <TD colspan = "5" nowrap>
		 	   	<%=(String)listDBBean.valueAtColumnRowResult(OITLNAME_COLUMN,i,OICD_CUR).toString().trim() + " / "  + (((String)listDBBean.valueAtColumnRowResult(OITLCONCTYP_COLUMN,i,OICD_CUR)).toString().trim().equals("I")?"Ingresos":"Deducciones")%>
		 	  </TD>
			</TR>	
<%
					}
						tlTot 			= tlTot.add((BigDecimal)listDBBean.valueAtColumnRowResult(OITLAMOUNT_COLUMN,i,OICD_CUR));
						tlTotGN 		= tlTotGN.add((BigDecimal)listDBBean.valueAtColumnRowResult(OITLAMOUNT_COLUMN,i,OICD_CUR));						
						preConceptNM  	= (String)listDBBean.valueAtColumnRowResult(OITLNAME_COLUMN,i,OICD_CUR).toString().trim();
		
%> 
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(OITLEMPLNUM_COLUMN,i,OICD_CUR).toString().trim()%></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(OITLEMPLNM_COLUMN,i,OICD_CUR).toString().trim()%></TD>    
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(OIPROFNM_COLUMN,i,OICD_CUR).toString().trim()%></TD>
      <TD nowrap>C$</TD>
      <TD nowrap><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(OITLAMOUNT_COLUMN,i,OICD_CUR))%></TD>   
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(OITOPMNGRDS_COLUMN,i,OICD_CUR).toString().trim()%></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(OICOMPSCTDS_COLUMN,i,OICD_CUR).toString().trim()%></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(OICC_COLUMN,i,OICD_CUR).toString().trim()%></TD>
	  <TD nowrap><%=Format.date_Str((listDBBean.valueAtColumnRowResult(OIPYDTTO_COLUMN,i,OICD_CUR)).toString().trim())%></TD>       
    </TR>
<%
						preConceptId 	= conceptId;
						pRows++;
						i++;
				}
	}
	catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
 startIndex = i;
}
listDBBean.closeResultSet();
%>
</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR>
    <TD width="30%" height="30">
	</TD>
    <TD width="20%" align="center" height="30" class="label">
 		  <INPUT type="button" name="addnew" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/reports/oidentry.jsp?contextRoot=<%=request.getContextPath()%>';">
    </TD>
    <TD width="20%" align="center" height="30" class="label">
  
    </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>