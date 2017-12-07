/*
*       @AUTOR:         JOHN CORTES(IS)
*       @FECHA:         27 de Noviembre de 2017
*       @DESCRIPCION:   Controlador para casignacion de vendedores.Esta clase queda comentada. Actualmentes
*       se usa la clase OpportunityAsignacionVendedorSinMarca la cual no tiene en cuenta la marca. Esta clase
*       sera usada en caso de que quieran cambiar el proceso de round robbin y deseen tener en cuenta la marca.
*
*/
@isTest(SeeAllData=false) 
private class OpportunityTriggerHandlerTest {


	private static final String MARCAS = 'Ford';
	private static final String SUCURSAL = 'Tegucigalpa';
	private static final String SOURCE  = 'Walk-In';
	
	public OpportunityTriggerHandlerTest() {

		
	}
	
	/*
	Este metodo se usa para hacer el test del metodo reasignarOportunidadVendedores
	 */
	@isTest static void testReasignarOportunidadVendedores() {


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

		Vendedor__c vendedor1 = new Vendedor__c(	Usuario__c =u1.Id,Sucursal__c = sucursal.Id,Marcas__c = MARCAS,Activo__c=true);
		insert vendedor1;

		Vendedor__c vendedor2 = new Vendedor__c(	Usuario__c =u2.Id,Sucursal__c = sucursal.Id,Marcas__c = MARCAS,Activo__c=true);
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



		Test.startTest();
			OpportunityService.reasignarOportunidadVendedores(oppList);


			oppList = new List<Opportunity>();
			for(Opportunity oppItem : [Select id,name From Opportunity ]){
				oppItem.OwnerId = u2.Id;
				oppItem.LeadSource = SOURCE;
				oppItem.Sucursal__c = sucursal.Id;
				oppList.add(oppItem);
			}
			update oppList;
			OpportunityService.reasignarOportunidadVendedores(oppList);

			Delete[select id From  Opportunity];
			OpportunityService.reasignarOportunidadVendedores(oppList);
		Test.stopTest();


	}
	
}