const express = require("express");
const logger = require("./logger");

const app = express();
app.use(express.json());

//Health Endpoint

app.get("/health", (req, res) => {
  res.status(200).json({
    status: "UP",
    service: "notification-service"
  });
});

// Main Notify API
app.post("/notify", (req, res) => {
  const { user, message } = req.body;

  // Basic validation
  if (!user || !message) {
    return res.status(400).json({
      error: "user and message are required"
    });
  }

  logger.info(`Notify ${user}: ${message}`);
  res.json({ status: "sent" });
});

// Port configuration 

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  logger.info(`Notification service running on port ${PORT}`);
});
