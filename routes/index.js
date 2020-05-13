var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  if (req.session.userId) {
    res.redirect('/dashboard');
  }else{
  res.render('pages/index', { title: 'TIA: Test Item Analyzer' });
  }
});

module.exports = router;
