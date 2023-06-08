const express = require("express");
const app = express();

app.use(express.json());
app.use("/api", require("./routes/app.routes"));

app.listen(3000, function() {
    console.log("AWS Server Ready!");
})