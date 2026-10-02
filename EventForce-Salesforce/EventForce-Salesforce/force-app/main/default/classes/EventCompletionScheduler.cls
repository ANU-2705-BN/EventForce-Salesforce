global with sharing class EventCompletionScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new EventCompletionBatch(), 200);
    }
}
