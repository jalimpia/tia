var express = require('express');
var router = express.Router();
var conn = require('../model/config');
var flash  = require('express-flash');
var SHA256 = require('crypto-js/sha256');

/*Add Question*/
router.post('/course/question/:action', function (req, res) {
      var current_date = (new Date()).valueOf().toString();
      var random = Math.random().toString();

      question_identifier = SHA256(req.body.teacher_id + req.body.course_id + req.body.lo_id + current_date + random);

      var exam_id= req.body.exam_id==undefined?null:req.body.exam_id;

      /*Add Question*/
      if(req.params.action=='add'){
        var QuestionInfo={
            'teacher_id':req.body.teacher_id,
            'course_id':req.body.course_id,
            'lo_id':req.body.lo_id,
            'exam_id':exam_id,
            'question_name':req.body.question_name,
            'question_identifier':question_identifier,
            'question_pts': parseInt(req.body.question_pts),
            'question_desc': req.body.question_desc,
            'question_pa_1': req.body.question_pa_1,
            'question_pa_2': req.body.question_pa_2,
            'question_pa_3': req.body.question_pa_3,
            'question_pa_4': req.body.question_pa_4,
            'question_correct': req.body.question_correct
        }
        if(exam_id){
          console.log(exam_id);
          var ItemInfo = {
            'exam_id':exam_id,
            'lo_id':req.body.lo_id,
            'item_no':req.body.item_no,
            'question_id':question_identifier
          }
          var unset='';
          if(req.body.question_identifier_old){
            unset += `UPDATE question_tbl SET exam_id=NULL WHERE question_identifier='${req.body.question_identifier_old}';`;
          }

          conn.query(`${unset}INSERT INTO question_tbl SET ?; UPDATE items_tbl SET ? WHERE exam_id='${exam_id}' AND lo_id=${req.body.lo_id} AND item_no=${req.body.item_no};`, [QuestionInfo, ItemInfo], function(err, result) {
              //if(err) throw err
              if (err) {
                  res.send(err);
                  console.log(err);

              } else {
                  res.setHeader('Content-Type', 'text/html');
                  res.end(String(question_identifier));
                  //res.redirect('/course/'+req.body.course_id);
              }
          });
        }else{
          conn.query(`INSERT INTO question_tbl SET ?`, QuestionInfo, function(err, result) {
              //if(err) throw err
              if (err) {
                  res.send(err);
                  console.log(err);

              } else {
                  res.setHeader('Content-Type', 'text/html');
                  res.end(String(question_identifier));
                  //res.redirect('/course/'+req.body.course_id);
              }
          });
        }
      }

      /*Update Question*/
      if(req.params.action=='update'){
          if(exam_id){
            var QuestionInfo={
                'teacher_id':req.body.teacher_id,
                'course_id':req.body.course_id,
                'lo_id':req.body.lo_id,
                'exam_id':exam_id,
                'question_name':req.body.question_name,
                'question_identifier':req.body.question_identifier,
                'question_pts': parseInt(req.body.question_pts),
                'question_desc': req.body.question_desc,
                'question_pa_1': req.body.question_pa_1,
                'question_pa_2': req.body.question_pa_2,
                'question_pa_3': req.body.question_pa_3,
                'question_pa_4': req.body.question_pa_4,
                'question_correct': req.body.question_correct
            }

            var qid = req.body.question_identifier;
            if(qid=='new'){
              qid=question_identifier;
            }
            var ItemInfo = {
              'exam_id':exam_id,
              'lo_id':req.body.lo_id,
              'item_no':req.body.item_no,
              'question_id':qid,
              'visibility':1
            }

            var unset='';
            if(req.body.question_identifier_old){
              unset += `UPDATE question_tbl SET exam_id=NULL WHERE question_identifier='${req.body.question_identifier_old}';`;
            }

            conn.query(`${unset} UPDATE question_tbl SET ? WHERE question_identifier='${req.body.question_identifier}';UPDATE items_tbl SET ? WHERE exam_id='${exam_id}' AND lo_id=${req.body.lo_id} AND item_no=${req.body.item_no};`, [QuestionInfo, ItemInfo], function(err, result) {
                //if(err) throw err
                if (err) {
                    console.log(err);
                    res.setHeader('Content-Type', 'text/html');
                    //res.send(err);
                    res.end(String(err));
                    //res.redirect('/');
                } else {
                    res.setHeader('Content-Type', 'text/html');
                    res.end(String(qid));
                    //res.redirect('/course/'+req.body.course_id);
                }
            });
        }else{
          var QuestionInfo={
              'question_name':req.body.question_name,
              'question_identifier':req.body.question_identifier,
              'question_pts': parseInt(req.body.question_pts),
              'question_desc': req.body.question_desc,
              'question_pa_1': req.body.question_pa_1,
              'question_pa_2': req.body.question_pa_2,
              'question_pa_3': req.body.question_pa_3,
              'question_pa_4': req.body.question_pa_4,
              'question_correct': req.body.question_correct
          }
          conn.query(`UPDATE question_tbl SET ? WHERE question_identifier='${req.body.question_identifier}'`, QuestionInfo, function(err, result) {
              //if(err) throw err
              if (err) {
                  console.log(err);
                  res.setHeader('Content-Type', 'text/html');
                  //res.send(err);
                  res.end(String(err));
                  //res.redirect('/');
              } else {
                  res.setHeader('Content-Type', 'text/html');
                  res.end(String(req.body.question_identifier));
                  //res.redirect('/course/'+req.body.course_id);
              }
          });
        }
      }
});


