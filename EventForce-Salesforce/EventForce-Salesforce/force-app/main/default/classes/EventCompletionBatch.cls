global with sharing class EventCompletionBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Event_Status__c, Event_Date__c
            FROM Event__c
            WHERE Event_Date__c < :Date.today()
            AND Event_Status__c IN ('Planned','Confirmed')
        ]);
    }
    global void execute(Database.BatchableContext bc, List<Event__c> scope) {
        for (Event__c e : scope) e.Event_Status__c = 'Completed';
        if (!scope.isEmpty()) update scope;
    }
    global void finish(Database.BatchableContext bc) {}
}
