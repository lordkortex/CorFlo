/*
*       @AUTOR:         JOHN CORTES(IS)
*       @FECHA:         17 Diciembre 2017
*       @DESCRIPCION:   Test para Controlador para componente ProductoServicioOportunidad.
*
*/
@isTest(SeeAllData=false) 
public with sharing class AsignacionVenderdoresControllerTest {

	private static final String MARCAS = 'Ford';
	private static final String SUCURSAL = 'Tegucigalpa';

	public static testMethod void testAsignacionVenderdoresControllerTest(){

	 	AsignacionVenderdoresController controller = new  AsignacionVenderdoresController();

		Sucursal__c sucursal = new Sucursal__c(Name = SUCURSAL);
		insert sucursal;

		Vendedor__c vendedor = new Vendedor__c(	Sucursal__c = sucursal.Id,Marcas__c = MARCAS);
		insert vendedor;

		Vendedor_Asignaciones__c vendedorAsig = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor.Id);
		insert vendedorAsig;

		
		
		controller.fecha = Date.today();
		controller.sucursalInput ='';
		controller.vendedorInput ='';
		controller.marcaInput ='';
		controller.fechaInput ='';

	 

         test.startTest();
            
            PageReference pageRef = Page.AsignacionVenderdores;
        	Test.setCurrentPage(pageRef);
            //ApexPages.CurrentPage().getParameters().put('sucursal', sucursal.id);
            ApexPages.CurrentPage().getParameters().put('vendedor', vendedor.id);
            ApexPages.CurrentPage().getParameters().put('marca', 'BMW');
            ApexPages.CurrentPage().getParameters().put('fecha', DateTime.now().format('yyyy-MM-dd'));

            controller.getQuery();

        test.stopTest();
    }

     public static testMethod void testQueryWithoutParamsSucursalVendedor(){

	 	AsignacionVenderdoresController controller = new  AsignacionVenderdoresController();

		Sucursal__c sucursal = new Sucursal__c(Name = SUCURSAL);
		insert sucursal;

		Vendedor__c vendedor = new Vendedor__c(	Sucursal__c = sucursal.Id ,Marcas__c = MARCAS);
		insert vendedor;

		Vendedor_Asignaciones__c vendedorAsig = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor.Id);
		insert vendedorAsig;

		
		
		controller.fecha = Date.today();
		controller.sucursalInput ='';
		controller.vendedorInput ='';
		controller.marcaInput ='';
		controller.fechaInput ='';

	 

         test.startTest();
            
            PageReference pageRef = Page.AsignacionVenderdores;
        	Test.setCurrentPage(pageRef);
            //ApexPages.CurrentPage().getParameters().put('sucursal', sucursal.id);
            //ApexPages.CurrentPage().getParameters().put('vendedor', vendedor.id);
            ApexPages.CurrentPage().getParameters().put('marca', 'BMW');
            ApexPages.CurrentPage().getParameters().put('fecha', DateTime.now().format('yyyy-MM-dd'));

            controller.getQuery();

        test.stopTest();
    }

     public static testMethod void testQueryWithoutParamsSucursalVendedorFecha(){

	 	AsignacionVenderdoresController controller = new  AsignacionVenderdoresController();

		Sucursal__c sucursal = new Sucursal__c(Name = SUCURSAL);
		insert sucursal;

		Vendedor__c vendedor = new Vendedor__c(	Sucursal__c = sucursal.Id, Marcas__c = MARCAS);
		insert vendedor;

		Vendedor_Asignaciones__c vendedorAsig = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor.Id);
		insert vendedorAsig;

		
		
		controller.fecha = Date.today();
		controller.sucursalInput ='';
		controller.vendedorInput ='';
		controller.marcaInput ='';
		controller.fechaInput ='';

	 

         test.startTest();
            
            PageReference pageRef = Page.AsignacionVenderdores;
        	Test.setCurrentPage(pageRef);
            //ApexPages.CurrentPage().getParameters().put('sucursal', sucursal.id);
            //ApexPages.CurrentPage().getParameters().put('vendedor', vendedor.id);
            ApexPages.CurrentPage().getParameters().put('marca', 'BMW');
            //ApexPages.CurrentPage().getParameters().put('fecha', DateTime.now().format('yyyy-MM-dd'));

            controller.getQuery();

        test.stopTest();
    }


	 public static testMethod void testGuardarNuevaWithParams(){

	 	AsignacionVenderdoresController controller = new  AsignacionVenderdoresController();

		Sucursal__c sucursal = new Sucursal__c(Name = SUCURSAL);
		insert sucursal;

		Vendedor__c vendedor = new Vendedor__c(	Sucursal__c = sucursal.Id, Marcas__c = MARCAS);
		insert vendedor;

		Vendedor_Asignaciones__c vendedorAsig = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor.Id);
		insert vendedorAsig;

		
		
		controller.fecha = Date.today();
		controller.sucursalInput ='';
		controller.vendedorInput ='';
		controller.marcaInput ='';
		controller.fechaInput ='';

	 

         test.startTest();
            
            PageReference pageRef = Page.AsignacionVenderdores;
        	Test.setCurrentPage(pageRef);
            ApexPages.CurrentPage().getParameters().put('sucursal', sucursal.id);
            ApexPages.CurrentPage().getParameters().put('vendedor', vendedor.id);
            ApexPages.CurrentPage().getParameters().put('marca', 'BMW');
            ApexPages.CurrentPage().getParameters().put('fecha', DateTime.now().format('yyyy-MM-dd'));

            controller.buscar();
            controller.getSucursalList();
            controller.getVendedorList();
            controller.getMarcasList();
            controller.getListMantenimientoOportunidad();
            controller.getListMantenimientoOportunidadEdit();
            controller.getQuery();
            controller.agregarMantenimiento();
            controller.saveHistorico();
            controller.restarurarPagina();
            controller.cancelHistorico();
            controller.editarMantenimiento();
            controller.cancelarEdicion();
            controller.guardarCambios();
            controller.eliminarMantenimiento();
            controller.getSourceList();
            



            
        test.stopTest();
    }


     public static testMethod void testGuardarNuevaWitouhtParams(){

	 	AsignacionVenderdoresController controller = new  AsignacionVenderdoresController();

		Sucursal__c sucursal = new Sucursal__c(Name = SUCURSAL);
		insert sucursal;

		Vendedor__c vendedor = new Vendedor__c(	Sucursal__c = sucursal.Id, Marcas__c = MARCAS);
		insert vendedor;

		Vendedor_Asignaciones__c vendedorAsig = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor.Id);
		insert vendedorAsig;

		
		
		controller.fecha = Date.today();
		controller.sucursalInput ='';
		controller.vendedorInput ='';
		controller.marcaInput ='';
		controller.fechaInput ='';

	 

         test.startTest();
            
            PageReference pageRef = Page.AsignacionVenderdores;
        	Test.setCurrentPage(pageRef);

            controller.buscar();
            controller.getSucursalList();
            controller.getVendedorList();
            controller.getMarcasList();
            controller.getListMantenimientoOportunidad();
            controller.getListMantenimientoOportunidadEdit();
            controller.getQuery();
            controller.agregarMantenimiento();
            controller.saveHistorico();
            controller.restarurarPagina();
            controller.cancelHistorico();
            controller.editarMantenimiento();
            controller.cancelarEdicion();
            controller.guardarCambios();
            controller.eliminarMantenimiento();
            



            
        test.stopTest();
    }

   
}