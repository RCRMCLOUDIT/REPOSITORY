<%-- 
    Document   : Login
    Created on : 07-10-2017, 11:51:26 AM
    Author     : Moises Romero
--%>
<%@page import="java.text.DateFormat"%>
<%@page import="controller.ServletLogin" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'>
        <link rel="stylesheet" href="css/bootstrap.min.css">    
        <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css"> <!--Iconos--> 
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,400,500" rel="stylesheet">
        <link rel="stylesheet" href="css/login.css">        
        <title>Inicio Sesion</title>

    </head>
    <body>
    <Center>
        <div class="my-content">
            <div class="container" > 
                <div class="row">
                    <div>
                        <div>
                            <h1><strong>Infinity Business</strong></h1>
                            <div class="mydescription">
                                <p>Acceso al Sistema</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-6 col-sm-offset-3 myform-cont" >
                        <div class="myform-top">
                            <div>
                                <center>
                                    <h3>Ingreso al Sistema.</h3>
                                    <p>Digita tu usuario y contraseña:</p>
                                </center>
                            </div>
                            <div class="myform-top-right">
                                <i class="fa fa-key"></i>
                            </div>
                        </div>
                        <div class="myform-bottom">
                            <form role="form" action="ServletLogin" method="post" class="">
                                <div class="form-group">
                                    <input type="text" name="form-username" placeholder="Usuario..." class="form-control" id="form-username" style="text-align: center;" autocomplete="off">
                                </div>
                                <div class="form-group">
                                    <input type="password" name="form-password" placeholder="Contraseña..." class="form-control" id="form-password" style="text-align: center;" autocomplete="off">
                                </div>
                                <button type="submit" class="mybtn">Entrar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
