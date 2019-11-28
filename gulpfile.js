const gulp = require(`gulp`);
const concat = require(`gulp-concat`);
const exec = require('child_process').exec;
const inject = require('gulp-inject-string');

const path = {
    game: `D:\\Games\\Warcraft III\\x86_64`,
    map: `map.w3x`,
    file: `custom-code.lua`
};

const build = () => {
    return gulp
        .src([
            `build/**/*.lua`
        ])
        .pipe(concat(path.file))
        .pipe(inject.prepend(`--INJECT-START\r\n`))
        .pipe(inject.append(`\r\n--INJECT-END`))
        .pipe(gulp.dest(`.`));
};

const replace = (cb) => {
    exec(`start "" "%cd%\\custom-code-replacer.exe" "%cd%\\${path.map}\\war3map.wct" "%cd%\\${path.file}"`, (err, stdout, stderr) => {
            console.log(stdout);
            console.warn(stderr);
            cb(err);
        }
    );
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

gulp.task('build', gulp.series(build, replace));

const openInGame = (cb) => {
    open(cb, true);
};
gulp.task('open in game', openInGame);

const openInEditor = (cb) => {
    open(cb, false);
};
gulp.task('open in editor', openInEditor);