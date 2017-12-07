trigger OpportunityTrigger on Opportunity (before insert , before update, after insert)  { 
	new OpportunityTriggerHandler().run();
}