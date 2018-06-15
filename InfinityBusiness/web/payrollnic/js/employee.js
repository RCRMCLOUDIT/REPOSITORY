/*****************************************************
 Function to open popup window, only used in header page
 *****************************************************/
function receipt_search(form, code, contextRoot)
{
	timed_openEntDialog("EMP", "A", "myForm", "employeeId", "employeeName", contextRoot);
}


/***************************************************
* Language:   	JavaScript
* Function :   	formatCEDID(object)
* Description: 	Adds Dashes to Identification
* Input:        CED obj
* Output:  	formated CEDID
* NOTE:    	call function using onKeyPress AND onKeyUp
 ****************************************************/
function formatCEDID(object)
{
      checking = setInterval("formatCEDID(object);",1);
      sin = object.value;
      if ((sin.length == 3) || (sin.length == 10))
      {
        object.value = sin + "-";
      }
      clearInterval(checking);
}

/*
FUNCTION TO ENABLE FIELDS BANK AND ACCOUNT NUMBER
ONLY IF PAYMENT METHOD IS DEBIT CARD
*/
/*function payment_method(form)
{
	if(form.paymentMethod.value == "DC")
	{
		form.bank.disabled 			= false;
		form.accountNum.disabled	= false;
	}
	else
	{
		form.bank.disabled 			= true;
		form.accountNum.disabled	= true;
	}
	return true;
}*/

/*****************************************************
 Function to return Years Calculation
 *****************************************************/
 function calculate_years(fecha,form)
 {
    //calculo la fecha de hoy
   // hoy=new Date(myForm.cDate.value.substring(6,10),myForm.cDate.value.substring(0,2)-1,myForm.cDate.value.substring(3,5));
	 hoy=new Date();
    //alert(hoy);
    //alert("Cambio");
    //calculo la fecha que recibo
    //La descompongo en un array
    var array_fecha = fecha.split("/");

    //si el array no tiene tres partes, la fecha es incorrecta
    if (array_fecha.length!=3)
    {
    	alert("Por Favor verificar Fecha en Formato MM/DD/YYYY");
		return false;
	}
    //compruebo que los ano, mes, dia son correctos
    var ano;
    ano = parseInt(array_fecha[2]);
    if (isNaN(ano))
    {
    	alert("Por Favor verificar Fecha en Formato MM/DD/YYYY");
		return false;
	}

    var mes;
    mes = parseInt(array_fecha[0]);
    if(mes == 0)
    	 mes = parseInt(array_fecha[0],10);

    if (isNaN(mes))
    {
    	alert("Por Favor verificar Fecha en Formato MM/DD/YYYY");
   		return false;
	}

    var dia;
    dia = parseInt(array_fecha[1]);
    if(dia == 0)
    	 dia = parseInt(array_fecha[1],10);

    if (isNaN(dia))
    {
    	alert("Por Favor verificar Fecha en Formato MM/DD/YYYY");
   		return false;
    }

    //alert(ano);
    //si el año de la fecha que recibo solo tiene 2 cifras hay que cambiarlo a 4
     if (ano<=99)
       ano +=1900;

     //alert(hoy.getFullYear());
    //resto los años de las dos fechas
    edad=hoy.getFullYear()- ano - 1; //-1 porque no se si ha cumplido años ya este año
    //alert(edad);
    //si resto los meses y me da menor que 0 entonces no ha cumplido años. Si da mayor si ha cumplido
    if (hoy.getMonth() + 1 - mes < 0) //+ 1 porque los meses empiezan en 0
    {
       form.value = edad;
       return true;
    }
    if (hoy.getMonth() + 1 - mes > 0)
    {
       form.value = edad+1;
       return true;
    }

    //entonces es que eran iguales. miro los dias
    //si resto los dias y me da menor que 0 entonces no ha cumplido años. Si da mayor o igual si ha cumplido

    if (hoy.getUTCDate() - dia >= 0)
    {
    	form.value = edad + 1;
    	return true;
    }

    form.value =  edad;

    if(form.value == -1)
    	form.value = 0;

    return true;
}

/*****************************************************
 Function to Validate Employee Data
 *****************************************************/
