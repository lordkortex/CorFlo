public with sharing class OpportunityAsignacionVendedorSinMarca {


	public OpportunityAsignacionVendedorSinMarca() {
		
	}

	public  void reasignarOportunidadVendedores(final List<Opportunity> setOpp,final String source){  

        
	        Set<String> setSucursalConteo = new Set<String>();
	        Map<String,Vendedor_Asignacion_Contador__c> mapSucursalConteo = new Map<String,Vendedor_Asignacion_Contador__c>();


	        for( Vendedor_Asignacion_Contador__c vendAsigContItem : [Select  Sucursal__c,Conteo__c 
	                    From Vendedor_Asignacion_Contador__c Where Source__c =: source] ) {

	            String sucursal = vendAsigContItem.Sucursal__c;
	            setSucursalConteo.add(sucursal);
	            if(!mapSucursalConteo.containsKey(sucursal)){
	                mapSucursalConteo.put(sucursal,vendAsigContItem);
	            }
	            
	        }

	        Map<String,Map<Decimal,String>> mapUsusariosSucursal = llenarMapUsusariosSucural(mapSucursalConteo,setSucursalConteo,source);


	        /*****************************************************************************/

	        Map<String,String> sucursalMap = new Map<String,String>();


	        for(Sucursal__c sucursal : [Select id,name From Sucursal__c]){
	            sucursalMap.put(sucursal.name,sucursal.Id);
	        }
	        
	        System.debug('************* sucursalMap: ' + sucursalMap);   
	        System.debug('************* mapUsusariosSucursal: ' + mapUsusariosSucursal);   
	        
	        asignarPropietarioAOportunidad(setOpp,sucursalMap,mapUsusariosSucursal,mapSucursalConteo,source);

	        List<Vendedor_Asignacion_Contador__c> vendedorConteoList = new List<Vendedor_Asignacion_Contador__c>();
	            
	        for (String key : mapSucursalConteo.keySet()) {
	               Vendedor_Asignacion_Contador__c vendedorConteoItem = mapSucursalConteo.get(key);
	               vendedorConteoList.add(vendedorConteoItem);
	        }

	        upsert vendedorConteoList;


 
    } 



    public  Map<String,Map<Decimal,String>> llenarMapUsusariosSucural(final Map<String,Vendedor_Asignacion_Contador__c> mapSucursalConteo ,final Set<String> setSucursalConteo, final String source ){ 

			Map<String,Map<Decimal,String>> mapUsusariosSucural = new Map<String,Map<Decimal,String>>();


		    for(Vendedor_Asignaciones__c vendedorItem : [Select Vendedor__c,
	                                        Vendedor__r.Usuario__c ,Vendedor__r.Usuario__r.Name ,
	                                        Vendedor__r.Sucursal__c, Vendedor__r.Sucursal__r.Name
	                                          From  Vendedor_Asignaciones__c 
	                                          Where  
	                                           Fecha_Asignacion__c = TODAY And Activo__c = true
	                                           and  Vendedor__c != null 
	                                           and  Source__c =: source
	                                           and  Vendedor__r.Activo__c = true
	                                           Order by Vendedor__c
	                                          ]){

	                                              
	            String sucursal = vendedorItem.Vendedor__r.Sucursal__c;

	            if (!setSucursalConteo.contains(sucursal)){
	                        Vendedor_Asignacion_Contador__c vendAsigContItem = new Vendedor_Asignacion_Contador__c(Sucursal__c = sucursal,Conteo__c = 0,Source__c = source);
	                         mapSucursalConteo.put(sucursal,vendAsigContItem);
	            }

	            
	            if(!mapUsusariosSucural.containsKey(sucursal)){
					Map<Decimal,String> vendedoresList = new Map<Decimal,String>();
		            vendedoresList.put(0,vendedorItem.Vendedor__r.Usuario__c);
		            mapUsusariosSucural.put(sucursal,vendedoresList);
		        } else {
			        Map<Decimal,String>  mapSucursal = mapUsusariosSucural.get(sucursal);
		            Decimal contador = mapSucursal.size();
		            mapSucursal.put(contador,vendedorItem.Vendedor__r.Usuario__c);
		        }              
	        }

	    return mapUsusariosSucural;
	}


    public  void asignarPropietarioAOportunidad(final List<Opportunity> setOpp,
    												  final Map<String,String> sucursalMap,
    												  final Map<String,Map<Decimal,String>> mapUsuariosSucursal,
    												  final Map<String,Vendedor_Asignacion_Contador__c> mapSucursalConteo,
    												  final String source  ){

		System.debug('************* setOpp: ' + setOpp);     
		System.debug('************* source: ' + source);     


    	for(Opportunity opp : setOpp){

			        System.debug('************* opp: ' + opp);   
			        System.debug('************* opp.LeadSource: ' + (opp.LeadSource == 'Facebook' ||    opp.LeadSource == 'Página Web'));    

		        	if((source == 'Web' && (opp.LeadSource == 'Facebook' || opp.LeadSource == 'Web' || opp.LeadSource == 'App' )) || (source == 'Walk-In' && (opp.LeadSource == 'Walk-In'))){
		        			      
			        

			            String idSucursal = opp.Sucursal__c;
		                System.debug('************* idSucursal: ' + idSucursal);     
		                         

		                        
		                if(mapUsuariosSucursal.containsKey(idSucursal)){
		                    
		                            System.debug('************* mapUsuariosSucursal: ' + mapUsuariosSucursal);   


		                            String sucursal = idSucursal;
		                            Map<Decimal,String> mapUsuarioTemporal = mapUsuariosSucursal.get(idSucursal);
		                            Decimal tamanioMapa = mapUsuarioTemporal.size() - 1;

		                            //Map<String,Vendedor_Asignacion_Contador__c> mapSucursalMarcaConteo ;

		                            if(mapSucursalConteo.containsKey(sucursal)){

		                                System.debug('************* mapUsuarioTemporal: ' + mapUsuarioTemporal);     
		                                Vendedor_Asignacion_Contador__c vendContador = mapSucursalConteo.get(sucursal);
		                                Decimal conteo = vendContador.Conteo__c;
		                                String usuario = mapUsuarioTemporal.get(conteo);
		                                
		                                if(conteo < tamanioMapa){
		                                            conteo += 1;
		                                }else{
		                                            conteo  = 0;
		                                }

		                                vendContador.Conteo__c = conteo;

		                                opp.ownerId = usuario;
		                                System.debug('************* opp usuario ****** %%%%%%%%%%% : ' + usuario);
		                                System.debug('************* opp Usuario: ' + opp);   

		                            }
		                    }
		                }

		        	
	        }

    } 


    
}