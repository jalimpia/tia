var express = require('express');
var router = express.Router();
var conn = require('../model/config');
var SHA256 = require('crypto-js/sha256');


/*Load Learning Objectives*/
router.post('/course/:courseId/load-exam', function(req, res) {
    var sql = `SELECT * from learning_tbl WHERE course_id = ${req.params.courseId} AND teacher_id=${req.session.userId}`;
    conn.query(sql, function(err, result) {
        if (err) {
          console.log(err);
        }else{
          res.send(JSON.parse(JSON.stringify(result)));
        }
        //console.log(result)
    });
});





/*Create Exam*/
router.post('/course/:courseId/create-exam', function(req, res) {
    var data = JSON.parse(req.body.exam_lo);
    data = data.filter(function(x) { return x !== null });
    var total_time = 0;
    for(var i=0; i<data.length; i++){
      total_time+=data[i].lo_time;
    }
    var json_data = [];
    var total_item = req.body.exam_items;
    for(var i=0; i<data.length; i++){
      percent_test_item = data[i].lo_time / total_time;
      no_test_item_per_lo = Math.round(total_item * percent_test_item);
      json_data.push({"lo_id": data[i].lo_id, "n_test_item": no_test_item_per_lo, "lo_topic": data[i].lo_topic });
    }

    var total=0;
    for(var i=0; i<json_data.length; i++){
      total+=json_data[i].n_test_item;
    }

    if(total > total_item){
      var n = (total - total_item);
      json_data[data.length-1].n_test_item = (json_data[data.length-1].n_test_item - n);
    }

    if(total < total_item){
      var n = (total_item - total);
      json_data[data.length-1].n_test_item = (json_data[data.length-1].n_test_item + n);
    }

    var newtotal=0;
    for(var i=0; i<json_data.length; i++){
      newtotal+=json_data[i].n_test_item;
    }

    console.log(json_data);
    console.log(total);
    console.log(newtotal);
    var current_date = (new Date()).valueOf().toString();
    var random = Math.random().toString();
    var exam_id = SHA256(req.session.userId + req.params.courseId + current_date + random);
    var ExamInfo={
        'exam_id':exam_id,
        'teacher_id':req.session.userId,
        'course_id':req.params.courseId,
        'exam_title':req.body.exam_title,
        'exam_items':req.body.exam_items,
        'exam_instruction':req.body.exam_instruction,
        'exam_time':req.body.exam_time,
        'exam_lo': JSON.stringify(json_data)
    }

    var current_date = (new Date()).valueOf().toString();
    var random = Math.random().toString();
    var sql = '';
    var counter = 1;

    for(var i=0; i<json_data.length; i++){
      for(var j=0; j<json_data[i].n_test_item; j++){
        sql+=`INSERT INTO items_tbl (exam_id,lo_id,item_no,question_id,visibility) values ('${exam_id}', ${json_data[i].lo_id}, ${counter}, NULL, 1);`;
        counter++;
      }
    }


    conn.query(`INSERT INTO exam_tbl SET ?; ${sql}`, ExamInfo, function(err, result) {
        //if(err) throw err
        if (err) {
            res.setHeader('Content-Type', 'text/html');
            res.end(String(err));
            console.log(err);
        } else {

            res.redirect('/course/'+req.params.courseId+'#examinations');
            console.log('success')
        }
    });



});

/*List all the exams*/
router.post('/course/:courseId/fetch-exam', function(req, res) {
  var sql ='';
  if(req.session.accountType==1){
   sql = `SELECT * from exam_tbl WHERE course_id = ${req.params.courseId} AND teacher_id=${req.session.userId}`;
  }else{
   sql = `SELECT * from exam_tbl WHERE course_id = ${req.params.courseId} AND exam_published=1`;
  }
  conn.query(sql, function(err, result) {
      if (err) {
          res.send(err);
          console.log(err);
      }else{
          res.send(JSON.parse(JSON.stringify(result)));
      }
      //console.log(result)
  });
});

/*Edit Exams*/
router.get('/course/:courseId/edit-exam/:examId', function(req, res) {
  res.locals.account = req.session.account;
  var sql = `SELECT * from exam_tbl WHERE course_id = ${req.params.courseId} AND teacher_id=${req.session.userId} AND exam_id='${req.params.examId}'`;
  conn.query(sql, function(err, result) {
      if (err) {
          console.log(err);
      }else{
        res.render('pages/edit-exam', {
            title: 'Edit Exam',
            status:req.session.userId,
            accountType: req.session.accountType,
            course_name:req.session.course_name,
            course_id:req.params.courseId,
            exam: result[0]
        });
      }
  });
});
/*Update Exams*/
router.post('/course/:courseId/update-exam', function(req, res) {
  var ExamInfo = {
    'exam_title':req.body.exam_title,
    'exam_instruction':req.body.exam_instruction,
    'exam_time':req.body.exam_time,
    'exam_published':req.body.exam_published
  }
  conn.query(`UPDATE exam_tbl SET ? WHERE exam_id='${req.body.exam_id}' AND teacher_id=${req.body.teacher_id} AND course_id=${req.body.course_id}`, ExamInfo, function(err, result) {
      //if(err) throw err
      if (err) {
          res.setHeader('Content-Type', 'text/html');
          //req.flash('error',err);
          res.end(String(err));
          //res.redirect('/');
          console.log(err);
      } else {
          res.setHeader('Content-Type', 'text/html');
          res.end(String('Updated'));
          //res.redirect('/course/'+req.body.course_id);
      }
  });
});


