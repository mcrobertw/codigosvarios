<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Sistema de inventario</title>
	<script language="javascript">
		function inventarioProductos(){
			var limiteProductosInventario=2;
			var menu="***MENÚ DE OPCIONES***\n"+
						"(1) Ingresar mercadería [Producto, cantidad, precio de costo]\n"+
						"(2) Facturar producto\n"+
						"(3) Mostrar sus datos personales\n"+
						"(4) Salir [Escriba la palabra \"salir\"]\n"+
						"Ingrese opción... ";
			do {
				opcion= prompt(menu);
				switch (opcion) {
					case "1"://Ingreso de mercadería
							var arrayMercaderia =new Array(10);
							for (let i=0;i<limiteProductosInventario;i++)
							{
								nombreProducto=prompt("Ingrese nombre de producto: "+(i+1));
								cantidadProducto=prompt("Ingrese cantidad de producto: "+(i+1));
								precioCostoProducto=prompt("Ingrese precio de costo de producto: "+(i+1));
								precioVentaProducto=precioCostoProducto*1.10;
								arrayMercaderia[i]=new Array(4);
								arrayMercaderia[i][0]=nombreProducto;
								arrayMercaderia[i][1]=cantidadProducto;
								arrayMercaderia[i][2]=precioCostoProducto;
								arrayMercaderia[i][3]=precioVentaProducto;
							}
							var mensaje="***PRODUCTOS EN INVENTARIO***\n";
							for (let i=0;i<limiteProductosInventario;i++)
							{
								mensaje=mensaje+"Nombre del Producto: "+ arrayMercaderia[i][0]+"   "
											   +"Cantidad del Producto: "+ arrayMercaderia[i][1]+"   "
											   +"Precio de costo del Producto: "+ arrayMercaderia[i][2]+"   "
											   +"Precio de Venta del Producto: "+ arrayMercaderia[i][3]+"\n";
							}
							alert(mensaje);
							break;
					case "2"://Facturar un producto
							var nombreCliente=prompt("Ingrese nombre del cliente: ");
							var cantidadProductosComprados=0;
							var precioProducto=0;
							var subtotal=0;
							var descuento=0;
							var iva=0.12;
							var subtotalydescuento=0;
							var arrayProductosFacturados = new Array();
							do{
								nombreProducto=prompt("Ingrese nombre de producto  [\"0\" para salir] ");
								if(parseInt(nombreProducto)==0)
								{
									break;
								}
								cantidadProductosComprados+=1;
								var banderaExistencia=false;
								for (let i=0;i<limiteProductosInventario;i++)
								{
									if(arrayMercaderia[i][0]==nombreProducto)
									{
										banderaExistencia=true;
										precioProducto=arrayMercaderia[i][3];
									}
								}
								if(banderaExistencia)
								{
									cantidadItem=prompt("Ingrese cantidad de producto: ");
									totalItem=cantidadItem*precioProducto;
									arrayProductosFacturados[cantidadProductosComprados-1]=new Array(3);
									arrayProductosFacturados[cantidadProductosComprados-1][0]=nombreProducto;
									arrayProductosFacturados[cantidadProductosComprados-1][1]=precioProducto;
									arrayProductosFacturados[cantidadProductosComprados-1][2]=cantidadItem;
									arrayProductosFacturados[cantidadProductosComprados-1][3]=totalItem;
								}
								else {
									cantidadProductosComprados-=1;
									alert("El producto no existe en inventario... elija otro");
								}
							}while(1);
							var totalFactura=0;
							var mensaje="***PRODUCTOS FACTURADOS***";
							for (let i=0;i<cantidadProductosComprados;i++)
							{	
								mensaje+="\nProducto: "+arrayProductosFacturados[i][0]+ "    "
										+"Precio: "+arrayProductosFacturados[i][1]+ "    "
										+"Cantidad: "+arrayProductosFacturados[i][2]+ "    "
										+"Valor: "+arrayProductosFacturados[i][3];
								subtotal+=arrayProductosFacturados[i][3];
							}
							if(subtotal>=100)
								descuento=subtotal*0.05;
							subtotalydescuento=subtotal-descuento;
							iva=subtotalydescuento*0.12;
							totalFactura=subtotalydescuento+iva;
							mensaje+="\n Subtotal: "+subtotal+ "   "
									+"Descuento: "+descuento+"   "
									+"Subtotal (con o sin descuento): "+subtotalydescuento+"   "
									+"IVA: "+iva+"   "
									+"Total factura: "+totalFactura;
							alert(mensaje);
							break;
					case "3"://alert("Mostrar sus datos personales");
							var mensaje="Nombres: Robert Wilfrido Moreira Centeno \n"
										+ "Mes favorito del año: Junio \n"
										+ "Escriba \"salir\" para regresar al menú principal \n";
							do{
								eleccion= prompt(mensaje);
							}while(eleccion !='salir')

				}
				} while (opcion !='salir');
			document.writeln("***Gracias por usar la aplicación***");
		}
	</script>
</head>
<body onload="inventarioProductos()">
	<div id="mostrardiv"></div>
<body>
</html>