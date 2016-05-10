Intro

Erlang broadcast is a trivial application that broadcasts datat to multiple customer websites using SSE.   
To broadcast data a JSON message must be posted into the backend service, this will then be 'broadcast' to all connected SSE
clients.  To provide control on what is broadcast to who, all data can be posted to a challen (or ID) and accordingly all clients 
subscribe to a single channel.

Build

to Compile the project run 'Make'
to run the project locally run 'start.sh dev'


SSE - 

curl localhost:8282/sse/101


webpage 

http://localhost:8282/sb/handball.html?id=101


POST 

http://localhost:8282/state/101

{ "id": 101, "team1": { "name": "fred", "first": 1, "second": 1 }, "team2": { "name": "bob", "first": 2, "second": 1 } }



