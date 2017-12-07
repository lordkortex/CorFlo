/*
*       @AUTOR:         JOHN CORTES(IS)
*       @FECHA:         27 de Noviembre de 2017
*       @DESCRIPCION:   Controlador para casignacion de vendedores.Esta clase queda comentada. Actualmentes
*       se usa la clase OpportunityAsignacionVendedorSinMarca la cual no tiene en cuenta la marca. Esta clase
*       sera usada en caso de que quieran cambiar el proceso de round robbin y deseen tener en cuenta la marca.
*
*/
@isTest(SeeAllData=false) 
private class OpportunityAsignacionVendedorTest {
	public OpportunityAsignacionVendedorTest() {
		

	}

	private static testmethod void testConstructor(){
		OpportunityAsignacionVendedor oppAsignacionVendedor = new OpportunityAsignacionVendedor();
	}
    
}