<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Actualizar Retencion de Ley</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.name.focus()">
<%! 
 static final String title = "Actualizar Retencion de Ley"; 

 static final int TAXES_CUR = 1;

 static final int TXTAXID_COLUMN		= 1;
 static final int TXTAXNM_COLUMN		= 2;
 static final int TXTAXDS_COLUMN		= 3;
 static final int TXTAXORD_COLUMN		= 4;
 static final int TXISSS_COLUMN			= 5;
 static final int TXISIR_COLUMN			= 6;
 static final int TXCALBSON_COLUMN		= 7;
 static final int TXPAYEID_COLUMN		= 8;
 static final int TXPAYENM_COLUMN		= 9;                                 
 static final int TXDBACCNT1_COLUMN		= 10;
 static final int TXDBACCNT2_COLUMN		= 11;
 static final int TXDBACCNT3_COLUMN		= 12;
 static final int TXDBACCNT4_COLUMN		= 13;
 static final int TXDBACCNT5_COLUMN		= 14;
 static final int TXCRACCNT1_COLUMN		= 15;
 static final int TXCRACCNT2_COLUMN		= 16;
 static final int TXCRACCNT3_COLUMN		= 17;
 static final int TXCRACCNT4_COLUMN		= 18;
 static final int TXCRACCNT5_COLUMN		= 19;     
 static final int DBGLNM_COLUMN			= 20; 
 static final int CRGLNM_COLUMN			= 21;                       
 static final int TXEMPLRT_COLUMN		= 22;
 static final int TXCOMPRT_COLUMN		= 23;
 static final int TXEMPLAMT_COLUMN		= 24;
 static final int TXCOMPAMT_COLUMN		= 25;  
 static final int TXMAXAMNT_COLUMN		= 26;                            
%>

