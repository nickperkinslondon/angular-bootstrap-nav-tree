
module.exports = (grunt)->  

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    jade:
      dev:
        options:
          pretty:true
        files:
          'dist/abn_tree_template.html':'src/abn_tree_template.jade'
          
      #
      # Generate 2 test pages:
      # one for Bootstrap 2
      # one for Bootstrap 3
      # 
    
      bs2:
        files:
          'test/bs2_test_page.html':'src/test_page.jade'
        options:
          pretty:true
          data:
            bs:"2"

      bs3:
        files:
          'test/bs3_test_page.html':'src/test_page.jade'
        options:
          pretty:true
          data:
            bs:"3"



    coffee:
      dev:
        options:
          bare:true
        files:
          'dist/abn_tree_directive.js':'src/abn_tree_directive.coffee'
          'test/test_page.js':'src/test_page.coffee'


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

