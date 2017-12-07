/*
*       @AUTOR:         JOHN CORTES(IS)
*       @FECHA:         27 de Noviembre de 2017
*       @DESCRIPCION:   Controlador para casignacion de vendedores.
*
*/
public class StatusVendedorController {

    private final String user { get; set; }
    private final Salto_Turno_Oportunidad__c saltoTurnoInput;
	private final Boolean isActivo { get; set; }
	private final Boolean isMostrarDatos { get; set; }
	private final Vendedor__c vendedor { get; set; }

	public StatusVendedorController (ApexPages.StandardController stdController) {

        this.saltoTurnoInput = (Salto_Turno_Oportunidad__c)stdController.getRecord();
        user = UserInfo.getUserId();

        List<Vendedor__c> vendedorList = [Select id,Activo__c From Vendedor__c Where Usuario__c =: user]; 
        if (!vendedorList.isEmpty()){
        	vendedor = vendedorList.get(0);
        	isActivo = vendedorList.get(0).Activo__c;
        	isMostrarDatos = true;
        }else{
        	isMostrarDatos = false;
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.info,'No existe un vendedor asignado para este usuario'));
        }
        

    }

    public Boolean getActivo(){
    	return isActivo;
    }

    public Boolean getMostrarDatos(){
    	return isMostrarDatos;
    }
   
    public PageReference activar(){
    	return insertarSalto(true);

    }

    public PageReference desactivar(){
    	return insertarSalto(false);
    }

    public PageReference insertarSalto(final Boolean status){

        if (vendedor == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error,'El usuraio relacionado no existe.'));
            return null;
        } 

        if (String.isBlank(saltoTurnoInput.Razon__c)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error,'Debe ingresar un motivo para inactivarse.'));
            return null;
        } 

    	Salto_Turno_Oportunidad__c saltoOportunidad = new Salto_Turno_Oportunidad__c();
        saltoOportunidad.User__c = user;
        saltoOportunidad.Razon__c = saltoTurnoInput.Razon__c;
        saltoOportunidad.Status__c = status;
        insert saltoOportunidad;

        vendedor.Activo__c = status;
        update vendedor;

        PageReference newPage = Page.StatusVendedor;
        return newPage.setRedirect(true);

    }


   
}