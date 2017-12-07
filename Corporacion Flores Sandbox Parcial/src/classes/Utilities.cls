/**
 * Using without sharing as need to run query on Organization table
 */
public without sharing class Utilities {

    //Get instance from INSTANCE.visual.force.com page so we can build
    public Static String getInstance(){
        String instance = '';
        Organization o = [SELECT OrganizationType, InstanceName FROM Organization limit 1];
        String orgType = o.OrganizationType;
        String insName = o.InstanceName;
        if(orgType == 'Developer Edition' || insName.startsWithIgnoreCase('cs')){
            List<String> parts = ApexPages.currentPage().getHeaders().get('Host').split('\\.');
            instance = parts[parts.size() - 4] + '.';
        }
        return instance;
    }
    //Needed in cases if current org is sandbox
    public static String getSubdomainPrefix(){
        Organization o = [SELECT OrganizationType, InstanceName FROM Organization limit 1];
        String orgType = o.OrganizationType;
        String insName = o.InstanceName;
        if(insName.startsWithIgnoreCase('cs')){
            return UserInfo.getUserName().substringAfterLast('.')+ '-';
        }
        return '';
    }
    
    //Search for Accounts
    public static list<Account> getAccounts(String identificacion){
        list<Account> listClienteBusqueda = new list<Account>();
        try{
            
            listClienteBusqueda = [Select Name 
                                   From Account 
                                   Where Name Like : '%'+identificacion+'%'
                                   Limit 15]; 
            
            if(listClienteBusqueda.isEmpty()){
            	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, '!No se encontraron coincidencias!'));    
            }
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, '!Ha sucedio un error!'));
            system.debug('RutaController - buscarCliente: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }
        return listClienteBusqueda;
    }
}