<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_charcounterJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/charcounter.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/taxes.js"></SCRIPT>
<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 ********************************************************************************/

 String Id 			= request.getParameter("Id")==null?"":request.getParameter("Id");  
 
 String name 		= request.getParameter("name")==null?"":request.getParameter("name");
 String descrp 		= request.getParameter("descrp")==null?"":request.getParameter("descrp");
 String taxOrd 		= request.getParameter("taxOrd")==null?"":request.getParameter("taxOrd");
 String taxType 	= request.getParameter("taxType")==null?"":request.getParameter("taxType");
 String calBSON 	= request.getParameter("calBSON")==null?"":request.getParameter("calBSON");
 
 String compRT 		= request.getParameter("compRT")==null?"":request.getParameter("compRT");
 String emplRT 		= request.getParameter("emplRT")==null?"":request.getParameter("emplRT");
 String compAM 		= request.getParameter("compAM")==null?"":request.getParameter("compAM");
 String emplAM 		= request.getParameter("emplAM")==null?"":request.getParameter("emplAM");    
 
 String maxAmt 		= request.getParameter("maxAmt")==null?"":request.getParameter("maxAmt");
 
 String vendorId 	= request.getParameter("vendorId")==null?"":request.getParameter("vendorId");  
 String vendorName	= request.getParameter("vendorName")==null?"":request.getParameter("vendorName");    
 
 //debit account
 String level1     = request.getParameter("level1")==null?"":request.getParameter("level1");
 String levelText1 = request.getParameter("levelText1")==null?"":request.getParameter("levelText1");
 //credit account
 String level2     = request.getParameter("level2")==null?"":request.getParameter("level2");
 String levelText2 = request.getParameter("levelText2")==null?"":request.getParameter("levelText2");    
 
 String contextRoot = request.getContextPath();

 String errMsg 	= null;

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
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRTAXES('" + 
 					companyID + "',0," + Id + ",'','',0,'','','',0,'','','','','','','','','','',0,0,0,0,'','','TAXEDT',0,?,?)}";
 					 
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="updateDBBean" class="com.cap.erp.SPDBBean" scope="page">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="updateDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="updateDBBean" />
</jsp:useBean>
<%
 updateDBBean.execute(); 
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= contextRoot %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />
<%
String isINSS 	= "";
String iSIR		= "";
 if (returnWithError.equals("N"))
 { 
	 try
	 {
		name 		= (String)updateDBBean.valueAtColumnRowResult(TXTAXNM_COLUMN,0,TAXES_CUR).toString().trim(); 
		descrp 		= (String)updateDBBean.valueAtColumnRowResult(TXTAXDS_COLUMN,0,TAXES_CUR).toString().trim(); 
		taxOrd 		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(TXTAXORD_COLUMN,0,TAXES_CUR)).toString().trim();
		
		isINSS 		= (String)updateDBBean.valueAtColumnRowResult(TXISSS_COLUMN,0,TAXES_CUR).toString().trim();
		iSIR		= (String)updateDBBean.valueAtColumnRowResult(TXISIR_COLUMN,0,TAXES_CUR).toString().trim();

		if(isINSS.equals("Y"))
			taxType 	= "SS";
		else if(iSIR.equals("Y"))	
			taxType 	= "IR";
		else
			taxType 	= "OT";	
			
		calBSON 	= (String)updateDBBean.valueAtColumnRowResult(TXCALBSON_COLUMN,0,TAXES_CUR).toString().trim(); 
 
		compRT 		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(TXCOMPRT_COLUMN,0,TAXES_CUR)).toString().trim();
		emplRT 		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(TXEMPLRT_COLUMN,0,TAXES_CUR)).toString().trim();
		compAM 		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(TXCOMPAMT_COLUMN,0,TAXES_CUR)).toString().trim();
		emplAM 		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(TXEMPLAMT_COLUMN,0,TAXES_CUR)).toString().trim();
 
 		maxAmt 		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(TXMAXAMNT_COLUMN,0,TAXES_CUR)).toString().trim();
 
		vendorId 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(TXPAYEID_COLUMN,0,TAXES_CUR)).toString().trim();; 
		vendorName	= (String)updateDBBean.valueAtColumnRowResult(TXPAYENM_COLUMN,0,TAXES_CUR).toString().trim(); 
		
 	    //debit account
		level1     = (String)updateDBBean.valueAtColumnRowResult(TXDBACCNT1_COLUMN,0,TAXES_CUR).toString().trim();
		level1	   = level1 + (String)updateDBBean.valueAtColumnRowResult(TXDBACCNT2_COLUMN,0,TAXES_CUR).toString().trim();
		level1	   = level1 + (String)updateDBBean.valueAtColumnRowResult(TXDBACCNT3_COLUMN,0,TAXES_CUR).toString().trim();
		level1	   = level1 + (String)updateDBBean.valueAtColumnRowResult(TXDBACCNT4_COLUMN,0,TAXES_CUR).toString().trim();
		level1	   = level1 + (String)updateDBBean.valueAtColumnRowResult(TXDBACCNT5_COLUMN,0,TAXES_CUR).toString().trim();						
		levelText1 = (String)updateDBBean.valueAtColumnRowResult(DBGLNM_COLUMN,0,TAXES_CUR).toString().trim();
		
		//credit account
		level2     = (String)updateDBBean.valueAtColumnRowResult(TXCRACCNT1_COLUMN,0,TAXES_CUR).toString().trim();
		level2	   = level2 + (String)updateDBBean.valueAtColumnRowResult(TXCRACCNT2_COLUMN,0,TAXES_CUR).toString().trim();
		level2	   = level2 + (String)updateDBBean.valueAtColumnRowResult(TXCRACCNT3_COLUMN,0,TAXES_CUR).toString().trim();
		level2	   = level2 + (String)updateDBBean.valueAtColumnRowResult(TXCRACCNT4_COLUMN,0,TAXES_CUR).toString().trim();
		level2	   = level2 + (String)updateDBBean.valueAtColumnRowResult(TXCRACCNT5_COLUMN,0,TAXES_CUR).toString().trim();								
		levelText2 = (String)updateDBBean.valueAtColumnRowResult(CRGLNM_COLUMN,0,TAXES_CUR).toString().trim();
		
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
 } 
 %>
