const gulp = require(`gulp`);
const concat = require(`gulp-concat`);
const exec = require('child_process').exec;

const path = {
    game: `D:\\Games\\Warcraft III\\x86_64`,
    map: `test.w3x`
};

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
        gulp.series(build, openInGame)
    );
};
gulp.task('watch', watch);

const open = (cb, isGame) => {
    const exe = isGame ? `Warcraft III.exe` : `World Editor.exe`;

    exec(`start "" "${path.game}\\${exe}" -loadfile "%cd%\\${path.map}"`, (err, stdout, stderr) => {
            console.log(stdout);
            console.warn(stderr);
            cb(err);
        }
    );
};

gulp.task('build', build);

const openInGame = (cb) => {
    open(cb, true);
};
gulp.task('open in game', openInGame);

const openInEditor = (cb) => {
    open(cb, false);
};
gulp.task('open in editor', openInEditor);