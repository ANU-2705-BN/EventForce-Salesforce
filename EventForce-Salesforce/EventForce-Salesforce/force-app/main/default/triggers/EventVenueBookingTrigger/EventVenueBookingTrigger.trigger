trigger EventVenueBookingTrigger on Event__c (before insert, before update) {
    VenueStatusHelper.preventDoubleBooking(Trigger.new);
}