/*List all the exams*/
router.post('/course/:courseId/fetch-question/:examId/:loId/:itemNo', function(req, res) {
  var sql = `SELECT * from items_tbl WHERE visibility=1 AND exam_id = '${req.params.examId}' AND lo_id=${req.params.loId} AND item_no = ${req.params.itemNo}`;
  conn.query(sql, function(err, result) {
      if (err) {
          res.send(err);
          console.log(err);
      }else{
        if(result.length>0){
          var sql2 = `SELECT * from question_tbl WHERE question_identifier='${result[0].question_id}'`;
          conn.query(sql2, function(err, result2) {
            if (err) {
                res.send(err);
                console.log(err);
            }else{
              let data = Object.assign(result[0], result2[0]);
              console.log(JSON.parse(JSON.stringify(data)));
              res.send(JSON.parse(JSON.stringify(data)));
            }
          });
        }else{
          res.send('0');
        }
      }
  });
});

/*Preview Exams*/
router.get('/course/:courseId/preview-exam/:examId/:examName', function(req, res) {
  res.locals.account = req.session.account;
  var sql = `SELECT
                q.question_desc,
                q.question_pa_1,
                q.question_pa_2,
                q.question_pa_3,
                q.question_pa_4,
                q.question_identifier,
                i.item_no
            FROM question_tbl q
            INNER JOIN items_tbl i
          	    ON q.question_identifier = i.question_id
                WHERE q.exam_id='${req.params.examId}' ORDER by i.item_no ASC`;

  var sql2 = `SELECT * from exam_tbl WHERE exam_id='${req.params.examId}'`;
  var sql3 = `SELECT * from taken_exam_tbl WHERE exam_id='${req.params.examId}' AND student_id=${req.session.userId}`;

  conn.query(sql, function(err, result) {
      if (err) {
          res.send(err);
          console.log(err);
      }else{
        conn.query(sql2, function(err, result2) {
          if (err) {
              res.send(err);
              console.log(err);
          }else{
            conn.query(sql3, function(err, result3) {
              if (err) {
                  res.send(err);
                  console.log(err);
              }else{
                if(result3.length==0){
                    var url='';
                    if(req.session.accountType==1){
                      //url='pages/preview-exam';
                      url='student/take-exam';
                    }else{
                      url='student/take-exam';
                    }
                    res.render(url, {
                        title: 'Take '+req.params.examName,
                        status:req.session.userId,
                        accountType: req.session.accountType,
                        course_name:req.session.course_name,
                        course_id:req.params.courseId,
                        exam_info:result2[0],
                        exam_questions:result,
                        exam_result:null
                    });
                  }else{
                    res.render('student/taken-exam', {
                        title: req.params.examName,
                        status:req.session.userId,
                        accountType: req.session.accountType,
                        course_name:req.session.course_name,
                        course_id:req.params.courseId,
                        exam_info:result2[0],
                        exam_result:result3[0]
                    });
                  }
                }
              });
            }
        });
      }
  });

});

/*Checker*/
router.post('/check-exam/:examId/:examItems', function(req, res) {
  var data = req.body;
  data = JSON.parse(data.exam);
  var sql = ``;
  for(var i=0;i<data.length;i++){
    sql+= `SELECT question_correct from question_tbl WHERE question_identifier='${data[i].qid}';`;
  }
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }else{
        var total_score=0;
        /*Check if student answer is correct from database*/
        var answer_correct_wrong = [];
        for(var i=0;i<result.length;i++){
          var answer = JSON.parse(JSON.stringify(result[i]))[0].question_correct;
          if(data[i].answer == answer){
            total_score++;
            answer_correct_wrong.push(1);
          }else{
            answer_correct_wrong.push(0);
          }
        }
        var ExamInfo = {
          student_id:req.session.userId,
          exam_id:req.params.examId,
          exam_item:req.params.examItems,
          exam_score:total_score
        };
        conn.query('INSERT INTO taken_exam_tbl SET ?', ExamInfo, function(err, result2) {
            //if(err) throw err
            if (err) {
                res.send(String(err));
                console.log(err);
            } else {
              var sql2 = ``;
              for(var i=0;i<data.length;i++){
                sql2+= `INSERT INTO item_analysis_tbl (exam_id,student_id,question_identifier,score) values ('${req.params.examId}',${req.session.userId},'${data[i].qid}',${answer_correct_wrong[i]});`;
              }
              conn.query(sql2, function(err, result3) {
                if (err) {
                    res.send(String(err));
                    console.log(err);
                }else{
                    res.send(String(total_score));
                }
              });
            }
        });
    }
  });

});

/*Check if taken*/
router.post('/check-taken/:examId/:examItems', function(req, res) {
  var sql = `SELECT * from taken_exam_tbl WHERE exam_id='${req.params.examId}' AND student_id=${req.session.userId}`;
  conn.query(sql, function(err, result) {
    if (err) {
        res.send(err);
        console.log(err);
    }else{
      if(result.length>0){
        res.send(result[0]);
      }else{
        res.send('0');
      }
    }
  });
});

/*generate tia*/
router.post('/generate-tia/:examId/', function(req, res) {
  var sql = `SELECT DISTINCT(student_id), question_identifier, score from item_analysis_tbl WHERE exam_id='${req.params.examId}'`;
  conn.query(sql, function(err, result) {
    if (err) {
        res.send(err);
        console.log(err);
    }else{
      if(result.length>0){
        res.send(result);
      }else{
        res.send('0');
      }
    }
  });
});
module.exports = router;
