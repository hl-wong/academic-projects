const mongoose = require("mongoose");
const url = "MONGODB URL";

const connectDB = async () => {
  mongoose
    .connect(url)
    .then(() => console.log("Database is connected"))
    .catch((e) => console.log(e));
};

module.exports = connectDB;
