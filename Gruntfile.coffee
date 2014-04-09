
module.exports = (grunt)->  

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    jade:
      dev:
        options:
          pretty:true
        files:
          'temp/_template.html':'src/abn_tree_template.jade'
          'test/tests_page.html':'test/tests_page.jade'
          
      #
      # Generate 4 test pages, for all combinations of:
      # 
      # Bootstrap 2 and 3
      # Angular 1.1.5 and 1.2.0
      # 
    
      bs2_ng115_test_page:
        files:
          'test/bs2_ng115_test_page.html':'test/test_page.jade'
        options:
          pretty:true
          data:
            bs:"2"
            ng:"1.1.5"

      bs3_ng115_test_page:
        files:
          'test/bs3_ng115_test_page.html':'test/test_page.jade'
        options:
          pretty:true
          data:
            bs:"3"
            ng:"1.1.5"

      bs2_ng120_test_page:
        files:
          'test/bs2_ng120_test_page.html':'test/test_page.jade'
        options:
          pretty:true
          data:
            bs:"2"
            ng:"1.2.12"

      bs3_ng120_test_page:
        files:
          'test/bs3_ng120_test_page.html':'test/test_page.jade'
        options:
          pretty:true
          data:
            bs:"3"
            ng:"1.2.12"


    "string-replace":
      dev:
        files:
          #
          # substitute the "template html" into an intermediate coffeescript file
          # ( to take advantage of triple-quoted strings )
          #
          'temp/_directive.coffee':'src/abn_tree_directive.coffee'
        options:
          replacements:[
            pattern: "{html}"
            replacement_old: "<h1>i am the replacement!</h1>"
            replacement: (match, p1, offset, string)->
              grunt.file.read('temp/_template.html')
          ]

    coffee:
      dev:
        options:
          bare:false
        files:
          #
          # the _temp.coffee file has the "template html" baked-in by Grunt
          #
          'dist/abn_tree_directive.js':'temp/_directive.coffee'
          'test/test_page.js':'test/test_page.coffee'




    watch:

      jade:
        files:['**/*.jade']
        tasks:['jade','string-replace']
        options:
          livereload:true

      css:
        files:['**/*.css'] 
        tasks:[]     
        options:
          livereload:true

      coffee:
        files:['**/*.coffee']
        tasks:['jade','string-replace','coffee']
        options:
          livereload:true

  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-string-replace'


  grunt.registerTask 'default', ['jade','string-replace','coffee','watch']



