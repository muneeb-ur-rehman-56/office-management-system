require("dotenv").config();
const express = require("express");
const helmet = require("helmet");
const morgan = require("morgan");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(helmet({ contentSecurityPolicy: false }));
app.use(morgan("dev"));
app.use(express.json({ limit: "2mb" }));
app.use(express.static(path.join(__dirname, "../public")));

app.get("/api/health", (_req, res) => {
  res.json({ ok: true, app: "Office Management System", mode: "local-demo" });
});

app.get("*", (_req, res) => {
  res.sendFile(path.join(__dirname, "../public/index.html"));
});

app.listen(PORT, () => console.log(`Office Management System running at http://localhost:${PORT}`));
