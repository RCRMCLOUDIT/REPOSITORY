
/***********************************************
 * lookup submit validation
 ************************************************/
function oid_lookup(form) 
{
	if (form.fDate.value != "" && !isValidDate(form.fDate))
	{
		form.fDate.focus(); 
		form.fDate.select();
		alert("Favor Introducir una Fecha Valida para Continuar");
		return false;
	} 
	if (form.tDate.value != "" && !isValidDate(form.tDate))
	{
		form.tDate.focus(); 
		form.tDate.select();
		alert("Favor Introducir una Fecha Valida para Continuar");
		return false;
	} 
    if (form.fDate.value != "" && form.tDate.value != "" && cmpDate(form.fDate, form.tDate) > 0)	
	{
		form.tDate.focus();
		form.tDate.select();
		alert("Fecha Hasta, no puede ser inferior.");
		return false;
	}

	//0= HTML, 1=PDF, 2=XLS, 3=GRAFICO
    if(form.reportType[0].checked == true)
    {
    		return true;
    }	
    else
	{
    	//PDF
    	if(form.reportType[1].checked == true)
		{
			var url = form.contextRoot.value + "/servlet/com.cap.erp.report.PayRollInfoPDF?action=RPTIDRPT&type=PDF&fDate=" + form.fDate.value + "&tDate=" + form.tDate.value + "&employeeTypeId=" + form.employeeTypeId.options[form.employeeTypeId.selectedIndex].value + "&conceptId=" + form.conceptId.options[form.conceptId.selectedIndex].value;
			
			openDialog(url, "Reporte de Ingresos/Deducciones", "760", "700", form.contextRoot.value);
		}
    	//GRAFICO
		else if(form.reportType[3].checked == true)
		{
			var url = form.contextRoot.value + "/servlet/com.cap.erp.report.PayRollInfoPDF?action=RPTIDCHR&type=CHR&fDate=" + form.fDate.value + "&tDate=" + form.tDate.value + "&employeeTypeId=" + form.employeeTypeId.options[form.employeeTypeId.selectedIndex].value + "&conceptId=" + form.conceptId.options[form.conceptId.selectedIndex].value;
			
			openDialog(url, "Reporte de Ingresos/Deducciones", "760", "700", form.contextRoot.value);
		}	
		else
		{
			var url = form.contextRoot.value + "/servlet/com.cap.erp.report.PayRollInfoPDF?action=RPTIDRPT&type=XLS&fDate=" + form.fDate.value + "&tDate=" + form.tDate.value + "&employeeTypeId=" + form.employeeTypeId.options[form.employeeTypeId.selectedIndex].value + "&conceptId=" + form.conceptId.options[form.conceptId.selectedIndex].value;
			
			openDialog(url, "Reporte de Ingresos/Deducciones", "760", "700", form.contextRoot.value);			
		}
		return false;
	}
}