function add_upd_empl(form)
{
	if(form.action.value == 'EMPLOYADD')
	{
		if(form.employeeId.value == "" || form.employeeId.value == "0")
		{
			form.employeeName.focus();
			form.employeeName.select();
			alert("Por Favor seleccionar un Empleado para continuar.");
			return false;
		}
    }

    if(trim(form.employeeNum.value) == "")
	{
		form.employeeNum.focus();
		form.employeeNum.select();
		alert("Por Favor ingrese Numero de Empleado para continuar.");
		return false;
	}

    if(trim(form.extId.value) == "")
	{
		form.extId.focus();
		form.extId.select();
		alert("Por Favor ingrese Numero INSS para continuar.");
		return false;
	}

    if(trim(form.federalId.value) == "")
	{
		form.federalId.focus();
		form.federalId.select();
		alert("Por Favor ingrese Numero Cedula para continuar.");
		return false;
	}

	if (form.employeeTypeId.selectedIndex == 0)
	{
		form.employeeTypeId.focus();
		alert("Por Favor seleccione Tipo de Empleado para continuar.");
     	return false;
    }

	if (form.jobProfId.selectedIndex == 0)
	{
		form.jobProfId.focus();
		alert("Por Favor seleccione Cargo para continuar.");
     	return false;
    }

    if ((form.birthDate.value.length == 0) || (!isValidDate(form.birthDate)))
    {
    	form.birthDate.focus();
    	form.birthDate.select();
    	alert("Por Favor digite Fecha de Nacimiento valida para continuar.");
    	return false;
    }

    if ((form.intDate.value.length == 0) || (!isValidDate(form.intDate)))
    {
    	form.intDate.focus();
    	form.intDate.select();
    	alert("Por Favor digite Fecha de Inicio valida para continuar.");
    	return false;
    }

    if(trim(form.emplSal.value) == "" || form.emplSal.value == "0")
	{
		form.emplSal.focus();
		form.emplSal.select();
		alert("Por Favor ingrese Salario de Empleado para continuar.");
		return false;
	}

    return true;
}

/***********************************************
 * lookup submit validation
 ************************************************/
function moper_lookup(form)
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

	//0= Html, 1=Excel, 2=PDF
    if(form.reportType[0].checked == true)
    {
    	return true;
    }
    else
	{
		if(form.reportType[1].checked == true)
		{
			var url = form.contextRoot.value + "/servlet/com.cap.erp.report.PayRollInfoPDF?action=EMPLMPBDT&type=PDF&fDate=" + form.fDate.value + "&tDate=" + form.tDate.value + "&employeeTypeId=" + form.employeeTypeId.options[form.employeeTypeId.selectedIndex].value;

			openDialog(url, "Reporte Movimientos Operativos de Colaboradores", "760", "700", form.contextRoot.value);
		}
		else
		{
			var url = form.contextRoot.value + "/servlet/com.cap.erp.report.PayRollInfoPDF?action=EMPLMPBDT&type=XLS&fDate=" + form.fDate.value + "&tDate=" + form.tDate.value + "&employeeTypeId=" + form.employeeTypeId.options[form.employeeTypeId.selectedIndex].value;

			openDialog(url, "Reporte Movimientos Operativos de Colaboradores", "760", "700", form.contextRoot.value);
		}
		return false;
	}
}

/********************************************
 * check if page changed before go to next page
 ********************************************/
function prodrev_link_chg(link)
{
	window.location=link;
}

/*****************************************************
 Function to open popup window
 *****************************************************/
function change_tab(e,contextPath)
{
    var key;

     if(window.event)
          key = window.event.keyCode;     //IE
     else
          key = e.which;     //firefox

   	if(key == 113)//F2
		prodrev_link_chg(contextPath + "/erp/payrollnic/employee/employeelistactive.jsp");
	else if(key == 115)//F4
		prodrev_link_chg(contextPath + "/erp/payrollnic/employee/employeelistinactive.jsp");
	else if(key == 117)//F6
		prodrev_link_chg(contextPath + "/erp/payrollnic/employee/employeelist.jsp");
 	return true;
}
