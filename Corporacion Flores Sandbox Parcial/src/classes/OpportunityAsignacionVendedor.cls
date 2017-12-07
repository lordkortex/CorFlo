/*
*       @AUTOR:         JOHN CORTES(IS)
*       @FECHA:         27 de Noviembre de 2017
*       @DESCRIPCION:   Controlador para casignacion de vendedores.Esta clase queda comentada. Actualmentes
*       se usa la clase OpportunityAsignacionVendedorSinMarca la cual no tiene en cuenta la marca. Esta clase
*       sera usada en caso de que quieran cambiar el proceso de round robbin y deseen tener en cuenta la marca.
*
*/
public with sharing class OpportunityAsignacionVendedor {


	public OpportunityAsignacionVendedor() {
		
	}

	/*public  void reasignarOportunidadVendedores(final List<Opportunity> setOpp,final String source){  

        
	        Set<String> setSucursalMarcaConteo = new Set<String>();
	        Map<String,Vendedor_Asignacion_Contador__c> mapSucursalMarcaConteo = new Map<String,Vendedor_Asignacion_Contador__c>();


	        for( Vendedor_Asignacion_Contador__c vendAsigContItem : [Select  Sucursal__c,Marca__c,Conteo__c 
	                    From Vendedor_Asignacion_Contador__c Where Source__c =: source] ) {

	            String sucursalMarca = vendAsigContItem.Sucursal__c + '|' + vendAsigContItem.Marca__c;
	            setSucursalMarcaConteo.add(sucursalMarca);
	            if(!mapSucursalMarcaConteo.containsKey(sucursalMarca)){
	                mapSucursalMarcaConteo.put(sucursalMarca,vendAsigContItem);
	            }
	            
	        }

	        Map<String,Map<String,Map<Decimal,String>>> mapUsusariosSucuralMarca = llenarMapUsusariosSucuralMarca(mapSucursalMarcaConteo,setSucursalMarcaConteo,source);



	        Map<String,String> sucursalMap = new Map<String,String>();


	        for(Sucursal__c sucursal : [Select id,name From Sucursal__c]){
	            sucursalMap.put(sucursal.name,sucursal.Id);
	        }
	        
	        System.debug('************* sucursalMap: ' + sucursalMap);   
	        System.debug('************* mapUsusariosSucuralMarca: ' + mapUsusariosSucuralMarca);   
	        
	        asignarPropietarioAOportunidad(setOpp,sucursalMap,mapUsusariosSucuralMarca,mapSucursalMarcaConteo,source);

	        List<Vendedor_Asignacion_Contador__c> vendedorConteoList = new List<Vendedor_Asignacion_Contador__c>();
	            
	        for (String key : mapSucursalMarcaConteo.keySet()) {
	               Vendedor_Asignacion_Contador__c vendedorConteoItem = mapSucursalMarcaConteo.get(key);
	               vendedorConteoList.add(vendedorConteoItem);
	        }

	        upsert vendedorConteoList;


 
    } 

    public  void asignarPropietarioAOportunidad(final List<Opportunity> setOpp,
    												  final Map<String,String> sucursalMap,
    												  final Map<String,Map<String,Map<Decimal,String>>> mapUsusariosSucuralMarca,
    												  final Map<String,Vendedor_Asignacion_Contador__c> mapSucursalMarcaConteo,
    												  final String source  ){

    	for(Opportunity opp : setOpp){

		        	if((source == 'Web' && (opp.LeadSource == 'Facebook' || opp.LeadSource == 'Web' )) || (source == 'Walk-In' && (opp.LeadSource == 'Walk-In'))){
		        			      
			        	String marcaOportunidad = opp.Marca__c;

			            System.debug('************* opp: ' + opp);   
			            System.debug('************* sucursalMap.containsKey(opp.Sucursal__c): ' + sucursalMap.containsKey(opp.Sucursal__c));     
			            System.debug('************* opp.LeadSource: ' + (opp.LeadSource == 'Facebook' ||    opp.LeadSource == 'Página Web'));    

			            System.debug('************* marcaOportunidad: ' + marcaOportunidad);
			            

		                //if(!String.isBlank(marcaOportunidad) && sucursalMap.containsKey(opp.Sucursal__c) && (opp.LeadSource == 'Facebook' ||    opp.LeadSource == 'Página Web')){
		                if(!String.isBlank(marcaOportunidad) && (opp.LeadSource == 'Facebook' ||    opp.LeadSource == 'Página Web')){

		                    String idSucursal = opp.Sucursal__c;
		                    System.debug('************* idSucursal: ' + idSucursal);     
		                         

		                        
		                    if(mapUsusariosSucuralMarca.containsKey(idSucursal) 
		                            && mapUsusariosSucuralMarca.get(idSucursal).containsKey(marcaOportunidad)){
		                    
		                            System.debug('************* mapUsusariosSucuralMarca: ' + mapUsusariosSucuralMarca);   


		                            String sucursalMarca = idSucursal + '|' + marcaOportunidad;
		                            Map<Decimal,String> mapUsuarioTemporal = mapUsusariosSucuralMarca.get(idSucursal).get(marcaOportunidad);
		                            Decimal tamanioMapa = mapUsuarioTemporal.size() - 1;


		                            if(mapSucursalMarcaConteo.containsKey(sucursalMarca)){

		                                System.debug('************* mapUsuarioTemporal: ' + mapUsuarioTemporal);     
		                                Vendedor_Asignacion_Contador__c vendContador = mapSucursalMarcaConteo.get(sucursalMarca);
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


    public  Map<String,Map<String,Map<Decimal,String>>> llenarMapUsusariosSucuralMarca(final Map<String,Vendedor_Asignacion_Contador__c> mapSucursalMarcaConteo ,final Set<String> setSucursalMarcaConteo, final String source ){ 

			Map<String,Map<String,Map<Decimal,String>>> mapUsusariosSucuralMarca = new Map<String,Map<String,Map<Decimal,String>>> ();


		    for(Vendedor_Asignaciones__c vendedorItem : [Select Vendedor__c,
	                                        Vendedor__r.Usuario__c ,Vendedor__r.Usuario__r.Name ,
	                                        Vendedor__r.Marcas__c,
	                                        Vendedor__r.Sucursal__c, Vendedor__r.Sucursal__r.Name
	                                          From  Vendedor_Asignaciones__c 
	                                          Where  
	                                           Fecha_Asignacion__c = TODAY And Activo__c = true
	                                           and  Vendedor__c != null 
	                                           and  Source__c =: source
	                                           Order by Vendedor__c
	                                          ]){

	                                              
	            String sucursal = vendedorItem.Vendedor__r.Sucursal__c;
	            
	            if(!mapUsusariosSucuralMarca.containsKey(sucursal)){
	                mapUsusariosSucuralMarca.put(sucursal, new Map<String,Map<Decimal,String>>());
	        }               

	        Map<String,Map<Decimal,String>>  mapSucursal = mapUsusariosSucuralMarca.get(sucursal);

	        if(vendedorItem.Vendedor__r.Marcas__c != null){
	                String[] marcaList = vendedorItem.Vendedor__r.Marcas__c.split(';');
	                System.debug('************* marcaList: ' + marcaList);   
	                for(String marca: marcaList){

	                   
	                    String sucursalMarca =  sucursal + '|' + marca;

	                    if (!setSucursalMarcaConteo.contains(sucursalMarca)){
	                        Vendedor_Asignacion_Contador__c vendAsigContItem = new Vendedor_Asignacion_Contador__c(Sucursal__c = sucursal,Marca__c = marca,Conteo__c = 0,Source__c = source);
	                         mapSucursalMarcaConteo.put(sucursalMarca,vendAsigContItem);
	                    }

	                    if (!mapSucursal.containsKey(marca)){
	                        Map<Decimal,String> vendedoresList = new Map<Decimal,String>();
	                        vendedoresList.put(0,vendedorItem.Vendedor__r.Usuario__c);
	                        mapSucursal.put(marca,vendedoresList);
	                    }else{
	                        Map<Decimal,String> vendedoresList = mapSucursal.get(marca);
	                        Decimal contador = vendedoresList.size();
	                        vendedoresList.put(contador,vendedorItem.Vendedor__r.Usuario__c);
	                    }

	                }
	            }
	    
	        }

	    return mapUsusariosSucuralMarca;
	}*/
}