import mysql from "mysql2"

export const db = mysql.createConnection({
  host:"localhost",
  user:"root",
  password: "Dhruv@#$1234",
  database:"blog"
})

// Check connection
// db.connect((err) => {
//   if (err) {
//     console.error("Error connecting to the database:", err.message);
//     return;
//   }
//   console.log("Connected to the MySQL database successfully!");
// });