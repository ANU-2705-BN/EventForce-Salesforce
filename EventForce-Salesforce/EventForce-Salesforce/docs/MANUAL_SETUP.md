# EventForce manual Salesforce setup

These items are specified by the supplied project guide and are not represented as the core Apex/object source in this starter package.

## 1. Tabs and Lightning App
Create tabs for Event, Client, Vendor, Venue, Feedback and Event Vendor. Create a Lightning App named `EventForce Management` and add these tabs.

## 2. Feedback lookup filter
On Feedback.Event__c, create a lookup filter so Event.Client__c equals Feedback.Client__c.

## 3. Cancellation approval
Create Approval Process on Event:
- Name: Event_Cancellation_Process
- Entry criteria: Event Status = Pending Cancellation
- Approver: Manager / designated manager user
- On approval: update Event Status to Canceled and send notification
- On rejection: update Event Status to Confirmed and send notification

## 4. Reminder Flow
Create a scheduled/record-triggered Flow for confirmed events that sends a reminder 3 days before Event Date. Use the Client email address as the recipient where appropriate.

## 5. Event status automation
Add Flow logic to keep Event Status current according to the project workflow: Planned, Confirmed, Completed, Pending Cancellation, Canceled, Rejected.

## 6. Security
Configure Profiles, Roles, Permission Sets, OWD and Sharing Rules for Event Administrator, Event Coordinator, Vendor Manager, Venue Manager and other required users.

## 7. Reports and dashboard
Create reports for:
- Upcoming Events
- Event Status Summary
- Vendor Performance / Assignments
- Venue Availability
- Feedback / Ratings

Create a dashboard named `EventForce Operations Dashboard` using these reports.

## 8. Sample records
Create sample Clients, Venues, Vendors and Events. Then create Event Vendor and Feedback records to demonstrate the relationships and automation.
