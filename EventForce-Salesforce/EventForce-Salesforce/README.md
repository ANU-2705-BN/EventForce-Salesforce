# EventForce Management System – Salesforce

A Salesforce DX starter implementation based on the supplied EventForce Management System guide.

## Included
- Custom objects: Event, Client, Vendor, Venue, Feedback, Event Vendor
- Event → Client and Event → Venue lookups
- Feedback → Event and Feedback → Client lookups
- Event Vendor → Event and Event Vendor → Vendor master-detail relationships
- Event Type, Event Status, Event Date and formula-based Event Budget
- Client, Vendor, Venue and Feedback fields from the project guide
- Client email validation rule
- Apex venue double-booking prevention
- Batch Apex to mark past events as Completed
- Scheduled Apex wrapper
- Apex test classes
- Deployment manifest

## Important
The project guide also specifies declarative configuration that is intentionally kept as a manual setup checklist because Salesforce stores Flow, Approval Process, Reports, Dashboards, Profiles/Roles and some Lightning configuration as org-specific metadata.

See `docs/MANUAL_SETUP.md` for the exact configuration to finish the project.

## Deploy
1. Install Salesforce CLI / Salesforce Extension Pack in VS Code.
2. Authorize your Salesforce Developer Org.
3. From this folder run:
   `sf project deploy start --source-dir force-app`
4. After deployment, complete the manual setup checklist.
5. Run Apex tests before using the project as the NM demo.
