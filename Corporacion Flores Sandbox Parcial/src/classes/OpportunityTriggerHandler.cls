public class OpportunityTriggerHandler extends TriggerHandler {

	private Map<Id, Opportunity> newOpMap;
	private List<Opportunity> ListNewOps;
	
	private Map<Id, Opportunity> MapOldOpp;
	private List<Opportunity> ListOldOpps;
	
	
	public OpportunityTriggerHandler() {
		this.newOpMap = (Map<Id, Opportunity>) Trigger.newMap;
		this.ListNewOps = (List<Opportunity>) Trigger.New;
		this.ListOldOpps = (List<Opportunity>) Trigger.Old;
		this.MapOldOpp = (Map<Id, Opportunity>) Trigger.oldMap;			
		
	}
	
	public override void beforeInsert(){

		//R9 :   Asignación automática de oportunidades usando un rol de planta (vendedores activos en piso).
        //R9 :   Aplica a prospectos web (Web, email, teléfono y facebook) y walk-in (cliente en sala)
		//R9 :   La asignación se da en el momento de convertir el prospecto a Oportunidad.
		//R9 :   Los prospectos creados por los asesores se deben convertir automáticamente al guardar el prospecto con los campos requeridos, y asignar a ellos mismos al convertir en Oportunidad (mismo propietario).
		//R11:   Host/Anfitriona: Activar la asignación al convertir el prospecto a oportunidad, y seleccionar si se va a saltar algun turno (registrar razón)
		//R11:   En la pantalla No. 3 del prospecto al presionar el botón Convertir (11) se debe realizar el proceso de asignación automática basado en los datos configurados en el objeto vendedores de la pantalla Prototipo de Configuración de vendedores.


		//TODO: R7: Los prospectos creados directamente por los asesores y gerentes de venta, no entran al rol de asignación, estos prospectos al convertirlos a oportunidad se deben asignar al mismo usuario que genera la conversión.
		OpportunityService.reasignarOportunidadVendedores(ListNewOps);

	}
}