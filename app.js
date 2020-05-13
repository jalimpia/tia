var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var bodyParser = require('body-parser'); //Parse incoming request
var flash  = require('express-flash');
var session = require('express-session');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

//Using middleware
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(session({
  secret: 'secret',
  cookie: { maxAge: 60000 * 30 },
  store: new session.MemoryStore,
  resave: false,
  maxAge: Date.now() + (30 * 86400 * 1000),
  saveUninitialized: true,
}));
app.use(flash());


//Routes
var index = require('./routes/index');
var login = require('./routes/login');
var dashboard = require('./routes/dashboard');
var course = require('./routes/course');
var topic = require('./routes/topic');
var question = require('./routes/question');
var exam = require('./routes/exam');
try {
  app.use(index);
  app.use(login);
  /*Main Page*/
  app.use(dashboard);
  app.use(course);
  app.use(topic);
  app.use(question);
  app.use(exam);
} catch (e) {
  console.log(e);
}


// Logout
app.use('/logout',function(req, res) {
        res.set('Cache-Control', 'no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0');
        req.session.destroy();
        res.redirect('/dashboard');
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  //next(createError(404));
  res.render('pages/404');
});


// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

app.listen(3000);
module.exports = app;
