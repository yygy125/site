'use strict';

var gulp = require('gulp');
var $ = require('gulp-load-plugins')();
var autoprefixer = require('autoprefixer-core');

var htmlMinifierOptions = {
  removeComments: true,
  collapseWhitespace: true,
  collapseBooleanAttributes: true,
  removeScriptTypeAttributes: true,
  removeStyleLinkTypeAttributes: true,
  removeOptionalTags: true,
  minifyJS: true,
  minifyCSS: true
};

var dirs = {
  public: 'public'
};

gulp.task('useref', function(){
  var assets = $.useref.assets({
    searchPath: 'public'
  });

  return gulp.src('public/**/*.html')
    .pipe(assets)
    .pipe($.if('*.css', $.postcss([
      autoprefixer({
        browsers: ['last 2 versions', 'Firefox ESR']
      })
    ])))
    .pipe($.if('*.css', $.minifyCss()))
    .pipe($.if('*.js', $.uglify()))
    .pipe($.rev())
    .pipe(assets.restore())
    .pipe($.useref())
    .pipe($.revReplace({
      prefix: '/'
    }))
    .pipe($.if('*.html', $.htmlMinifier(htmlMinifierOptions)))
    .pipe(gulp.dest('public'));
});

gulp.task('default', ['useref', 'screenshot']);