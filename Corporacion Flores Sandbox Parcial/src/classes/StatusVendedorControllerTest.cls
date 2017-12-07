@isTest(SeeAllData=false) 
public class StatusVendedorControllerTest
{

	private static final String MARCAS = 'Ford';
	private static final String SUCURSAL = 'Tegucigalpa';
	private static final String SOURCE  = 'Walk-In';


	private static testmethod void testUserActivo() {
    

     	OpportunityService opportuniyService = new OpportunityService();

		TestDataFactory.datosGenerales();
		TestDataFactory.crearCuentas(10);
		TestDataFactory.crearOportunidades(10,'Prospecting',SOURCE);

		Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        User u1 = new User(Alias = 'aStBCR16', Email='auseStadBCRInte111016@testorg.com',
            EmailEncodingKey='UTF-8', LastName='auseStadBCRInte111016', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='auseStadBCRInte111016@testorg.com');
        insert u1;

        User u2 = new User(Alias = 'sStBCR16', Email='aaseStadBCRInte111016@testorg.com',
            EmailEncodingKey='UTF-8', LastName='saaeStadBCRInte111016', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='buseStadBCRInte111016@testorg.com');
        insert u2;


        Sucursal__c sucursal = new Sucursal__c(Name= 'Tegucigalpa');
		insert sucursal;

		Vendedor__c vendedor1 = new Vendedor__c(	Usuario__c =u1.Id,Sucursal__c = sucursal.Id,Marcas__c = MARCAS,Activo__c = true);
		insert vendedor1;

		Vendedor__c vendedor2 = new Vendedor__c(	Usuario__c =u2.Id,Sucursal__c = sucursal.Id,Marcas__c = MARCAS,Activo__c = true);
		insert vendedor2;

		Vendedor_Asignaciones__c vendedorAsig1 = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor1.Id,Source__c = SOURCE);
		insert vendedorAsig1;

