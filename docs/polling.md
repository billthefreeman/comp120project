##**Leg 6: Polling and Memory Caching**

###**1. Design for polling:**
####**1.1 Two options:**
    We considered two options to accomplish this task: One is to send an AJAX request to the server at a regular interval to see if the number of incidents has changed (the polling method). The other option is to use WebSockets to provide a permanent connection to the server and to push any changes to the user as soon as they become available. 

####**1.2 Our choice and the reason**
    We decided to choose the first approach (the polling method) for the following reasons: First, polling is the easier as WebSockets are not supported by all browsers yet and would require more coding along with a library such as Cramp to get working. Second, we don’t need instant updates when a new comment is posted, a delay of a few seconds is perfectly acceptable. 

####**1.3 Details of our design**
    When a new incident is created, after a certain amount of time(which is dynamic, the algorithm will be talked later), a message will shown at the top of the page saying :”New incidents have been posted. Show Incidents.” And the count for total reported incidents on the top will also be changed according to the new counts of incidents. When the user click the ”Show Incidents” link, new incidents will display at the top of our timeline, sorted by date and time in descending order. In this way, we will not interrupt the users when they are reading some information from our page.

####**1.4 The dynamic polling algorithm**
    Our program waits a varying amount of time before each polling. The waiting time is depend on whether or not new incidents were created during the previous interval. If there were some new incidents created, it must have waited too long last time, so we decrease the current wait time. If there was no new incident, we increase the current wait time.
    There are two modes to change the waiting time. One is power-of-two algorithm, e.g. 1s,2s,4s,8s,16s,32s….This algorithm has the best learning time, but it may bounce around between times. The other is increment/decrement algorithm, e.g. 10s,15s,20s,25s,30s….This algorithm keeps the waiting time very stable but it takes a long time to obtain the optimal waiting time.
    We used the combination of the two algorithms. We switch from the increment/decrement mode to the power-of-two mode when the waiting time has to be changed twice in the same direction (for example, when the waiting time increases twice successively); and we switch from the power-of-two mode to the increment/decrement mode when the change of waiting time changes direction.(for example, when the waiting time increase, then decrease)
    The upper and lower limit of our waiting time is 128s and 1s, respectively.
    The pseudo code of this algorithm is as follows:

    wait = 1s
    minWait = 1s
    maxWait = 128s
    changeMode = power-of-two
    direction = increase

    function calculatePollingTime () {
        if (in power-of-two mode && new incidents created) {
            wait = max(minWait, wait / 2);
            if (direction == increase) {
                direction = decrease;
                changeMode =  increment/decrement;
            }
        }
        else if (in increment/decrement mode && new incidents created) {
            wait = max(minWait, wait - 5s);
            if (direction == decrease) {
                changeMode =  power-of-two;
            }
            else {
                direction = decrease;
            }
        else if (in power-of-two mode && !new incidents created) {
            wait = min(maxWait, wait * 2);
            if (direction == decrease) {
                direction = increase;
                changeMode =  increment/decrement;
            }
        }
        else { // in increment/decrement mode && !new incidents created
            wait = min(maxWait, wait + 5s);
            if (direction == increase) {
                changeMode =  power-of-two;
            }
            else {
                direction = increase;
            }
        }

The reference of this algorithm is: http://www.xaprb.com/blog/2006/05/04/how-to-make-a-program-choose-an-optimal-polling-interval/


###**2. How data cached:**

We use Redis for our data cached. Redis is stored in-memory key/value lookup tables so it is extremely fast to access. Redis offers more flexibility for new use cases and also provides better out-of-the-box availability, scalability, and administration. Also, Redis can be used when requiring selectively deleting/expiring items in the cache. However, it takes memory to store.

We use Redis to store each incidents when created. So every time when time out, we check in redis to see whether there are new incidents created or not. It only queries database when the user click the Show Incidents link so as to append new incidents to the timeline. Also, we store our <cate_id, cate_name> as <key, value> in Redis so that it’s more easier to find cate_name by cate_id in Redis.  For example, in the index.html.erb and show.html.erb, we wrote: <b>Category: </b><%= $redis.hget('cates', incident.cate_id) %><br> to show category name of an incident; we also provide options for user to select in the form of new incidents by getting value from redis. This rule also applies to <reporter_id, reporter_name> and <status_id, status_name>. 

###**3. The costs-benefits of the polling implementation**

####**The benefits of our implementation include:**
The idea is simple, so it is easy to understand and relatively easy to implement.
We can control the period of the polling interval. In practice, based on the frequency of new incidents, we increase or decrease the interval. In addition, by adopting a dynamic way of setting the polling interval, we can reduce the resource uses.
As suggested by the team 7 during their presentation, we keep a single point of truth on the server side, so every client sees the same index.

####**The costs includes:**
Even with the dynamic polling algorithm, there could be potential waste of resources. That’s the cost we have to pay for not using real-time messaging system.
The naive polling doesn't scale very well. For example, if we have a modest user base of 100 concurrent users, and they are all doing the pulling operation, the application can be flooded with hundreds of requests every few seconds. In other words, polling doesn't scale very well, unless we have the resources to stand up servers horizontally.



