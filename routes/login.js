var express = require('express');
var router = express.Router();
var conn = require('../model/config');
var flash  = require('express-flash');

/* Login Route */
router.post('/login', function(req, res) {

  var Account={
      'username':req.body.username,
      'password':req.body.password
  }

  // insert query
  conn.query(`SELECT * from user_tbl WHERE username ='${Account.username}' AND password ='${Account.password}'`, function(err, rows, fields) {
      if (err) {
          req.flash('error', err);
          res.redirect('/');
      } else {
          // if user not found
          if (rows.length <= 0) {
              req.flash('error', 'Account not found, please try again!');
              res.redirect('/');
          }else{
          /*Initialize Session*/
          req.session.userId = rows[0].teacher_id; //set user id
          req.session.accountType = rows[0].account_type; //account type
          req.session.user = rows[0].username;//set user name
          req.session.account = rows[0];
          res.redirect('/dashboard');
          }
      }
  });

});

/* Signup route */
router.post('/signup', function(req, res) {

  var Account={
      'fname':req.body.fname,
      'lname':req.body.lname,
      'email':req.body.email,
      'username':req.body.username,
      'password':req.body.password,
      'department':req.body.department
  }

  // insert query
  conn.query('INSERT INTO user_tbl SET ?', Account, function(err, result) {
      //if(err) throw err
      if (err) {
          req.flash('error',err);
          res.redirect('/');
      } else {
          req.flash('success','You have successfully registered.');
          res.redirect('/');
      }
  });

});

/* Update Account */
router.post('/update-account', function(req, res) {

  var Account={
    'fname':req.body.fname,
    'lname':req.body.lname,
    'email':req.body.email,
    'username':req.body.username,
    'password':req.body.password,
    'department':req.body.department
  }

  // insert query
  conn.query(`UPDATE user_tbl SET ? WHERE teacher_id=${req.session.userId}`, Account, function(err, result) {
      //if(err) throw err
      if (err) {
          res.send('error',err);
          console.log(err);
      } else {
          req.session.account = Account;
          res.locals.account = req.session.account;
          res.redirect('/dashboard');
      }
  });

});

module.exports = router;
