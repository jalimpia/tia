var express = require('express');
var router = express.Router();
var conn = require('../model/config');


/* Display Courses. */
router.get('/dashboard', function(req, res, next) {
    conn.query(`SELECT * from course_tbl WHERE course_id IN(SELECT course_id from loading_tbl where teacher_id=${req.session.userId}) ORDER BY course_id ASC`, function (err, rows, fields) {

      if (err){
        console.log(err);
        res.redirect('/');
      }else{
        res.locals.account = req.session.account;
        if(req.session.accountType==1){
          res.render('pages/dashboard', { title: 'Dashboard', 'status':req.session.userId,accountType: req.session.accountType, 'results':rows });
        }else{
          res.render('student/dashboard', { title: 'Student Dashboard', 'status':req.session.userId, accountType: req.session.accountType, 'results':rows});
        }
      }
    });
});
module.exports = router;
