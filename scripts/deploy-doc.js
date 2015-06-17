var Travis = require('travis-ci');
var repo = "easywechat/site";
var travis = new Travis({
    version: '2.0.0'
});

travis.authenticate({
    github_token: process.env.GH_TOKEN
}, function (err, res) {
    if (err) {
      return console.error(err);
    }
    console.log(res);

    travis.repos(repo.split('/')[0], repo.split('/')[1]).builds.get(
      function (err, res) {
          if (err) {
            return console.error(err);
          }
          console.log('ssssssss');
          console.log(res);
          travis.requests.post({
            build_id: res.builds[0].id
          }, function (err, res) {
            if (err) {
              return console.error(err);
            }
            console.log(res.flash[0].notice);
          });
    });
});