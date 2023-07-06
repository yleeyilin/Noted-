const express = require('express');
const { exec } = require('child_process');
const app = express();
const port = 3000; 

app.use(express.json());

app.post('/calculate-similarity', (req, res) => {
    const { article1, article2 } = req.body;
  
    const command = `python3 /Users/leeyilin/Noted-/noted/lib/model/recommendation/topicmodelling.py '${article1}' '${article2}'`;
  
    exec(command, (error, stdout) => {
      if (error) {
        console.error(`Error executing Python script: ${error}`);
        res.status(500).send('Error executing Python script');
        return;
      }
  
      const similarityScore = parseFloat(stdout.trim());
      res.json({ similarityScore });
    });
  });
  

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
