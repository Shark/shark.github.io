#global module:false

"use strict"

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-exec"

  grunt.initConfig

    copy:
      pure:
        files: [{
          expand: true
          cwd: "bower_components/pure"
          src: [
            "pure-min.css"
            "grids-responsive-min.css"
          ]
          dest: "vendor/css/"
        }]
      ionicons:
        files: [{
          expand: true
          cwd: "bower_components/Ionicons/css"
          src: "ionicons.min.css"
          dest: "vendor/css/"
        },{
          expand: true
          cwd: "bower_components/Ionicons/fonts"
          src: "*"
          dest: "vendor/fonts/"
        }]

    exec:
      jekyll:
        cmd: "jekyll build --trace"

    watch:
      options:
        livereload: true
      source:
        files: [
          "_drafts/**/*"
          "_includes/**/*"
          "_layouts/**/*"
          "_posts/**/*"
          "_static/**/*"
          "_pages/**/*"
          "_sass/**/*"
          "css/**/*"
          "js/**/*"
          "assets/**/*"
          "_config.yml"
          "*.html"
          "*.md"
        ]
        tasks: [
          "exec:jekyll"
        ]

    connect:
      server:
        options:
          port: 4000
          base: '_site'
          livereload: true

  grunt.registerTask "build", [
    "copy"
    "exec:jekyll"
  ]

  grunt.registerTask "serve", [
    "build"
    "connect:server"
    "watch"
  ]

  grunt.registerTask "default", [
    "serve"
  ]
