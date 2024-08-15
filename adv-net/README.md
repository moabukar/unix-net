# Adv net topics

Context: When you `dig` a service/DNS, you receive only 8 records and no more than that. DNS works with UDP, if the record is bigger than a single UDP frame (512 bytes) then it can only be served over TCP. This is a limiation within DNS itself when dealing with TCP.

## What does this mean?

Some problems it could lead to: This means if we have more than 8+ instances running, we will not be able to hit all the rest of the IPs. This means any IPs which are more than the threshold of 8 goes to waste as a result wasting resources.


## Examples

In the example, I have around 10 records on my Cloudflare but I only receive 8 records back from dig due to DNS UDP limitation. 

Screenshots shown here:

![Dig output](dig.png)

![Cloudflare records](cloudflare-records.png)
