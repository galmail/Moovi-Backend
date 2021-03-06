module.exports = function (grunt) {
  // * Read command-line switches
  // - Read in --browsers CLI option; split it on commas into an array if it's a string, otherwise ignore it
  var browsers = typeof grunt.option('browsers') == 'string' ? grunt.option('browsers').split(',') : undefined;

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    library: grunt.file.readJSON('bower.json'),
    ngtemplates:  {
      app:        {
        cwd:      'src/<%= library.original %>/templates',
        src:      'theme/**.html',
        dest:     '.tmp/templates.js',
        options: {
          module:   'ngS3upload'
        }
      }
    },
    concat: {
      options: {
        separator: ''
      },
      library: {
        src: [
          'src/<%= library.original %>/<%= library.original %>.prefix',
          'src/<%= library.original %>/<%= library.original %>.js',
          'src/<%= library.original %>/services/**/*.js',
          'src/<%= library.original %>/directives/**/*.js',
          'src/<%= library.original %>/filters/**/*.js',
          '<%= ngtemplates.app.dest %>',
          'src/<%= library.original %>/<%= library.original %>.suffix'
        ],
        dest: 'build/<%= library.original %>.js'
      }
    },
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
      },
      jid: {
        files: {
          'build/<%= library.original %>.min.js': ['<%= concat.library.dest %>']
        }
      }
    },
    jshint: {
      beforeConcat: {
        src: ['gruntfile.js', '<%= library.original %>/**/*.js']
      },
      afterConcat: {
        src: [
          '<%= concat.library.dest %>'
        ]
      },
      options: {
        // options here to override JSHint defaults
        globals: {
          jQuery: true,
          console: true,
          module: true,
          document: true,
          angular: true
        },
        globalstrict: false
      }
    },
    testFiles: {
      karmaUnit: 'karma.conf.js'
    },
    karma: {
      unit: {
        options: {
          configFile: '<%= testFiles.karmaUnit %>',
          autoWatch: false,
          singleRun: true,
          browsers: browsers || ['Chrome']
        }
      }
    },
    watch: {
      options: {
        livereload: true
      },
      files: [
        'Gruntfile.js',
        'src/**/*'
      ],
      tasks: ['default']
    },
    clean: {
      dist: {
        files: [{
          dot: false,
          src: [
            '.tmp',
            'build/'
          ]
        }]
      }
    }
  });

  // Load grunt-karma task plugin
  grunt.loadNpmTasks('grunt-karma');

  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-angular-templates');

  grunt.registerTask('test', ['jshint', 'karma:unit']);
  grunt.registerTask('default', ['clean:dist','jshint:beforeConcat', 'ngtemplates', 'concat', 'jshint:afterConcat', 'uglify']);
  grunt.registerTask('livereload', ['default', 'watch']);

};