const gulp = require(`gulp`);
const concat = require(`gulp-concat`);
const exec = require('child_process').exec;

const build = () => {
    return gulp
        .src([
            `build/**/*.lua`
        ])
        .pipe(concat(`war3map.lua`))
        .pipe(gulp.dest(`src`));
};

const watch = () => {
    gulp.watch(
        [
            `build/**/*.lua`
        ],
        gulp.series(build, run)
    );
};
gulp.task('watch', watch);

const run = (cb) => {
    exec(`start explorer`, (err) => {
        cb(err)
    });
    return gulp;
};
gulp.task('run', run);