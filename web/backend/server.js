// This content was generated in whole or part with the assistance of an AI model.

const express = require('express');
const app = express();
const PORT = process.env.PORT || 5000;

app.get('/', (req, res) => {
  res.send('AI Attribution Backend');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
