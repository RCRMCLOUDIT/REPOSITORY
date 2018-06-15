<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Actualizar Deduccion</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.name.focus()">
<%! 
 static final String title = "Actualizar Deduccion"; 
 
 static final int WAGES_CUR = 1;
 
 static final int PDNAME_COLUMN 	= 1;
 static final int PDDESC_COLUMN 	= 2;
 static final int PDINCOME_COLUMN 	= 3;
 static final int PDDEDUCT_COLUMN 	= 4;
 static final int PDFIXED_COLUMN 	= 5;
 static final int PDVARIABL_COLUMN 	= 6; 
 static final int PDDBACCNT1_COLUMN = 7;
 static final int PDDBACCNT2_COLUMN = 8;
 static final int PDDBACCNT3_COLUMN = 9;
 static final int PDDBACCNT4_COLUMN = 10;
 static final int PDDBACCNT5_COLUMN = 11;
 static final int PDCRACCNT1_COLUMN = 12;
 static final int PDCRACCNT2_COLUMN = 13;
 static final int PDCRACCNT3_COLUMN = 14;
 static final int PDCRACCNT4_COLUMN = 15;
 static final int PDCRACCNT5_COLUMN = 16;     
 static final int DBGLACCNM_COLUMN 	= 17;
 static final int CRGLACCNM_COLUMN 	= 18;                                             
 static final int PDPAYEID_COLUMN	= 19;
 static final int PDPAYTO_COLUMN	= 20; 
 static final int PDSTATUS_COLUMN	= 22; 
 static final int PDORDER_COLUMN	= 23; 
 static final int PDPERCENT_COLUMN	= 25; 
 static final int PDAMOUNT_COLUMN	= 26; 
 static final int PDDEDTYPE_COLUMN	= 27; 
%>

<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_charcounterJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/charcounter.js"></SCRIPT>

<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 ********************************************************************************/
 String Id	 		= request.getParameter("Id")==null?"":request.getParameter("Id");  
 String name 		= request.getParameter("name")==null?"":request.getParameter("name");
 String descrp 		= request.getParameter("descrp")==null?"":request.getParameter("descrp");
 String concType 	= request.getParameter("concType")==null?"":request.getParameter("concType");

 String level1     = request.getParameter("level1")==null?"":request.getParameter("level1");
 String levelText1 = request.getParameter("levelText1")==null?"":request.getParameter("levelText1");

 String level2     = request.getParameter("level2")==null?"":request.getParameter("level2");
 String levelText2 = request.getParameter("levelText2")==null?"":request.getParameter("levelText2");         

 String vendorId 	= request.getParameter("vendorId")==null?"":request.getParameter("vendorId");
 String vendorName 	= request.getParameter("vendorId")==null?"":request.getParameter("vendorName"); 
 String order	 	= request.getParameter("order")==null?"":request.getParameter("order"); 
 
 String percent		= request.getParameter("percent")==null?"":request.getParameter("percent");
 String amount		= request.getParameter("amount")==null?"":request.getParameter("amount"); 
 String dedType		= request.getParameter("dedType")==null?"O":request.getParameter("dedType");

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
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRINCDECTS('" + 
 					companyID + "',0," + Id + ",'','','','','','','','','','','','','','','','',0,'','','','1',0,'','','',0,0,'INCDEDEDT','',?,?)}"; 
 					 
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
String isFIXED 	= "";
String isVARIA	= "";
String isINCOME	= "";
String isDEDUCT	= "";
String status	= "";
 if (returnWithError.equals("N"))
 { 
	 try
	 {
		name 		= (String)updateDBBean.valueAtColumnRowResult(PDNAME_COLUMN,0,WAGES_CUR).toString().trim(); 
		descrp 		= (String)updateDBBean.valueAtColumnRowResult(PDDESC_COLUMN,0,WAGES_CUR).toString().trim(); 
		isFIXED		= (String)updateDBBean.valueAtColumnRowResult(PDFIXED_COLUMN,0,WAGES_CUR).toString().trim(); 
		isVARIA		= (String)updateDBBean.valueAtColumnRowResult(PDVARIABL_COLUMN,0,WAGES_CUR).toString().trim(); 
		
		if(isFIXED.equals("Y") && isVARIA.equals("N"))
			concType 	= "F";
		else if(isFIXED.equals("N") && isVARIA.equals("Y")) 
			concType 	= "V";
		else
			concType 	= "";	
			
 	    //debit account
		level1     = (String)updateDBBean.valueAtColumnRowResult(PDDBACCNT1_COLUMN,0,WAGES_CUR).toString().trim();
		level1	   = level1 + (String)updateDBBean.valueAtColumnRowResult(PDDBACCNT2_COLUMN,0,WAGES_CUR).toString().trim();
		level1	   = level1 + (String)updateDBBean.valueAtColumnRowResult(PDDBACCNT3_COLUMN,0,WAGES_CUR).toString().trim();
		level1	   = level1 + (String)updateDBBean.valueAtColumnRowResult(PDDBACCNT4_COLUMN,0,WAGES_CUR).toString().trim();
		level1	   = level1 + (String)updateDBBean.valueAtColumnRowResult(PDDBACCNT5_COLUMN,0,WAGES_CUR).toString().trim();						
		levelText1 = (String)updateDBBean.valueAtColumnRowResult(DBGLACCNM_COLUMN,0,WAGES_CUR).toString().trim();
		
		//credit account
		level2     = (String)updateDBBean.valueAtColumnRowResult(PDCRACCNT1_COLUMN,0,WAGES_CUR).toString().trim();
		level2	   = level2 + (String)updateDBBean.valueAtColumnRowResult(PDCRACCNT2_COLUMN,0,WAGES_CUR).toString().trim();
		level2	   = level2 + (String)updateDBBean.valueAtColumnRowResult(PDCRACCNT3_COLUMN,0,WAGES_CUR).toString().trim();
		level2	   = level2 + (String)updateDBBean.valueAtColumnRowResult(PDCRACCNT4_COLUMN,0,WAGES_CUR).toString().trim();
		level2	   = level2 + (String)updateDBBean.valueAtColumnRowResult(PDCRACCNT5_COLUMN,0,WAGES_CUR).toString().trim();	
		levelText2 = (String)updateDBBean.valueAtColumnRowResult(CRGLACCNM_COLUMN,0,WAGES_CUR).toString().trim();
		
		vendorId 	= (String)updateDBBean.valueAtColumnRowResult(PDPAYEID_COLUMN,0,WAGES_CUR).toString().trim();
		vendorName 	= (String)updateDBBean.valueAtColumnRowResult(PDPAYTO_COLUMN,0,WAGES_CUR).toString().trim();
		order	 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(PDORDER_COLUMN,0,WAGES_CUR)).toString().trim();

		isINCOME = (String)updateDBBean.valueAtColumnRowResult(PDINCOME_COLUMN,0,WAGES_CUR).toString().trim(); 
		isDEDUCT = (String)updateDBBean.valueAtColumnRowResult(PDDEDUCT_COLUMN,0,WAGES_CUR).toString().trim(); 
		status	 = (String)updateDBBean.valueAtColumnRowResult(PDSTATUS_COLUMN,0,WAGES_CUR).toString().trim();

 		percent		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(PDPERCENT_COLUMN,0,WAGES_CUR)).toString().trim();
		amount		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(PDAMOUNT_COLUMN,0,WAGES_CUR)).toString().trim(); 	
		
		dedType		= (String)updateDBBean.valueAtColumnRowResult(PDDEDTYPE_COLUMN,0,WAGES_CUR).toString().trim();	 
		
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
 } 
 %>


