# README

* Ruby version: 2.6.5

* Services (job queues, cache servers, search engines, etc.)
    
      *->using rabbitmq as a quining system
      *->using redis as a cache 
      *->using elastic search as a search engine 
      *->using MYSQL as a database 

* Deployment instructions:
      
      1-> downloading the repo using git clone
      2-> getting in the directory
      3-> running the docker-compose up command 
      
* how to use 
      * using postman 
          ->creating an app 
            * POST :  http://localhost:3001/applications
          
          
          ->creating a chat in an app
            * POST :  http://localhost:3001/applications/(the token returned in the app creation)/chats
            
            * Body of request : {"chat" : {"AppToken":"(the token returned in the app creation)"}}
            
            * set content type : application/json in the headers
          
          
          ->creating a message in a chat
            * POST : http://localhost:3001/applications/(the token returned in the app creation)/chats/(number of chat returned in chat creation)
            
            * Body of request : {"chat" : {"content":"(content to be put)"}}
            
            * set content type : application/json in the headers
          
          
          ->seeing an app details
            * GET : http://localhost:3001/applications/(the token returned in the app creation)
          
          
          ->seeing chats of an app
            * GET : http://localhost:3001/applications/(the token returned in the app creation)/chats
          
          
          ->seeing a chat details
          * GET : GET : http://localhost:3001/applications/(the token returned in the app creation)/chats/(number of chat returned in chat creation)
          
          
          ->seeing messages of a chat
          * GET : http://localhost:3001/applications/(the token returned in the app creation)/chats/(number of chat returned in chat creation)/messages
          
          
          ->updating an app
          * PATCH : http://localhost:3001/applications/(the token returned in the app creation)?name=(name to be updated)
            
          
          
          ->updating a message
            * PATCH :  http://localhost:3001/applications/(the token returned in the app creation)/chats/(number of chat returned in chat creation)/messages/(number of message returned in message creation)?query=(content to be updated to )
            
          
          ->searching a message in a chat of an app
            * GET : http://localhost:3001//applications/(the token returned in the app creation)/chats/(number of chat returned in chat creation)/search?query=(word to search for )
