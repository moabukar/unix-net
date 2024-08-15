### OSI ✅

- Abstraction or Concept of the Internet
- Layer 1 to Layer 7
    - Layer 1 is physical
    - Layer 2 is data frames etc
    - Layer 3 is IP
    - Layer 4 is TCP/UDP. ports
    - Layer 5 - connection/session layer (linkerD?)
    - Layer 6 - Presentation
    - Layer 7 - App layer, HTTP, HTTPS etc
- TCP/IP model
    - This model is another version that focusses on these layers Layer 3/4 & 7

### TCP ✅ (Layer 4, ports and stuff ineh)

- Transmission control protocol
- “Controls” the transmission unlike UDP which is a firehose
- Connection
- Requires handshake
- 20 bytes headers segment
- Stateful
- TCP >> Reliable comms, Remote shell (SSH), database connections, web comms, any bidirectional comms
- TCP Connection
    - Connection is layer (coz its a session)
    - Connection is an AGREEMENT between client and server
    - Must create connection to send data
    - Connection is identified by 4 properties
        - SourceIP-SourcePort
        - DestinationIP-DestinationPort
    - Can’t send data outside connection
    - Sometimes called socket or file descriptor
    - Requires 3 way TCP handshake (ACK. SYN-ACK, ACK)
    - Segments are sequenced and ordered
    - Segments are acknowledge
    - Lost segments are retransmitted
- Multiplexing and demultiplexing
    - *Sender multiplexes all its apps into TCP connections*
    - R*eceiver demultiplex TCP segments to each app based on connection pairs*
- Connection Establishment
    - *App1 on 10.0.0.1 want to send data to AppX on 10.0.0.2*
    - *App1 sends SYN to AppX to synchronous sequence numbers*
    - *AppX sends SYN/ACK to synchronous its sequence number*
    - *App1 ACKs AppX SYN.*
    - *Three way handshake*
- Sending data
    - App1 sends data to App 2
    - App1 encapsulates the data in a segment and send it
    - App 2 acknowledges the segment
    - Hint:*: Can App1 send new segment before ack of old segment arrives?*
- Lost data >> App1 sends segment 1,2 and 3 to App 2, Seg 3 is lost, App 2 acknowledge 3, App1 resend seq 3
- Closing connection
    - App 1 wants to close the connection
    - App1 sends FIN, App2 ACK
    - App2 sends FIN, App1 ACK
    - 4 way handshake > >FIN, ACK, FIN, ACK
- Summary
    - Layer 4
    - “Controls” the transmission unlike UDP which is a firehose
    - Introduces connection concept
    - Retransmission, acknowledgement, guaranteed delivery
    - Stateful, connection has a state
- Pros & Cons of TCP
    - Pros
        - Guaranteed delivery
        - No one can send data without prior knowledge
        - Flow control and congestion control
        - Ordered packets, no corruption or app level work
        - More secure than UDP and can’t easily be spoofed
    - Cons
        - large overhead compared to UDO
        - more bandwith
        - stateful: consumes memory on server and client
        - considered high latecny for certain workloads (slow start/congestion/acks)
        - Does too much at a low level (hence QUIC protocol intro)
            - Single connection to send multiple streams of data (HTTP reqs)
            - Stream 1 has nothing to do with stream 2
            - Both steam 1 and steam 2 packets must arrive)
        - TCP meltdown
            - Not a good candidate for VPN
    

### **UDP ✅ (Layer 4, ports and stuff too ineh)**

- User Diagram Protocol
- Simple protocol to send and recieve data
- Prior communication not required (yes it can be easy but also a double edged sword due to security)
- Stateless - no knowledge is stored on the host
- 8 byte header datagram
- Use cases >> video streaming, VPN, DNS, webRTC
- Mutliplexing & demultiplexing
    - >> sender multiplexes all its app into UDP
    - receiever demultideplx UDP datagrams to each app
- Source & Dest port
    - *App1 on 10.0.0.1 sends data to AppX on 10.0.0.2*
    - *Destination Port = 53*
    - *AppX responds back to App1*
    - *We need Source Port so we know how to send back data*
    - *Source Port = 5555*