<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/deductions/princdects.jsp">
<INPUT type="hidden" name="action" id="action" value="INCDEDUPD">
<INPUT type="hidden" name="Id" id="Id" value="<%=Id%>">
<INPUT type="hidden" name="isIncome" id="isIncome" value="<%=isINCOME%>">
<INPUT type="hidden" name="isDeduction" id="isDeduction" value="<%=isDEDUCT%>">
<INPUT type="hidden" name="status" id="status" value="<%=status%>">
<INPUT type="hidden" name="returnEid" value="Y">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="4" class="tableheader">Actualizar Deduccion</TD>
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
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Fija/Variable</TD>
      <TD width="75%" colspan="3">
      	<input type="radio" name="concType" value="F" <%=concType.equals("F")?"checked":""%>>Fijo
      	<input type="radio" name="concType" value="V" <%=concType.equals("V")?"checked":""%>>Variable
      </TD>			
    </TR>
    <TR class="pcrinfo1">
      <TD class="label">Porcentaje</TD>
      <TD><input type="text" name="percent" size="5" maxlength="5" value="<%=percent%>"></TD>			
      <TD class="label">Monto</TD>
      <TD><input type="text" name="amount" size="10" maxlength="15" value="<%=amount%>"></TD>			      
    </TR>      
    <TR class="pcrinfo">
    	<TD class="label"><SPAN class="textRed">*</SPAN>Pagar A</TD>
    	<TD>
            <INPUT type="hidden" name="vendorId" id="vendorId" value="<%=vendorId%>">
           	<INPUT type="text" size="30" maxlength="55" name="vendorName" id="vendorName" value="<%=vendorName%>" onchange='document.myForm.vendorId.value="";' onkeypress='if(isEnterPressed()) openEntDialog("VEN", "", "myForm", "vendorId", "vendorName", "<%= request.getContextPath() %>");' >
            <INPUT type="button" name="searchVendor" value=" v " onclick='openEntDialog("VEN", "", "myForm", "vendorId", "vendorName", "<%= request.getContextPath() %>");' > &nbsp;&nbsp;&nbsp;&nbsp;    
		</TD>            
	</TR> 
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Orden de Aplicacion</TD>
      <TD width="75%" colspan="3"><input type="text" name="order" size="2" maxlength="2" value="<%=order%>"></TD>
    </TR>             
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Tipo de Deduccion</TD>
      <TD width="75%" colspan="3" class="label">
      	<input type="radio" name="dedType" value="I" <%=dedType.equals("I")?"checked":""%>>Prestamo Interno
      	<input type="radio" name="dedType" value="E" <%=dedType.equals("E")?"checked":""%>>Prestamo Terceros
      	<br>
				<input type="radio" name="dedType" value="D" <%=dedType.equals("D")?"checked":""%>>Deduccion Interna
      	<input type="radio" name="dedType" value="T" <%=dedType.equals("T")?"checked":""%>>Deduccion Terceros
      	<br>
				<input type="radio" name="dedType" value="O" <%=dedType.equals("O")?"checked":""%>>Otros
      </TD>			
    </TR>    
    <TR class="pcrinfo1"> 
        <TD class="label"><span class="textRed">*</span>Cuenta de Debito</TD>
      	<TD colspan="3">
            <INPUT type="hidden" name="level1" value="<%=level1%>"> 
			<INPUT size="40" name="levelText1" value="<%=Format.encodeHTML(levelText1)%>" type="text" onChange="myForm.level1.value='';" onkeypress='if(isEnterPressed()) openGLDialog("1", "", "A", "N", "<%= contextRoot %>");'>
           	<INPUT type="button" name="glButton" value=" v " onclick='openGLDialog("1", "", "A", "N", "<%= contextRoot %>");'>
          </TD>
    </TR>    	
    <TR class="pcrinfo"> 
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
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/deductions/deductionslist.jsp';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
