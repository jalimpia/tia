var express = require('express');
var router = express.Router();
var conn = require('../model/config');

const multer = require('multer');
//const upload = multer({dest: __dirname + '/uploads/images'});

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/images/courses')
  },
  filename: function (req, file, cb) {
    cb(null, file.fieldname + '-' + Date.now())
  }
})

var upload = multer({ storage: storage })

function get_info(data, callback) {
    var sql = '';
    for (var i = 0; i < data.length; i++) {
        sql += 'SELECT COUNT(lo_id) as qnum from question_tbl where lo_id = ' + data[i] + ';';
    }
    conn.query(sql, function(err, result) {
        if (err) {
            console.log(err);
        }else{
            return callback(result);
        }
    });
}

router.post('/search-course', function(req, res) {
  var sem = req.body.sem;
  var keyword = req.body.keyword;
  var sql = `SELECT * from course_tbl WHERE course_id IN(SELECT course_id from loading_tbl where teacher_id=${req.session.userId}) AND course_name like '%${keyword}%' AND course_sem=${sem} ORDER BY course_id ASC`;
  conn.query(sql, function(err, result) {
    if (err) {
        console.log(err);
        res.send(err);
    }else{
      if(result.length>0){
        res.send(result);
      }else{
        res.send('0');
      }
    }
  });
});

router.get('/create-course', function(req, res) {
  res.locals.account = req.session.account;
  res.render('pages/create-course', {
      title: 'Create Course',
      status: req.session.userId,
      accountType: req.session.accountType
  });
});

router.post('/load-teacher-course', function(req, res) {
  var sql1 = `SELECT * from course_tbl`;
  var sql2 = `SELECT * from user_tbl`;
  conn.query(sql1, function(err, result1) {
    if (err) {
        console.log(err);
    } conn.query(sql2, function(err, result2) {
        if (err) {
            res.send(err);
        }
        res.send([result1,result2]);
      });
  });
});

router.get('/assign-load', function(req, res) {
  res.locals.account = req.session.account;
  res.render('pages/assign-load', {
      title: 'Assign Course',
      status: req.session.userId,
      accountType: req.session.accountType
  });
});

router.post('/add-load', function(req, res) {
  var LoadInfo={
      'course_id':req.body.course_id,
      'teacher_id':req.body.teacher_id,
      'who_assign_id':req.session.userId
  }
  conn.query(`SELECT * from loading_tbl WHERE course_id=${req.body.course_id} AND teacher_id=${req.body.teacher_id}`, function(err, result) {
    if (err) {
        console.log(err);
    }else{
      if (result.length > 0) {
            res.send(`<script>alert('This course was already assigned to a student!');history.back();</script>`);
      }else{
        conn.query('INSERT INTO loading_tbl SET ?', LoadInfo, function(err, result2) {
            //if(err) throw err
            if (err) {
                console.log(err);
            } else {
                //res.send(`<script>alert('This course was assigned successfully!');</script>`);
                res.redirect('/dashboard');
            }
        });
      }
    }
  });
});

router.post('/course/add-course', upload.single('course_img'), function(req, res) {
  // if(req.file) {
  //     res.json(req.file);
  // }
  // else throw 'error';
  var CourseInfo={
      'course_code':req.body.course_code,
      'course_name':req.body.course_name,
      'course_desc':req.body.course_desc,
      'course_units':parseInt(req.body.course_units),
      'course_sem':parseInt(req.body.course_sem),
      'course_img': '/images/courses/'+req.file.filename
  }

  conn.query('INSERT INTO course_tbl SET ?', CourseInfo, function(err, result) {
      //if(err) throw err
      if (err) {
          console.log(err);
      } else {
          res.redirect('/dashboard');
      }
  });

});

router.get('/course/:courseId', function(req, res) {
    res.locals.account = req.session.account;
    var sql1 = `SELECT * from course_tbl WHERE course_id = (SELECT course_id from loading_tbl where course_id=${req.params.courseId} AND teacher_id=${req.session.userId})`;
    var sql2 = '';
    var url='';
    if(req.session.accountType==1){
      url='pages/course';
      var sql2 = `SELECT * from learning_tbl WHERE course_id = ${req.params.courseId} AND teacher_id=${req.session.userId}`;
    }else{
      url='student/course';
      var sql2 = `SELECT * from learning_tbl WHERE course_id = ${req.params.courseId} AND teacher_id = (SELECT who_assign_id from loading_tbl WHERE course_id = ${req.params.courseId} AND teacher_id=${req.session.userId})`;
    }

    conn.query(sql1, function(err, result1) {
        if (err) {
            console.log(err);
        }else{
          if (result1.length > 0) {
              conn.query(sql2, function(err, result2) {
                  if (err) {
                      console.log(err);
                  }else{
                    if (result2.length > 0) {
                        var qnum_arr = []
                        for (var i = 0; i < result2.length; i++) {
                            qnum_arr.push(result2[i].lo_id);
                        }

                        get_info(qnum_arr, function(result) {
                            qnum_arr = [];
                            if(result.length>1){
                              for (var i = 0; i < result.length; i++) {
                                  var data = JSON.parse(JSON.stringify(result[i]));
                                  qnum_arr.push(data[0].qnum);
                              }
                            }else{
                              var data = JSON.parse(JSON.stringify(result[0]));
                              qnum_arr.push(data.qnum);
                            }
                            //console.log(qnum_arr);
                            if (err) {
                                res.send(err)
                            }

                            console.log(req.session.accountType);
                              req.session.course_name = result1[0].course_name;
                              res.render(url, {
                                  title: req.session.course_name,
                                  status: req.session.userId,
                                  accountType: req.session.accountType,
                                  course: result1[0],
                                  tos: result2,
                                  qnum: qnum_arr
                              });

                        });
                    }else{
                      req.session.course_name = result1[0].course_name;
                      res.render(url, {
                          title: req.session.course_name,
                          status: req.session.userId,
                          accountType: req.session.accountType,
                          course: result1[0],
                          tos: null,
                          qnum: null
                      });
                    }
                  }
              });
          } else {
              res.render(url, {
                  title: 'Course not found',
                  status: req.session.userId,
                  accountType: req.session.accountType,
                  course: null,
                  tos: null,
                  qnum: null
              });
          }
        }
    });
});


module.exports = router;
