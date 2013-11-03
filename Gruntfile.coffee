
module.exports = (grunt)->  

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    jade:
      dev:
        options:
          pretty:true
        files:
          'dist/abn_tree_template.html':'src/abn_tree_template.jade'
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
            ng:"1.2.0-rc.3"

      bs3_ng120_test_page:
        files:
          'test/bs3_ng120_test_page.html':'test/test_page.jade'
        options:
          pretty:true
          data:
            bs:"3"
            ng:"1.2.0-rc.3"







    coffee:
      dev:
        options:
          bare:true
        files:
          'dist/abn_tree_directive.js':'src/abn_tree_directive.coffee'
          'test/test_page.js':'test/test_page.coffee'


    watch:
      jade:
        files:['**/*.jade']
        tasks:['jade']
        options:
          livereload:true

      css:
        files:['**/*.css'] 
        tasks:[]     
        options:
          livereload:true


      coffee:
        files:['**/*.coffee']
        tasks:['coffee']
        options:
          livereload:true

  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['jade','coffee','watch']

