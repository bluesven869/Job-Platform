var gulp = require('gulp');
var sass = require('gulp-sass');

gulp.task('sass', function() {
    gulp.src('./src/JobPlatform/FrontBundle/Resources/public/scss/job-platform.scss')
        .pipe(sass())
        .pipe(gulp.dest('./src/JobPlatform/FrontBundle/Resources/public/css/'));
});

gulp.task('watch', function() {
    gulp.watch('./src/JobPlatform/FrontBundle/Resources/public/scss/helpers/*.scss', ['sass']);
    gulp.watch('./src/JobPlatform/FrontBundle/Resources/public/scss/*.scss', ['sass']);
});
