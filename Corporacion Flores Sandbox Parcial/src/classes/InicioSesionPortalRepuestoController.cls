public class InicioSesionPortalRepuestoController {
    public string usuario{get;set;}
    public string contrasena{get;set;}
    
    public InicioSesionPortalRepuestoController(){
        usuario = '';
        contrasena = '';
    }
    
    public void iniciarSesion(){
        try{
            
        }Catch(Exception e){
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('IniciarSesionController - iniciarSesion: ' + e.getCause() + ' Linea: ' + e.getLineNumber());
        }
    }
    
    public void olvidarContrasena(){
    	try{
            
        }Catch(Exception e){
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '!Ha sucedio un error!'));
            system.debug('IniciarSesionController - olvidarContrasena: ' + e.getCause() + ' Linea: ' + e.getLineNumber());
        }    
    }
}