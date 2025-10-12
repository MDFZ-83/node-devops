const express = require("express");
const app = express();

app.get("/" , (req , res) => res.send("hello welcome to my DevOps project"));

app.listen(3000 , ()=> console.log("app run on port 3000"))