- UDP Pros & Cons
    - Pros:
        - Simple protocol
        - header size is small so datagrams are small
        - uses less bandwith
        - stateless
        - consumes less memory (non state stored in server/client
    - Cons:
        - No Ack (acknowledgement)
        - No guaranteed delivery
        - Connection-less - anyone can send data without prior knowledge
        - No flow control
        - No congestion control
        - No ordered packets
        - Security - can be easily spoofed
- Summary
    - UDP is layer 4 protocol
    - uses ports to address processes
    - Stateless

### TLS (can possibly put in Layer 5 coz its stateful)

- Transport Layer Security (lives in layer 5, not written in stone but can be flexible)
    - mentioned layer 5 coz it has a session etc

- Vanilla HTTP (aka pure HTTP)
    - Client sends a GET / request (GET does’t have body) to the Server (a sgement is sent)
        - Moves into a TCP segment
        - Then IP packet
    - The server has port 80 open
    - Segment is received and req is understood
    - App will respond back with headers/response headers (index.html)

- HTTPS (HTTP over TLS basically)
    - Open connection and first do a handshake
    - The goal of the handshake is to share symmetric keys, share encryption key - same key should exist on both the client and the server
    - Use keys to encrypt our GET / request from the client
    - server will receive the data that is encrypted and decrypt the data with the key
    - We encrpyt with symmetric key algorithms or asymmetric keys
    - symmetric key >> the key to encrypt and decrypt are both the same. Easy to do
    - asymmetric keys >> the keys to decrypt and ecnrypt are different
- TLS 1.2
    - The private key is used to encrypt the symmetric key
    - There was a heartbleed openSSL bug that happened in 2012, bug fixed in 2014 - interesting stuff tbh - people avoided RSA as an algorithm coz of this reason. It lacks forward secrecy

- Diffie Hellman (one of the best algos to exchange keys)
    - There are 2 private keys and 1 symmetric key
    - 1 private key for the client and 1 for the server

- TLS 1.3 improvements (currently the best candidate for all)
    - Improved version using Diffie Hellman algorithm (the maths behind it is interesting)
    - (g^x % n)^y = g^xy & n (left part of equation is done by the server because the server has the Y)
    - (g^y % n)^x = g^xy %n (left part of equation is done by the client because the server has the X)

## **HTTP/1.1**

- HTTP request
    - Method (GET, POST, PUT, DELETE, PATCH, OPTIONS)
    - Path (/, /about, etc etc)
    - Protocol (HTTP/HTTP 1.1, HTTP 1.2, gRPC)
    - Headers (key-value, like User-Agent, host header etc)
    - Body (GET request doesn’t have any, POST, DELETE and other methods do)
    - example: `curl -v http://google.com/about`

- HTTP response
    - Protocol (HTTP/1.1, HTTP/2)
    - Code (200, 301, etc etc)
    - Location: url
    - content-type: text/html
    - server: where site is hosted.
    
    HTTPS (port 444 is introduced here too) 
    
    - after TCP, do a TLS handshake
        - in TLS handshake, both the client and the server will agree on the symmetric key (and symmetric encryption is used here, much faster than asymmetric encryption)
        - same key encrypts and same key decrypts - because its same key used, key exchange is critical. so we use something called RSA or diffi hellman to exchange keys
        - then keys are used to encrypt the GET request and headers are sent back and content using encrypted keys
- HTTP 1.0
    - New TCP connection with each request (after each request, the connection is closed to save CPU & memory)
    - Slow
    - Bufferring (trasnfer-encoding: chubked didnt exist)
    - No multi-home websites (HOST header)
    
- HTTP 1.1
    - Persisted TCP connection: Connection is not closed immediately with each request. All use same TCP connection.
    - Low latency & Low CPU usage
    - HTTP request smuggling could happen. When server doesn’t know where requests end or start
    - Streaming with chunked transfer
    - Pipelining (can run multiple requests in parallel without having to wait for response. Disabled by default and not guaranteed it will work correctly
    - Proxying & multi-homed websites (1 IP can host 1000s of websites, the URL of the website is searched when looking for the site and not the IP)
    
- HTTP/2
    - Used to be called SPDY & invented by Google
    - Compression (both headers and the body). Header compression was disabled in HTTP/1 due to an attack called Crime (hackers were able to extract key info due to the way headers were compressed)
    - Multiplexing
    - Sever push
    - Secure by default (coz of protocol ossification)
    - Protocol negotiation during TLS

- HTTP over QUIC (HTTP/3)
    - Replaces TCP with QUIC (UDP with congestion control)
    - All HTTP/2 features
    - Without HOL (head of line blocking?)

## **Websockets**

- Bidirectional communication designed for the web
- Websockets are built on top of HTTP
- HTTP 1.0 (connection is not persistent, keeps closing), HTTP 1.1 (persisitent connection), then an opportunity for websockets coz connection is alive now
- Websocket proces
    - Open connection
    - Websocket handshake (just a HTTP request with a special semantic. You get a connection which now says your connection is now web sockety
    - Because the connection is alive, we can do loads of bidirectional communication. (This couldn’t be done with HTTP 1.0 coz connection is not always alive)
- Websockets handshake
    - ws:// or wss:// (secure version)
    - Client server example
        - Req for websocket
            - GET /chat HTTP/1.1
            - Host: server.exmaple.com
            - websocket
        - Response for ws
            - HTTP/1.1 - 101 Switching protocol code
            - Upgrade: websocket
            - Some more headers like key etc etc
- Use cases: chatting, live feed, multiplayer gaming, showing client progress/logging , whatsApp, discord
- Some other useful info; Ping Pong is sent frequently to keep the websocket connection alive.
- Pros & Cons
    - Pros:
        - Full duplex (no polling) - left and right - bidirectional comms
        - HTTP compatible (more friendly) (note: if you used TCP, you would have to build your own port)
        - Firewall friendly (standard)
    - Cons
        - Proxying is tricky (need to terminate websocket connection & read message & establish another websocket connection
        - L7 LB challenging (due to timeouts) (L4 LB can be done but kind of consuming on the backend)
        - Stateful (knowledge of both client and server), difficult to horizontally scale
- Do you have to use websockets?
    - No
    - Rule of thumb - do you absolutely need bidirectional comms
    - Long polling
    - Plus websockets have extra headers and stuff to be managed. Just extra stuff
    - Server Sent Events
    - Note: Clients are connected to 1 server where messages are received. No one is connected to each other directly except through server where messages are broadcasted
    - 

## **HTTP/2 (improved version of HTTP/1)**

- HTTP 1.1 recap
    - make req, you get 200, OK and get HTML docs (index.html, main.css, main.js, img1.jpg)
    - Browser can can use 6 concurrent request using 6 SEPARATE tcp connections (not sure why 6 but chrome picked it?)

- HTTP/2
    - Send all concurrent requests using same TCP connection.
    - Every request is tagged with a unique stream ID
    - Client uses odd stream ID numbers to send (thats how you know its the client sending
    - and the Server sends responses using an even stream ID number to send back responses
- HTTP/2 Push
    - legacy and not commonly used
    - Push mechanism is not scaleable
- Pros
    - Multiplexing over single connection (save resources - 1 connection instead of 6 resources like in HTTP/1.1)
    - Compress both headers and data/body
    - Server Push
    - secure by default (because of protocol ossification)
    - Protocol negotiataion during TLS
- Cons
    - TCP head of line blocking (when you send a request like 5/6 streams and you send in order, the TCP will label the bytes/segments in order. For e.g. if you send 10 requests and lets say the first req is dropped. If the server recieves req 2-10, the server will not process any of them.
    - Server push never picked up
    - High CPU usage
    
- Main reason why HTTP/2 was designed was because the client sends a lot of requests in the same connection. That’s the only reason why it was built. Because we want to send multiple requests concurrently.

## HTTP/3 - HTTP over QUIC multiplexed streams

- HTTP 1.1 recap
    - using 1 connection per request (slow)

- How HTTP/2 works? Recap
    - multiple streams for requests in 1 connection

- HTTP/2 cons recap
    - TCP head of line blocking
        - TCP segments must be delivered in order
        - but streams dont have to
        - blocking requests
- 

- How HTTP/3 & QUIC saves the day
    - HTTP/3 is built on top of QUIC (and QUIC is built on UDP)
    - like HTTP/2, QUIC has streams
    - but QUIC uses UDP instead
    - HTTP/3 streams - (the request are now datagrams instead of TCP segments)
        - QUIC manages the streams and sequences (its kind of like a “TCP connection” for each stream
- Pros
    - Merges connection setup & TLS in one handshake (secure by default), I want QUIC to be secure by default
    - TLS 1.3 and the handshake in one handshake. So one round trip give you a connection setup, the security and the encryption
    - Congestion control at stream level
    - Connection migration (coz UDP is stateless, we have to send the connectionID with every single packet we send. The connectionID is used to uniquely identify the connection. So multiple connections can be running. And coz we send the connectionID, every datagram is labelled with the connectionID, every datagram is labelled with the streamID
        - Interestingly, the connectionID is not encrypted and is in plaintext. There’s a paper talking about connection hijacking
    - Why not HTTP/2 over QUIC?
        - Header compression algorithm

- Cons
    - Takes a lot of CPU (due to parsing logic), more than HTTP/2
    - UDP could be blocked (sometimes proxies like in enterprise systems block UDP
    - IP fragmentation issues (coz QUIC uses UDP and UDP has no order etc, segments can be spoofed etc etc)
    - 

- Interesting; QUIC is actually the reverse of HTTP/2 - odd streams are server while even streams are the client
- QUIC is a connection based system. Yes it’s built on top of UDP, they built this virrtual connection concept at the endpoint

## **gRPC (Google remote procedural call)**

- built on top of HTTP
- takes advantage of HTTP/2 streams feattures to give various features such as bidirectional.
- All in 1 protocol??

- Client server comms
    - SOAP, REST< GraphQL
    - SSE, WebSockets
    - raw TCP
- Problerm with client librarries
    - each library has its own language
    - patching issues etc etc

- why gRPC was invvented?
    - one library for popular langs
        - 
    - Protocol: HTTP/2 (hidden implementation)
    - Message format: protocol buffers as format
- gRPC modes
    - unary RPC (basically req response)
    - server streaming RPC
    - client streaming RPC
    - bidirectional streaming RPC

- Pros
    - Fast & compact
    - One client library
    - Progress feedback (upload)
    - Cancel req (H2)
    - H2/protobuf

- Cons
    - Schema
    - Thick client
    - proxies are tricky to implement in gRPX but its been done
        - can do L7 LB/reverse proxy using nginx with gRPC but its tricky.
        - you can build a gRPC web proxy, where you can point your web app to the gRPC proxy and proxy will convert them into an actual gRPC course (like a sidecar pattern)
    - error handling (need to build your own, no native one)
    - no native browser support
        - (gRPC is entrenched to HTTP/2, uses low level calls to HTTP/2 streams)
        - those APIs dont exist in the browser because hte browser doesn’t expose them
        - 
    - timeouts (pub/sub)

- Can I write my own protocol?
    - yes, you can. Spotify did something similar. Look at “The Story of Whhy we migrate to gRPC and How We Go about it” talk in kubecon Europe 2019 (Matthias Gruter, Spotify)
    - Their protocol was called Herms (written in 2012, based on zeroMQ, JSON or Protobuf payload, not a PRC framework
    - Spotify moved to gRPC eventually not because of limitation of Hermes but because they are isoalated. gRPC is most popular.

- gRPC is most popular in microservices now. if 2 services want to talk to each other, the de-facto is gRPC.

## **Proxy & Reverse Proxy**

- Proxy
    - a server that makes requests on your behalf (client knows the server but server doesn’t know client)
    - your TCP is connection is being established with a proxy before going to the destination
    - establsh a TCP connection between you and the content client of Layer 7 will go to google.com. You send a GET / request and the request will go to google.com
    - `use case
        - caching, anonymity, logging, block sites, microservices
    - fiddler (mitmproxy, a common proxy to monitor your requests locally)
    - for a proxy
        - from a layer 4 (TCP) perspective, the proxy is the final destination
        - from a layer 7 (HTTP) perspective, the backend server is the final destination

- Reverse proxy (opposite of proxy) RP= reverse proxy
    - client does not know the final destination (the actual server the site is hosted where the request lands
        - so the client only knows that [google.com](http://google.com) is the final proxy (the frontend/edge server) but google.com routes requests to the google-server (backend servers) behind the scenes
    - load balancing was born from this
        - this reverse proxy server can load balance between the backend servers and use things like round robin and various other LB methods
        - the RP can even take requests to different servers based on the path youre going
            - so each server can be separated for different tools (one server for POST, another server for GET etc)
        - so a load balancer is reverse proxy but not every reverse proxy is a load balancer
        - an PR is just that it makes request to something on the backend you don’t know about
        - for a reverse proxy
            - from  a lyer 4 and layer 7 perspective, the reverse proxy is the final destination
        - Use cases
            - caching/CDN (cdn is basically a glorified reverse proxy)
            - load balancing (balance your request to multiple servers on the backend)
            - ingress
            - canary deployment
            - micro services
        - can proxy and reverse proxy be used at the same time?
            - yes but you won’t know
        - Can i use proxy instead of VPN for anonymity?
            - no, its not a good idea because some proxies terminate aliases and look at your content
            - VPN operate at the IP level. so any IP packet, they encrypt
            - Proxy operates at L4 and above so it needs to know about ports and protocol
        - Is proxy just for HTTP traffic?
            - not really there are many types of proxies but HTTP is the most popular
            - there is a mode when you use HTTPS proxy called tunnel mode: where the client can ask the proxy to open a connection for it
                - tunnel mode: research this!

## **Layer 4 & Layer 7 Load Balancers**

- A load balancer is a reverse proxy, its just one case of a reverse proxy  that happens to have logic to balance request between multiple backends on the backend, while a reverse proxy doesn’t have to balance, it makes requests on your behalf (but the RP doesn’t have balancing logic necessarily
- So every load balancer is a reverse proxy but not every reverse proxy is a load balancer

- L4 vs L7

- Load balancer (aka fault tolerant system)
    - LB/reverse proxy starts multiple TCP connections with each backend server (this is known as warrming up, keeping things hot) -
    

### **Layer 4 LB (L4 is stateful)**

- when a client connects to the L4 LB, the LB chooses one server and all segments for that connections go that server. That connection will have state and it will tag it to one and only 1 connection coz L4 only deals with ports, IP addresses
- there’s also something called a NAT mode which makes everything into a single TCP connection
- TCP connection is taken to reverse proxy then the reverse proxy rewrites it into a brand new TCP connection

- Pros
    - simpler load balancing (simple coz it doesn’t do with the data and mainly the ports, IP addresses and TCP connections, does not understand L7 content is)
    - efficient (no data lookup, just looks at ports and IPs)
    - more secure (with L7, data needs to be decrypted and encrypted but in L4 none of that is needed coz its end to end)
    - works with any protocol (coz it doesn’t look at the content, its agnostic. you send segments and it sends it back to the server)
    - one TCP connection (NAT)

- Cons
    - No smart load balancing
    - Not applicable for micro services
    - Sticky per connection (requests only go to one connection per server)
    - No caching (coz you dont know what data is there, cant cache)
    - Protocol unaware (can be dangerous) bypass rules - instead you need to play with ports

- If you are using L7 and want to support any protocol you use move to L4
    - but once you move to L4, any L7 LB logic you have like blocking users or any auth methods, block certain headers, you cant do anymore of that
- and you can just downgrade the protocol using the HTTP UPGRADE method for other protocols.
    - 

### **Layer 7 LB**

- same concept, uses TCP connection
- when a client connects to the L7 LB, it becomes protocol specific. Any logical “request” will be forwarded to a new backend server. This could be more one or more segments
    - logical requests will be buffered and will be loaded by the L7 LB in the middle
    - the data needs to be read and if it’s encrypted, it needs to decrypt the data
    - and to decypt the data, you need to have a secure connection between you and the LB server
    - that means if you ever want to host a site, the cert has to live in the L7 LB. People dont like that coz your private key has to live in the L7
- the LB parses and understands the segments. HTTP is stateless so i can pick another server
- and this is how the HTTP smuggling attacks happen

- Pros
    - Smart load balancing (due to paths, diff rules) like you are going to /about, i can take you to this server and if you’re going to /contactus, i can take you to this server etc
    - Caching/CDN -
    - Great for micro services
    - API gateway logic
    - Auth

- Cons
    - Expensive (looks at data, decrypt, encrypt)
    - Decrypts (decrypting content, terminates the address, so it terminates TLS - thats why its called TLS Terminator) - L7 LB is always called TLS terminator coz it always terminates connection
    - 2 TCP connections (not sure if its really a con)
    - must share TLS cert
    - Needs to buffer (it needs to read the request once it arrives from the client, LB can be a bottleneck and could slow things down)
    - needs to understand the protocol (people always ask NGINX and HAProxy to support different protocols - YOU simply cannot do L7 LB if the LB does not understand the protocol) we need to undestand the protocol coz we are reading the data so we need to know how to read and respond to the data.

## **Many ways to HTTPS**

**HTTP Communication basics**

- Establish connection with backend
- establish encryption (HTTPS right. TLS!)
- Send data
- Close connection (when done)

**HTTPS over TCP with TLS1.2**

- TCP connect (syn syn/ack ack) >> establish TCP connection
- handshake (client hello, server hello, client fin, server fin) >> client and server do handshake in order to agree on symmetric key. They both do key exchange algorithm and both have the symmetric key for encrypting and decrypting
- data send (GET /, 200 OK)

**HTTPS over TCP with TLS 1.3**

- same as HTTPS over TCP with TLS 1.2 but with one less roundtrip (on the key exchange part)
- better to use TLS 1.3 unless you have a backward compatibility issue

**HTTPS over QUIC aka HTTP/3** 

- the 3 way handshake and the TLS handshake happens in the same router. It’s a matter of carrying the same packets in the same time
- so we effectively combined TLS 1.3 with the handshake of QUIC
- all of it is built on UDP
- so all of the requests are a bunch of UDP segments - datagrams going back and forth

**HTTPS over TFO with TLS 1.3 (TCP Fast Open, not really secure)**

- 

**HTTP over TCP with TLS1.3 0RTT (0 round trip)**

- if a prior TLS connection existed between client and server, a pre shared key could have been shared to the client
- 0 round trip so less waiting time so less latency

**HTTPS over QUIC 0RTT**

- if pre shared key was shared before and client knows about it, it can effectively send the QUIC handshake
- This is the fastest you can go. You can set the connection req for QUIC, in the same breath, send TLS - use pre-shared key to encrypt and also send GET req in the same breath.
- if this can be done, you can get extreme response time! very very fast
- so far only Cloudflare can manage to do this effectively in their environment (read article by Cloudflare called “Even faster connection with QUIC 0-RTT resumption”
- This is quite difficult to do but really fast.

## **Backend execution patterns**

**Process (PID)**

- a set of instructions (run one by one)
- has an isolated memory (no other process can read from this memory locaiton or access it)
- has a PID (each procss has its own unique identifier)
- scheduled in the CPU

**Threads**

- a lightweight process (based on Linux) - its just a process that inherits memory from its parent (LWP)
- a set of instructions
- shares memory with parent process
- has a ID

- single threaded process
    - one process with a single thread
    - simple
    - examples node JS

- multi processes
    - app has multiple processes
    - each has its own memory
    - examples NGINX/Postgres
    - takes advantage of multi-cores

PAUSE on this topic

## **NGINX**

What is Nginx?

- web server
    - serves web content
    - listens on an HTTP endpoint

- reverse proxy
    - load balancing
    - backend routing
    - Caching
    - API gateway

- concepts
    - nginx frontend: communication with the client
    - nginx backend: communication with the backend servers

- L4 and L7 recap
    - L4 (TCP)
        - IP, TCP, ports
    - L7 (HTTP)
        - more context, app info, HTTP req etc

- TLS Termination
    - Nginx has TLS
    - NGINX terminates TLS, decrypts, optionally rewrite and then re-encrypt the content to the backend
    - need to look at a method of creating certs or vertifying the nginx - nginx can create its own key or cert?

- TLS passthrough
    - backend is TLS
    - NGINX proxies/streams the packets directly to the backende
    - just like a tunnel - the nginx does not decrypt any data
    - no cahcing, L4 check only but more secure. NGINX doesn’t need the backend cert here.
        - here you cant cache coz the nginx cant see the L7 content anymore. so only pure L4 checks only

### Stateless vs Stateful firewalls

- Client to server comms
    - Req is outbound from the CLIENT perspective
    - Req is inbound from the SERVER perspective
- Stateless firewall
    - A stateless firewall means it doesn’t understand the state of connections
    - It sees the request and response as two separate parts
    - So you need to think about allowing and denying as two parts. So 1 inbound rule and 1 outbound rule.
    - Note: We always use a random ephemeral port for the client. Because the firewall is stateless, it has no way of knowing which specific port is used for the response. So you’ll often have to allow the full range of ephemeral ports to any destination. This makes security engineers uneasy. Which is why stateful firewalls are much better.
- Stateful firewall
    - A stateful firewall is intelligent enough to identify the REQUEST and RESPONSE components of a connection as being related. Stateful means lower admin overhead.
    - You also don’t need to allow the full ephemeral port range because the firewall can identify which port is being used and implicitly allow based on it being the response to a request that you allow.


