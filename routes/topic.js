var express = require('express');
var router = express.Router();
var conn = require('../model/config');
var flash  = require('express-flash');

/*Add Topic*/
router.get('/course/:courseId/create-topic', function (req, res) {
  res.locals.account = req.session.account;
  var sql = `SELECT * from course_tbl WHERE course_id =  (SELECT course_id from loading_tbl WHERE course_id=${req.params.courseId} AND teacher_id=${req.session.userId})`;
  conn.query(sql, function(err, result) {
      if (err) {
        console.log(err);
        res.send(err);
      }else{
        if(result.length>0){
          res.render('pages/create-topic',{
            title: 'Create Topic',
            status:req.session.userId,
            accountType: req.session.accountType,
            course:result[0]
          });
        }else{
          res.render('pages/create-topic',{
            title: 'Create Topic',
            status:req.session.userId,
            accountType: req.session.accountType,
            course:null
          });
        }
      }
  });

});

router.post('/course/add-topic', function (req, res) {
  var TopicInfo={
      'teacher_id':req.session.userId,
      'course_id':req.body.courseid,
      'lo_topic':req.body.lo_topic,
      'lo_desc':req.body.lo_desc,
      'lo_time': parseInt(req.body.lo_time)
  }

  conn.query('INSERT INTO learning_tbl SET ?', TopicInfo, function(err, result) {
      //if(err) throw err
      if (err) {
          console.log(err);
          res.send(err);
      } else {
          res.redirect('/course/'+req.body.courseid);
      }
  });
});

/*Update Topic*/
router.get('/course/:courseId/edit-topic/:loId', function (req, res) {
  res.locals.account = req.session.account;
  var sql = `SELECT * from learning_tbl WHERE lo_id =  ${req.params.loId} AND teacher_id=${req.session.userId} AND course_id=${req.params.courseId}`;
  var sql2 = `SELECT * from question_tbl WHERE teacher_id=${req.session.userId} AND course_id=${req.params.courseId} AND lo_id =  ${req.params.loId}`;
  conn.query(sql, function(err, result) {
      if (err) {
        console.log(err);
        res.send(err);
      }else{
          conn.query(sql2, function(err, result2) {
          if (err) {
            console.log(err);
            res.send(err)
          }else{
            if(result.length>0){
              res.render('pages/edit-topic',{
                title: 'Edit Topic',
                status:req.session.userId,
                accountType: req.session.accountType,
                topic:result[0],
                questions:result2,
                course_name:req.session.course_name,
                result_length:result2.length

              });
            }else{
              res.render('pages/edit-topic',{
                title: 'Edit Topic',
                status:req.session.userId,
                accountType: req.session.accountType,
                topic:null,
                questions:null,
                course_name:req.session.course_name
              });
            }
          }
        });
    }
  });
});

router.post('/course/update-topic', function (req, res) {
  var TopicInfo={
      'lo_topic':req.body.lo_topic,
      'lo_desc':req.body.lo_desc,
      'lo_time': parseInt(req.body.lo_time)
  }

  conn.query(`UPDATE learning_tbl SET ? WHERE lo_id=${req.body.lo_id} AND teacher_id=${req.session.userId}`, TopicInfo, function(err, result) {
      //if(err) throw err
      if (err) {
          console.log(err);
          res.setHeader('Content-Type', 'text/html');
          res.end(String(err));
      } else {
          res.setHeader('Content-Type', 'text/html');
          res.end('Update Success');
      }
  });
});

/*Search Topics*/
router.post('/search-topic', function(req, res) {
  var keyword = req.body.keyword;
  var course_id = req.body.course_id;
  var sql = `SELECT * from learning_tbl WHERE (lo_topic like '%${keyword}%' OR lo_time like '%${keyword}%') AND course_id=${course_id} AND teacher_id=${req.session.userId}`;
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
      res.send(err);
    }else{
      console.log(result);
      if(result.length>0){
        res.send(result);
      }else{
        res.send('0');
      }
    }
  });
});

/*Delete Topic*/
router.post('/delete-topic/:id', function(req, res) {
  var sql = `DELETE from learning_tbl WHERE lo_id=${req.params.id} AND teacher_id=${req.session.userId}`;
  console.log(sql);
  conn.query(sql, function (err, result) {
    if (err){
      console.log(err);
    }else{
      console.log("Number of records deleted: " + result.affectedRows);
      res.send(result);
    }
  });
});
module.exports = router;
