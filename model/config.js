var mysql = require('mysql');

var connection = mysql.createPool({
   connectionLimit : 10,
   host     : 'localhost',
   user     : 'root',
   password : '',
   database : 'tia_db',
   multipleStatements: true
});

connection.getConnection(function(err) {
    if (err){
      console.log(err)
    }else{
      console.log('Connected to the MySQL server.');
    }
});

module.exports = connection;
