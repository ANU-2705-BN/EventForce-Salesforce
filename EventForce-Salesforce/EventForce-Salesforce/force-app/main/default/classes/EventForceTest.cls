@IsTest
private class EventForceTest {
    @IsTest static void createsRelatedRecordsAndBudget() {
        Client__c c = new Client__c(Name='Test Client', Email__c='test@example.com', Phone__c='9876543210', City__c='Chennai');
        insert c;
        Venue__c v = new Venue__c(Name='Test Venue', Capacity__c=200, Availability_Status__c='Available');
        insert v;
        Vendor__c vendor = new Vendor__c(Name='Test Vendor', Email__c='vendor@example.com', Status__c='Available', Service_Type__c='Catering;Decor');
        insert vendor;
        Event__c e = new Event__c(Name='Test Wedding', Client__c=c.Id, Venue__c=v.Id, Event_Date__c=Date.today().addDays(10), Event_Type__c='Wedding', Event_Status__c='Confirmed');
        insert e;
        e = [SELECT Event_Budget__c FROM Event__c WHERE Id=:e.Id];
        System.assertEquals(50000, e.Event_Budget__c);
        insert new EventVendor__c(Event__c=e.Id, Vendor__c=vendor.Id);
        insert new Feedback__c(Event__c=e.Id, Client__c=c.Id, Rating__c='5', Comments__c='Excellent');
    }
    @IsTest static void blocksDoubleBooking() {
        Venue__c v = new Venue__c(Name='Venue A', Capacity__c=100, Availability_Status__c='Available'); insert v;
        Event__c e1 = new Event__c(Name='First', Venue__c=v.Id, Event_Date__c=Date.today().addDays(5), Event_Type__c='Corporate', Event_Status__c='Confirmed'); insert e1;
        Event__c e2 = new Event__c(Name='Second', Venue__c=v.Id, Event_Date__c=e1.Event_Date__c, Event_Type__c='Birthday', Event_Status__c='Confirmed');
        Test.startTest();
        try { insert e2; System.assert(false, 'Expected duplicate booking error'); }
        catch (DmlException ex) { System.assert(ex.getMessage().contains('already booked')); }
        Test.stopTest();
    }
    @IsTest static void completesPastEvents() {
        Event__c e = new Event__c(Name='Past Event', Event_Date__c=Date.today().addDays(-2), Event_Type__c='Concert', Event_Status__c='Confirmed'); insert e;
        Test.startTest(); Database.executeBatch(new EventCompletionBatch(), 50); Test.stopTest();
        e = [SELECT Event_Status__c FROM Event__c WHERE Id=:e.Id];
        System.assertEquals('Completed', e.Event_Status__c);
    }
}
