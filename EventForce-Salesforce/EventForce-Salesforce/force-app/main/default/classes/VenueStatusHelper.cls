public with sharing class VenueStatusHelper {
    public static void preventDoubleBooking(List<Event__c> eventsToCheck) {
        Set<Id> venueIds = new Set<Id>();
        Set<Date> eventDates = new Set<Date>();
        for (Event__c e : eventsToCheck) {
            if (e.Venue__c != null && e.Event_Date__c != null &&
                (e.Event_Status__c == 'Confirmed' || e.Event_Status__c == 'Planned')) {
                venueIds.add(e.Venue__c);
                eventDates.add(e.Event_Date__c);
            }
        }
        if (venueIds.isEmpty() || eventDates.isEmpty()) return;
        Set<String> existing = new Set<String>();
        for (Event__c e : [SELECT Id, Venue__c, Event_Date__c FROM Event__c
                            WHERE Venue__c IN :venueIds AND Event_Date__c IN :eventDates
                            AND Event_Status__c IN ('Confirmed','Planned')]) {
            existing.add(String.valueOf(e.Venue__c) + '|' + String.valueOf(e.Event_Date__c) + '|' + String.valueOf(e.Id));
        }
        for (Event__c e : eventsToCheck) {
            if (e.Venue__c == null || e.Event_Date__c == null ||
                !(e.Event_Status__c == 'Confirmed' || e.Event_Status__c == 'Planned')) continue;
            String prefix = String.valueOf(e.Venue__c) + '|' + String.valueOf(e.Event_Date__c) + '|';
            for (String key : existing) {
                if (key.startsWith(prefix) && !key.endsWith('|' + String.valueOf(e.Id))) {
                    e.addError('This venue is already booked for the selected event date.');
                    break;
                }
            }
        }
        // Detect duplicate records within the same transaction.
        Set<String> seen = new Set<String>();
        for (Event__c e : eventsToCheck) {
            if (e.Venue__c == null || e.Event_Date__c == null ||
                !(e.Event_Status__c == 'Confirmed' || e.Event_Status__c == 'Planned')) continue;
            String key = String.valueOf(e.Venue__c) + '|' + String.valueOf(e.Event_Date__c);
            if (seen.contains(key)) e.addError('Only one event can use the same venue on the same date.');
            seen.add(key);
        }
    }
}
