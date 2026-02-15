📥 Install Dependencies

Run the following command to install required packages:

npm install

▶️ Run the Application Locally
Start the service
npm start


This runs:

node src/app.js


Service will start on:

http://localhost:3000

Run in Development Mode (Auto Reload)

Install nodemon:

npm install --save-dev nodemon


Run:

npm run dev

📌 API Endpoints
Health Check
GET /health


Example:

curl http://localhost:3000/health


Response:

{ "status": "UP" }

Send Notification
POST /notify


Example:

curl -X POST http://localhost:3000/notify \
-H "Content-Type: application/json" \
-d '{"user":"Ranjith","message":"Hello from Notification Service!"}'


Response:

{ "status": "sent" }

📦 Build & Package the Application
✅ Package as a Tar/Zip (VM Deployment)
Install only production dependencies
npm install --production

Create tarball package
tar -czvf notification-service.tar.gz .

🐳 Package with Docker (Recommended)
Step 1: Build Docker Image
docker build -t notification-service .

Step 2: Run Docker Container
docker run -p 3000:3000 notification-service


App will be available at:

http://localhost:3000

✅ Production Notes

Uses environment variable for port:

PORT=4000 npm start


Includes /health endpoint for Kubernetes probes