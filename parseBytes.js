 // file: createBytes.js
 const ethers = require('ethers');

 async function createBytes(args) {
     const name = args[0]; // get the string value to be converted 
 const bytes = ethers.utils.formatBytes32String(name); // uses a library function for the conversion 
 console.log("Bytes: ", bytes); // prints the value to the console 
 }
 
 createBytes(process.argv.slice(2)); // get environment variables as inputs 