<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/taxes/prtaxes.jsp">
<INPUT type="hidden" name="action" id="action" value="TAXUPD">
<INPUT type="hidden" name="Id" id="Id" value="<%=Id%>">
<INPUT type="hidden" name="returnEid" value="Y">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="4" class="tableheader">Actualizar Retencion de Ley</TD>
    </TR>   
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Nombre</TD>
      <TD width="75%" colspan="3"><input type="text" name="name" size="50" maxlength="50" value="<%=name%>"></TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Descripción</TD>
      <TD width="75%" colspan="3">      
      <textarea rows="2" cols="20" name="descrp"><%=descrp%></textarea>
      <SCRIPT>displaylimit("document.myForm.descrp",100)</SCRIPT>
      </TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Orden de Aplicacion</TD>
      <TD width="75%" colspan="3"><input type="text" name="taxOrd" size="2" maxlength="2" value="<%=taxOrd%>"></TD>
    </TR>        
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Tipo de Retencion</TD>
      <TD width="75%" colspan="3">
      <select size="1" name="taxType">
			<option value=""   <%=taxType.equals("")?"selected":""%>></option>
			<option value="SS" <%=taxType.equals("SS")?"selected":""%>>Seguro Social</option>
			<option value="IR" <%=taxType.equals("IR")?"selected":""%>>Impuesto Sobre la Renta</option>
			<option value="OT" <%=taxType.equals("OT")?"selected":""%>>Otros</option>
		</select></TD>
    </TR>     
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Calcuar Sobre</TD>
      <TD width="75%" colspan="3">
      <select size="1" name="calBSON" onchange="check_cal_base_on(this.form);">
			<option value="OR"   <%=calBSON.equals("OT")?"selected":""%>>Otro</option>
			<option value="PR" <%=calBSON.equals("PR")?"selected":""%>>Porcentaje</option>
			<option value="AM" <%=calBSON.equals("AM")?"selected":""%>>Monto Fijo</option>
		</select></TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label">Empleador (%)</TD>
      <TD><input type="text" name="compRT" size="5" maxlength="5" value="<%=compRT%>"></TD>
      <TD class="label">Empleado (%)</TD>
      <TD><input type="text" name="emplRT" size="5" maxlength="5" value="<%=emplRT%>"></TD>      
	</TR>    
    <TR class="pcrinfo">
      <TD class="label">Empleador (Monto)</TD>
      <TD><input type="text" name="compAM" size="10" maxlength="15" value="<%=compAM%>"></TD>
      <TD class="label">Empleado (Monto)</TD>
      <TD><input type="text" name="emplAM" size="10" maxlength="15" value="<%=emplAM%>"></TD>
	</TR>   	
    <TR class="pcrinfo1">
        <TD class="label">Monto Techo INSS</TD>
      	<TD><input type="text" name="maxAmt" size="10" maxlength="21" value="<%=maxAmt%>"></TD>    
    	<TD class="label"><SPAN class="textRed">*</SPAN>Pagar A</TD>
    	<TD>
            <INPUT type="hidden" name="vendorId" id="vendorId" value="<%=vendorId%>">
           	<INPUT type="text" size="30" maxlength="55" name="vendorName" id="vendorName" value="<%=vendorName%>" onchange='document.myForm.vendorId.value="";' onkeypress='if(isEnterPressed()) openEntDialog("VEN", "", "myForm", "vendorId", "vendorName", "<%= request.getContextPath() %>");' >
            <INPUT type="button" name="searchVendor" value=" v " onclick='openEntDialog("VEN", "", "myForm", "vendorId", "vendorName", "<%= request.getContextPath() %>");' > &nbsp;&nbsp;&nbsp;&nbsp;    
		</TD>            
	</TR>      	
    <TR class="pcrinfo"> 
        <TD class="label"><span class="textRed">*</span>Cuenta de Debito</TD>
      	<TD colspan="3">
            <INPUT type="hidden" name="level1" value="<%=level1%>"> 
			<INPUT size="40" name="levelText1" value="<%=Format.encodeHTML(levelText1)%>" type="text" onChange="myForm.level1.value='';" onkeypress='if(isEnterPressed()) openGLDialog("1", "", "A", "N", "<%= contextRoot %>");'>
           	<INPUT type="button" name="glButton" value=" v " onclick='openGLDialog("1", "", "A", "N", "<%= contextRoot %>");'>
          </TD>
    </TR>    	
    <TR class="pcrinfo1"> 
        <TD class="label"><span class="textRed">*</span>Cuenta de Credito</TD>
      	<TD colspan="3">
            <INPUT type="hidden" name="level2" value="<%=level2%>"> 
			<INPUT size="40" name="levelText2" value="<%=Format.encodeHTML(levelText2)%>" type="text" onChange="myForm.level2.value='';" onkeypress='if(isEnterPressed()) openGLDialog("2", "", "A", "N", "<%= contextRoot %>");'>
           	<INPUT type="button" name="glButton" value=" v " onclick='openGLDialog("2", "", "A", "N", "<%= contextRoot %>");'>
          </TD>
    </TR>        
<%
  updateDBBean.closeResultSet();
%>		
</TABLE>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="Save" value="<%=rb.getString("B00008")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/taxes/taxlist.jsp';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
