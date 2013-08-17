
module.exports = (grunt)->	

	grunt.initConfig

		pkg: grunt.file.readJSON 'package.json'

		jade:
			dist:
				options:
					pretty:true
				files:[
					expand:true
					src:'src/*.jade'
					dest:'dist'
					ext:'*.html'
				]
		
		less:
			config:
				options:
					bare:true
				files:[
					expand:true
					src:['src/*.less']
					dest:'dist'
				]
			dev:
				files:
					'main.css':'main.less'

		coffee:
			config:
				options:
					bare:true
				files:[
					expand:true
					src:'src/*.coffee'
					dest:'./dist'					
				]


		watch:
			jade:
				files:['**/*.jade']
				tasks:['jade']
			less:
				files:['**/*.less']
				tasks:['less']
			coffee:
			 	files:['**/*.coffee']
			 	tasks:['coffee']

	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'

	grunt.registerTask 'default', ['jade','less','coffee']




