/*
*       @AUTOR:         JOHN CORTES(IS)
*       @FECHA:         27 de Noviembre de 2017
*       @DESCRIPCION:   Controlador para casignacion de vendedores.
*
*/
public class AsignacionVendedoresSaltoController {

    private final String opportunity { get; set; }
    private final String user { get; set; }
    private final Salto_Turno_Oportunidad__c saltoTurnoInput;


	public AsignacionVendedoresSaltoController (ApexPages.StandardController stdController) {

        this.saltoTurnoInput = (Salto_Turno_Oportunidad__c)stdController.getRecord();
 		opportunity = ApexPages.currentPage().getParameters().get('opportunityId'); 
    	user = ApexPages.currentPage().getParameters().get('userId'); 

    }

   
    public PageReference saveRecord(){


        Salto_Turno_Oportunidad__c saltoOportunidad = new Salto_Turno_Oportunidad__c();
        saltoOportunidad.Opportunity__c = opportunity;
        saltoOportunidad.User__c = user;
        saltoOportunidad.Razon__c = saltoTurnoInput.Razon__c;
        insert saltoOportunidad;


        List<Opportunity> listNewOpportunities = new List<Opportunity>();

        for(List<Opportunity> listNewOps  : [Select id, LeadSource,Sucursal__c From Opportunity Where Id =: opportunity]){
        	for(Opportunity oppItem: listNewOps){
        		listNewOpportunities.add(oppItem);
        	}
        }


        OpportunityAsignacionVendedorSinMarca opportunityAsignacion = new OpportunityAsignacionVendedorSinMarca();
        opportunityAsignacion.reasignarOportunidadVendedores(listNewOpportunities,'Walk-In');
        update listNewOpportunities;
       
        pagereference pr = new pagereference('/' + opportunity);
        return pr;
    }


   
}