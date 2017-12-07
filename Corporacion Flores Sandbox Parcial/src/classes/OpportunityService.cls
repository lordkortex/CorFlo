public with sharing class OpportunityService {


	public OpportunityService() {
		
	}


	public static void reasignarOportunidadVendedores(final List<Opportunity> setOpp){  

		OpportunityAsignacionVendedorSinMarca  opportunityAsignacion = new OpportunityAsignacionVendedorSinMarca();
		opportunityAsignacion.reasignarOportunidadVendedores(setOpp,'Web');
		opportunityAsignacion.reasignarOportunidadVendedores(setOpp,'Walk-In');

    }


}