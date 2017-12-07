/*
 * Nombre: CotizacionRepuestoControllerExt
 * Descripcion: Sirve para crear una venta de repuestos iniciando como cotización
 * Fecha de creación: 
 * Desarrollador:
*/
public class CotizacionRepuestoControllerExt {
    public Cotizacion__c cotizacion{get;set;}
    public list<ParteSalesforce> listPartes{get;set;}
    public list<ParteSAP> listPartesBusqueda{get;set;}
    
    // Búsqueda de clientes para la cotización
    public boolean popBuscarCliente{get;set;}
    public string filtroIdentificacion{get;set;}
    public list<Account> listClienteBusqueda{get;set;}
    
    public boolean popBuscarParte{get;set;}
    public boolean popVerInventario{get;set;}
    
    private ApexPages.StandardController stdController;
    
    public CotizacionRepuestoControllerExt (ApexPages.StandardController controller){
        try{
            stdController = controller;
            cotizacion = (Cotizacion__c)controller.getRecord();
            
            listPartes = new list<ParteSalesforce>(); 
            listPartesBusqueda = new list<ParteSAP>();
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, '!Ha sucedio un error!'));
            system.debug('CotizacionRepuestoControllerExt - constructor: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }
    }
    
    public void cerrarPops(){
    	popBuscarCliente = False; 
        popBuscarParte = False; 
        popVerInventario = False; 
    }
    
    public void buscarCliente(){
        try{
        	listClienteBusqueda = Utilities.getAccounts(filtroIdentificacion);    
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('CotizacionRepuestoControllerExt - buscarCliente: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }
    }
    
    public void seleccionarCliente(){
    	try{
            
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('CotizacionRepuestoControllerExt - seleccionarCliente: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }    
    }
    
    public void buscarParte(){
        try{
            
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('CotizacionRepuestoControllerExt - buscarParte: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }
    }
    
    public void seleccionarPartes(){
        try{
            
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('CotizacionRepuestoControllerExt - seleccionarPartes: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }
    }
    
    public void verInventario(){
        try{
            
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('CotizacionRepuestoControllerExt - verInventario: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }
    }
    
    public pageReference guardar(){
        try{
            
        }Catch(Exception e){
        	apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('CotizacionRepuestoControllerExt - guardar: ' + e.getCause() + ' Linea: ' + e.getLineNumber());    
        }
        return null;
    }
    
    public class ParteSalesforce{
        public string casilla{get;set;}
        public string numItem{get;set;}
        public string numParte{get;set;}
        public string descripcion{get;set;}
        public decimal unidad{get;set;}
        public integer cantidad{get;set;}
        public integer disponibilidad{get;set;}
        public decimal descuento{get;set;}
        public decimal precioUnitario{get;set;}
        public decimal precioTotal{get;set;}
        public string estado{get;set;}
    }
    
    public class ParteSAP{
    	public string numParte{get;set;}
        public string descripcion{get;set;} 
        public integer cantidadDisponible{get;set;}
        public integer cantidadReservada{get;set;}
        public string icc{get;set;}
        public string sustituto{get;set;}
        public decimal precio{get;set;}
        public decimal inventarioCentro{get;set;}
    }
}