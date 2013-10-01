module.exports = (grunt)->  

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    jade:
      dev:
        options:
          pretty:true
        files:
          'dist/abn_tree.html':'src/abn_tree.jade'
          'test/test_abn_tree.html':'src/test_abn_tree.jade'

    less:
      dev:
        options:
          compress:false
        files:
          'dist/abn_tree.css':'src/abn_tree.less'

    coffee:
      dev:
        options:
          bare:true
        files:
          'dist/abn_tree.js':'src/abn_tree.coffee'
          'dist/abn_tree_tpls.js':'src/abn_tree_tpls.coffee'
          'test/test_abn_tree.js':'src/test_abn_tree.coffee'

    replace:
      dev:
        src: ['dist/abn_tree_tpls.js']
        overwrite: true
        replacements: [
          from: 'ABN_TREE_TEMPLATE'
          to: do () ->
            res = grunt.file.read 'dist/abn_tree.html'
            res.replace(/\n/g, '\\n').replace /\'/g, '\\\''
        ]

    watch:
      jade:
        files:['**/*.jade']
        tasks:['jade']
        options:
          livereload:true
      less:
        files:['**/*.less']
        tasks:['less']
        options:
          livereload:true

      coffee:
        files:['**/*.coffee']
        tasks:['coffee']
        options:
          livereload:true

  grunt.loadNpmTasks 'grunt-text-replace'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['jade','less','coffee','replace']