		Vendedor_Asignaciones__c vendedorAsig2 = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor2.Id,Source__c = SOURCE);
		insert vendedorAsig2;

		List<Opportunity> oppList = new List<Opportunity>();
		Boolean isFirst = true;
		for(Opportunity oppItem : [Select id,name From Opportunity ]){
			oppItem.OwnerId = u2.Id;
			if(isFirst){
				isFirst =false;
				oppItem.OwnerId = u1.Id;
			}
			oppItem.LeadSource = SOURCE;
			oppItem.Sucursal__c = sucursal.Id;
			
			oppList.add(oppItem);
		}
		update oppList;


		Schema.DescribeFieldResult fieldResult = Salto_Turno_Oportunidad__c.Razon__c.getDescribe();
   		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    	String razon;    
	    for( Schema.PicklistEntry f : ple){
	   		razon = f.getValue();
	   	}       

	    

	    Salto_Turno_Oportunidad__c saltoOportunidad = new Salto_Turno_Oportunidad__c();
        saltoOportunidad.Opportunity__c = oppList.get(0).Id;
        saltoOportunidad.User__c = u1.Id;
        saltoOportunidad.Razon__c = razon;
        insert saltoOportunidad;


        System.runAs(u1) {


			PageReference pageRef = Page.AsignacionVendedoresSalto;
			Test.setCurrentPage(pageRef);

		    pageRef.getParameters().put('opportunityId', oppList.get(0).Id);
		    pageRef.getParameters().put('userId', u1.Id);

		    ApexPages.StandardController sc = new ApexPages.StandardController(saltoOportunidad);
		    StatusVendedorController testAccPlan = new StatusVendedorController(sc);
		    
		    testAccPlan.activar();
		    testAccPlan.desactivar();

        }



    }


    private static testmethod void testUserInactivo() {
    

     	OpportunityService opportuniyService = new OpportunityService();

		TestDataFactory.datosGenerales();
		TestDataFactory.crearCuentas(10);
		TestDataFactory.crearOportunidades(10,'Prospecting',SOURCE);

		Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        User u1 = new User(Alias = 'aStBCR16', Email='auseStadBCRInte111016@testorg.com',
            EmailEncodingKey='UTF-8', LastName='auseStadBCRInte111016', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='auseStadBCRInte111016@testorg.com');
        insert u1;

        User u2 = new User(Alias = 'sStBCR16', Email='aaseStadBCRInte111016@testorg.com',
            EmailEncodingKey='UTF-8', LastName='saaeStadBCRInte111016', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='buseStadBCRInte111016@testorg.com');
        insert u2;


        Sucursal__c sucursal = new Sucursal__c(Name= 'Tegucigalpa');
		insert sucursal;

		Vendedor__c vendedor1 = new Vendedor__c(	Usuario__c =u1.Id,Sucursal__c = sucursal.Id,Marcas__c = MARCAS,Activo__c = false);
		insert vendedor1;

		Vendedor__c vendedor2 = new Vendedor__c(	Usuario__c =u2.Id,Sucursal__c = sucursal.Id,Marcas__c = MARCAS,Activo__c = false);
		insert vendedor2;

		Vendedor_Asignaciones__c vendedorAsig1 = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor1.Id,Source__c = SOURCE);
		insert vendedorAsig1;

		Vendedor_Asignaciones__c vendedorAsig2 = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor2.Id,Source__c = SOURCE);
		insert vendedorAsig2;

		List<Opportunity> oppList = new List<Opportunity>();
		Boolean isFirst = true;
		for(Opportunity oppItem : [Select id,name From Opportunity ]){
			oppItem.OwnerId = u2.Id;
			if(isFirst){
				isFirst =false;
				oppItem.OwnerId = u1.Id;
			}
			oppItem.LeadSource = SOURCE;
			oppItem.Sucursal__c = sucursal.Id;
			
			oppList.add(oppItem);
		}
		update oppList;


		Schema.DescribeFieldResult fieldResult = Salto_Turno_Oportunidad__c.Razon__c.getDescribe();
   		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    	String razon;    
	    for( Schema.PicklistEntry f : ple){
	   		razon = f.getValue();
	   	}       

	    

	    Salto_Turno_Oportunidad__c saltoOportunidad = new Salto_Turno_Oportunidad__c();
        saltoOportunidad.Opportunity__c = oppList.get(0).Id;
        saltoOportunidad.User__c = u1.Id;
        saltoOportunidad.Razon__c = razon;
        insert saltoOportunidad;


		System.runAs(u1) {
			PageReference pageRef = Page.AsignacionVendedoresSalto;
			Test.setCurrentPage(pageRef);

		    pageRef.getParameters().put('opportunityId', oppList.get(0).Id);
		    pageRef.getParameters().put('userId', u1.Id);

		    ApexPages.StandardController sc = new ApexPages.StandardController(saltoOportunidad);
		    StatusVendedorController testAccPlan = new StatusVendedorController(sc);
		    
		    testAccPlan.activar();
		    testAccPlan.desactivar();	
		    testAccPlan.getActivo();	
		    testAccPlan.getMostrarDatos();	
		}


		

    }

     private static testmethod void testIngresarSaltoSinCampoRazon() {
    

     	OpportunityService opportuniyService = new OpportunityService();

		TestDataFactory.datosGenerales();
		TestDataFactory.crearCuentas(10);
		TestDataFactory.crearOportunidades(10,'Prospecting',SOURCE);

		Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        User u1 = new User(Alias = 'aStBCR16', Email='auseStadBCRInte111016@testorg.com',
            EmailEncodingKey='UTF-8', LastName='auseStadBCRInte111016', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='auseStadBCRInte111016@testorg.com');
        insert u1;

        User u2 = new User(Alias = 'sStBCR16', Email='aaseStadBCRInte111016@testorg.com',
            EmailEncodingKey='UTF-8', LastName='saaeStadBCRInte111016', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='buseStadBCRInte111016@testorg.com');
        insert u2;


        Sucursal__c sucursal = new Sucursal__c(Name= 'Tegucigalpa');
		insert sucursal;

		Vendedor__c vendedor1 = new Vendedor__c(	Usuario__c =u1.Id,Sucursal__c = sucursal.Id,Marcas__c = MARCAS,Activo__c = false);
		insert vendedor1;

		Vendedor__c vendedor2 = new Vendedor__c(	Usuario__c =u2.Id,Sucursal__c = sucursal.Id,Marcas__c = MARCAS,Activo__c = false);
		insert vendedor2;

		Vendedor_Asignaciones__c vendedorAsig1 = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor1.Id,Source__c = SOURCE);
		insert vendedorAsig1;

		Vendedor_Asignaciones__c vendedorAsig2 = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor2.Id,Source__c = SOURCE);
		insert vendedorAsig2;

		List<Opportunity> oppList = new List<Opportunity>();
		Boolean isFirst = true;
		for(Opportunity oppItem : [Select id,name From Opportunity ]){
			oppItem.OwnerId = u2.Id;
			if(isFirst){
				isFirst =false;
				oppItem.OwnerId = u1.Id;
			}
			oppItem.LeadSource = SOURCE;
			oppItem.Sucursal__c = sucursal.Id;
			
			oppList.add(oppItem);
		}
		update oppList;


		

	    Salto_Turno_Oportunidad__c saltoOportunidad = new Salto_Turno_Oportunidad__c();
        saltoOportunidad.Opportunity__c = oppList.get(0).Id;
        saltoOportunidad.User__c = u1.Id;
        insert saltoOportunidad;


		System.runAs(u1) {
			PageReference pageRef = Page.AsignacionVendedoresSalto;
			Test.setCurrentPage(pageRef);

		    pageRef.getParameters().put('opportunityId', oppList.get(0).Id);
		    pageRef.getParameters().put('userId', u1.Id);

		    ApexPages.StandardController sc = new ApexPages.StandardController(saltoOportunidad);
		    StatusVendedorController testAccPlan = new StatusVendedorController(sc);
		    
		    testAccPlan.activar();
		    testAccPlan.desactivar();	
		    testAccPlan.getActivo();	
		    testAccPlan.getMostrarDatos();	
		}

    }




    private static testmethod void testUserInexistente() {
    

     	OpportunityService opportuniyService = new OpportunityService();

		TestDataFactory.datosGenerales();
		TestDataFactory.crearCuentas(10);
		TestDataFactory.crearOportunidades(10,'Prospecting',SOURCE);

		Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        User u1 = new User(Alias = 'aStBCR16', Email='auseStadBCRInte111016@testorg.com',
            EmailEncodingKey='UTF-8', LastName='auseStadBCRInte111016', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='auseStadBCRInte111016@testorg.com');
        insert u1;

        User u2 = new User(Alias = 'sStBCR16', Email='aaseStadBCRInte111016@testorg.com',
            EmailEncodingKey='UTF-8', LastName='saaeStadBCRInte111016', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='buseStadBCRInte111016@testorg.com');
        insert u2;


        Sucursal__c sucursal = new Sucursal__c(Name= 'Tegucigalpa');
		insert sucursal;

		Vendedor__c vendedor1 = new Vendedor__c(Sucursal__c = sucursal.Id,Marcas__c = MARCAS,Activo__c = false);
		insert vendedor1;

		Vendedor__c vendedor2 = new Vendedor__c(Sucursal__c = sucursal.Id,Marcas__c = MARCAS,Activo__c = false);
		insert vendedor2;

		Vendedor_Asignaciones__c vendedorAsig1 = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor1.Id,Source__c = SOURCE);
		insert vendedorAsig1;

		Vendedor_Asignaciones__c vendedorAsig2 = new Vendedor_Asignaciones__c(Activo__c=true,Fecha_Asignacion__c=Date.today(),Vendedor__c = vendedor2.Id,Source__c = SOURCE);
		insert vendedorAsig2;

		List<Opportunity> oppList = new List<Opportunity>();
		Boolean isFirst = true;
		for(Opportunity oppItem : [Select id,name From Opportunity ]){
			oppItem.OwnerId = u2.Id;
			if(isFirst){
				isFirst =false;
				oppItem.OwnerId = u1.Id;
			}
			oppItem.LeadSource = SOURCE;
			oppItem.Sucursal__c = sucursal.Id;
			
			oppList.add(oppItem);
		}
		update oppList;


		Schema.DescribeFieldResult fieldResult = Salto_Turno_Oportunidad__c.Razon__c.getDescribe();
   		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    	String razon;    
	    for( Schema.PicklistEntry f : ple){
	   		razon = f.getValue();
	   	}       

	    

	    Salto_Turno_Oportunidad__c saltoOportunidad = new Salto_Turno_Oportunidad__c();
        saltoOportunidad.Opportunity__c = oppList.get(0).Id;
        saltoOportunidad.User__c = u1.Id;
        saltoOportunidad.Razon__c = razon;
        insert saltoOportunidad;


		System.runAs(u1) {
			PageReference pageRef = Page.AsignacionVendedoresSalto;
			Test.setCurrentPage(pageRef);

		    pageRef.getParameters().put('opportunityId', oppList.get(0).Id);
		    pageRef.getParameters().put('userId', u1.Id);

		    ApexPages.StandardController sc = new ApexPages.StandardController(saltoOportunidad);
		    StatusVendedorController testAccPlan = new StatusVendedorController(sc);
		    
		    testAccPlan.activar();
		    testAccPlan.desactivar();	
		}

    }


}