/*Delete Question*/
router.post('/course/question/delete/:id/:tid/:cid/:lid', function (req, res) {
    conn.query(`DELETE from question_tbl WHERE question_identifier = '${req.params.id}' AND teacher_id=${req.params.tid} AND course_id=${req.params.cid} AND lo_id=${req.params.lid}`, function(err, result) {
        //if(err) throw err
        if (err) {
          res.setHeader('Content-Type', 'text/html');
          res.end(String(err));
          console.log(err);
        } else {
            res.setHeader('Content-Type', 'text/html');
            res.end('Deleted');
            //res.redirect('/course/'+req.body.course_id);
        }
    });
});

/*Delete Question from items_tbl*/
router.post('/course/question/delete/:id/:tid/:cid/:lid/:examId', function (req, res) {
    conn.query(`UPDATE items_tbl SET question_id = NULL WHERE question_id = '${req.params.id}' AND lo_id=${req.params.lid} AND exam_id = '${req.params.examId}'; UPDATE question_tbl SET exam_id = NULL WHERE question_identifier='${req.params.id}'`, function(err, result) {
        //if(err) throw err
        if (err) {
          console.log(err);
          res.setHeader('Content-Type', 'text/html');
          res.end(String(err));
        } else {
            res.setHeader('Content-Type', 'text/html');
            res.end('Deleted');
            //res.redirect('/course/'+req.body.course_id);
        }
    });
});


router.post('/course/:courseId/load-questions/:loId', function (req, res) {
    conn.query(`SELECT * from question_tbl WHERE exam_id IS NULL AND course_id = ${req.params.courseId} AND lo_id=${req.params.loId} AND teacher_id = ${req.session.userId}`, function(err, result) {
        //if(err) throw err
        if (err) {
          console.log(err);
          res.setHeader('Content-Type', 'text/html');
          res.end(String(err));
        } else {
            res.send(result);
        }
    });
});

/*Load Single Question*/

router.post('/question/:courseId/single-question/:examId/:qid', function (req, res) {
  var sql = `SELECT * from question_tbl WHERE question_identifier='${req.params.qid}' AND course_id = ${req.params.courseId} AND exam_id = '${req.params.examId}'`;
  conn.query(sql, function(err, result) {
    //if(err) throw err
    if (err) {
      console.log(err);
      res.setHeader('Content-Type', 'text/html');
      res.end(String(err));
    } else {
        res.send(result[0]);
    }
  });
});

/*Random Pick question*/
var MSWS = require('msws');
var prng = new MSWS();
var seed = prng.getSeed();
//prng.setSeed(seed);
prng.setSeed(new Date().getTime());

router.post('/random/question/:loId/:qid', function (req, res) {
  //var sql = `SELECT * from question_tbl WHERE lo_id=${req.params.loId} AND question_identifier <> '${req.params.qid}' AND teacher_id = ${req.session.userId}`;
  var sql = `SELECT * from question_tbl WHERE lo_id=${req.params.loId} AND exam_id IS NULL AND teacher_id = ${req.session.userId}`;
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
      res.setHeader('Content-Type', 'text/html');
      res.send(String(err));
    }else{
      if(result.length>0){
          q_index = prng.getInt(result.length, 0)
          res.send(result[q_index%result.length]);
          console.log(q_index);
      }else{
          res.send('0');
      }
    }
  });
});

module.exports = router;
