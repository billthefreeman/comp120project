Overview
===================


The following diagram shows the major data structures and key fields for the primary objects managed by the incident management service for each audience, and the basic relationships between those objects. These objects correspond to the items that a user sees in their account: profile, incident notifications, assigned incidents, etc.
![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/uml.jpg)

The structures on the left side of the diagram (Incidents, Incident_audit, status, type_of_incidents) are accessed via the IncidentStore service which can be used to report and handle incidents, while the ones on the right represents the personal profile.

####**Incidents**
This represents the information for an incident.

**incident_id:**
The unique numeric identifier for the incident, which will not change for the lifetime of the reported incident.
 
**location:**
The location is a street address which specifies the place where the incident take place. It is first filled in by the reporter (a people in the people table) or can be modified by other people.
 
**status:**
This field reference the id in table status, which link the status name to a status id. 

**report date and time:**
The date and time when this incident was reported in the service.
 
**processed date and time:**
The date and time when this incident start being processed by assignees(date and time this incident is first being assigned).
 
**solved date and time:**
The date and time when this incident was solved.
 
**closed date and time:**
The date and time when this incident was closed because it is found out bogus.
 
**incident urgency:**
To determine the Incident’s urgency, reported or others want to modify the incident urgency can choose the highest relevant category below. Priority of an incident is determined by its urgency. 
(Reference: http://wiki.en.itprocessmaps.com/index.php/Checklist_Incident_Priority)
 |Category    | Description|
--------     | ---|
|High(H) | The damage caused by the Incident increases rapidly; Work that cannot be completed by staff is highly time sensitive; A minor Incident can be prevented from becoming a major Incident by acting immediately.|
Medium(M)  | The damage caused by the Incident increases considerably over time.|
Low(L)     | The damage caused by the Incident only marginally increases over time; Work that cannot be completed by staff is not time sensitive.


**incident impact:**
This section establishes categories of impact. To determine the Incident’s impact, reported or others want to modify the incident urgency can choose the highest relevant category below. Priority of an incident is determined by its impact.
(Reference: 
http://wiki.en.itprocessmaps.com/index.php/Checklist_Incident_Priority)
 Category    | Description
--------     | ---
High(H) | A large number of staff are affected and/or not able to do their job; The financial impact of the Incident is (for example) likely to exceed $10,000; The damage to the reputation of the institution is likely to be high; Someone has been injured.
Medium(M)    | A moderate number of staff are affected and/or not able to do their job properly; The financial impact of the Incident is (for example) likely to exceed   but will not be more than $10,000; The damage to the reputation of the institution is likely to be moderate.
Low(L)     | A minimal number of staff are affected and/or able to deliver an acceptable service but this requires extra effort; The financial impact of the Incident is (for example) likely to be less than $1,000; The damage to the reputation of the institution is likely to be minimal.

 
**type of incident_id:**
reference the id in table type of incident, which link the type name to a type id.
 
**other_type_description:**
If reporter or people who make modification find all the exist incident types not relevant, this area can be used to fill in information about the type of the incident.
 
**incident_descripition:**
text field for reporter or people who make modification to writr some more detailed description on the incident.
 
**reporter_id:**
id of the reported which reference the id in table people, which link the information of people to people id.
 
**assignee_id:**
id of the assigned people which reference the id in table people, which link the information of people to people id.
 
**assignee_comments:**
text field for assignees to make some description on the process of handling the incident 
 
####**Incident_audit**
incident_audit table is used to keep track of the modifications of incidents.  For every change, regardless of what kind (update or insert), we will create a record in the audit table. The audit table will have an extra field "dt" that determines when the change occurred. When an incident is inserted or updated in the incident table, trigger will be used to insert a corresponding audit row into this table.
 
 
**Status**
This represents all selectable statuses of an incident.
status_id: The unique numeric identifier for the incident status, which will not change for the lifetime of the incident status.
 
status_name: selectable status name are as follows: reported, processing, reassigned, solved and closed.
 
 
**Type**
This represents all selectable types of an incident.
Incidents with different types will be viewed by audiance in different departments and handled by employees in different groups. (See later chapter)

type_of_incident_id: The unique numeric identifier for the incident type, which will not change for the lifetime of the incident type.

type_name: default type names are: Building Renovation, Emergency Response, Environmental Compliance, Environmental Public Health, Fire Safety, Construction Safety, Occupational Safety, Biosafety, Chemical Safety, General Lab Safety, Radiation Protection.

**People**
Every person in Operations Services is represented by one Person object. Each person has a unique person_id. Table People also contains information of first/last names, phone numbers, emails and group_ids. Class People has two abstract subclasses: Reporter and Assignee. A person can behave as both reporter and assignee in different cases.
 
**Reporter**
A Reporter represents a person who reports the incident. Each incident can have only on reporter, but it is possible for a reporter (person) to report many incidents.
 
**Assignee**
An Assignee represents a person who will handle the incident. Every incident will be processed by one assignee at a time. If the assignee cannot solve the problem, the incident will be reassigned to another group (status of incidents will be changed to reassigned). Another employee will be assigned to solve this incident and become the new Assignee of this incident.
 
**Group**
Every employee belongs to a Group.  A reported incident will be assigned to one or more groups of person in Environmental Health & Safety Department depending on its Type. For example, slip-trip-and-fall will be assigned to Buildings and Facilities Group. If an incident has no specific type, it will be sent to Front Desk Staff group and will be reassigned to another group.
 
**Department **
There are Departments under Operations Services: Dining, Energy & Facilities, Environmental Health & Safety, Housing, Mail & Print, Sustainability, Events Management, Sustainability, and Transportation. Employees in different Department have different privileges to view incidents. For example, employees in Transportation department cannot view the incidents about exposed power outlet in a building.
Life-and death incidents will be exposed to all the departments.
