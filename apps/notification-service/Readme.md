Install Dependencies

Run the following command to install required packages:

npm install

Run the Application Locally:

Start the service
npm start


This runs:

node src/app.js


Service will start on:

http://localhost:3000


Send Notification
POST /notify

Example:

curl -X POST http://localhost:3000/notify \
-H "Content-Type: application/json" \
-d '{"user":"Ranjith","message":"Hello from Notification Service!"}'


Response:

{ "status": "sent" }


