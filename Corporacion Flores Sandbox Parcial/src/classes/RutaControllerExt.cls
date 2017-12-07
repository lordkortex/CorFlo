public class RutaControllerExt {
    public Ruta__c ruta{get;set;}
    public list<Cliente> listClientesRuta{get;set;}
    
    // Búsqueda de clientes para la ruta
    public boolean popBuscarCliente{get;set;}
    public string filtroIdentificacion{get;set;}
    public list<Account> listClienteBusqueda{get;set;}
    
    private ApexPages.StandardController stdController;
    
    public RutaControllerExt(ApexPages.StandardController controller){
        try{
        	stdController = controller;
            ruta = (Ruta__c)controller.getRecord();
            
            filtroIdentificacion = '';
            listClienteBusqueda = new list<Account>();
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('RutaController - Constructor: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }
    }
    
    public void buscarCliente(){
        try{
        	listClienteBusqueda = Utilities.getAccounts(filtroIdentificacion);
            
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('RutaController - buscarCliente: ' + e.getCause() + ' Linea: ' + e.getLineNumber());
        }
    }
    
    public void seleccionarCliente(){
        try{
            
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('RutaController - seleccionarCliente: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }
    }
    
    public pageReference guardar(){
        try{
            
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('RutaController - guardar: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }
        return null;
    }
    
    public class Cliente{
        public string nombre{get;set;}
        public string zona{get;set;}
        public string frecuencia{get;set;}
        public string fechaUltimaVisita{get;set;}
        public string limiteCredito{get;set;}
        public string estado{get;set;}
    }
}