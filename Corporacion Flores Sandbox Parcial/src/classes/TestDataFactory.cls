public class TestDataFactory {
	
    public static Map<String,RecordType> MapRecordType = new  Map<String,RecordType>();
    public static Map<String,String> MapEtapasIds = new  Map<String,String>();
    public static Map<Integer, PricebookEntry> MapPriceEntries;
    public static Map<Integer, Product2> MapProducts;
    public static Map<Integer, Account> MapCuentas;
    public static Map<Integer, Opportunity> MapOportunidades;
    public static Map<Integer, OpportunityLineItem> MapOpItems;
    //public static Map<Integer, ReciboUsado__c> MapReciboUsados;
	public static Sucursal__c sucursal;
	public static Campaign campanna;   


	private static final String SUCURSAL_TEGUCIGALPA = 'Tegucigalpa'; 


	public static void crearOportunidades(Integer iTotReg, String stageName, String source) {
        list<Opportunity> listOps = new list<Opportunity>();
        MapOportunidades = new Map<Integer, Opportunity>();


        Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        String stage;    
        for( Schema.PicklistEntry f : ple){
            stage = f.getValue();
        }       


        
        for (Integer x=0;x<iTotReg;x++){
            Opportunity op = new Opportunity(
            	Name = 'Oportunidad' + String.valueOf(x),
                AccountId = MapCuentas.get(x).Id,
                CloseDate = System.today().AddMonths(3),
                //StageName = MapEtapasIds.get(stageName),
				Sucursal__c = sucursal.Id,
                StageName = stage,
				LeadSource = source
            );
            
            listOps.add(op);
            MapOportunidades.put(x, op);
        }
        
        if(MapOportunidades.size()>0) insert MapOportunidades.values();
    }
    
    
    public static void datosGenerales() {
        //Seleccionar tipos de registros.
		for (RecordType r: [Select Id,DeveloperName,SObjectType From RecordType]) {
			if (!MapRecordType.containsKey(r.SObjectType+'-'+r.DeveloperName)) {MapRecordType.put(r.SObjectType+'-'+r.DeveloperName,r);}			
		}
        
        //Seleccionar etapas.
		for (OpportunityStage s:[Select o.MasterLabel,o.Id From OpportunityStage o Where IsActive = true order by o.SortOrder]) {
            if (!MapEtapasIds.containsKey(s.MasterLabel)) {MapEtapasIds.put(s.MasterLabel,s.Id);}
        }
        
		//Crear sucursales.
		sucursal = new Sucursal__c(	Name = SUCURSAL_TEGUCIGALPA);
		insert sucursal;        
		
		//Crear campaña.
		campanna = new Campaign (Name='Campaign');
		insert campanna;
    }


     public static void crearCuentas(Integer iTotReg) {
        list<Account> listAccs = new list<Account>();
        MapCuentas = new Map<Integer, Account>();
        
        for (Integer x=0;x<iTotReg;x++){
            
            Account a = new Account
            (
            	RecordTypeId = MapRecordType.get('Account-PersonAccount').Id,
                FirstName = 'Test2',
                LastName	=	'test2'
            );
            
            listAccs.add(a);
            MapCuentas.put(x, a);
        }
        
        if(MapCuentas.size()>0) insert MapCuentas.values();
    }
    
    
    
}