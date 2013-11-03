  


deps = ['angularBootstrapNavTree']
if angular.version.full.indexOf("1.2")>=0
  deps.push('ngAnimate')


app = angular.module 'AbnTest', deps
app.controller 'AbnTestController',($scope)->
  
  #
  # a default "on-select" handler can be specified
  # for the tree ( as attribute "on-select" )
  #   
  $scope.my_tree_handler = (branch)->
    $scope.output = "You selected: "+branch.label
    if branch.data?.description
      $scope.output += '('+branch.data.description+')'
    #
    # This example handler just sets "output",
    # ...but your handler could do anything here...
    # 


  #
  # Each branch can define an "on-select" handler,
  # which will be called instead of the default handler
  #

  #
  # a single handler can be used on several branches, like this:
  # 
  apple_selected = (branch)->
    $scope.output = "APPLE! : "+branch.label
    #
    # ( your handler can do anything here )
    # 


  #
  # Example TREE DATA : Animal,Vegetable,Mineral
  # 
  # Each branch can have the following attributes:
  #
  # label    : the displayed text for the branch
  # children : an array of branches ( or array of strings )
  # onSelect : a function to run when branch is selected
  # data     : a place to put your own data -- can be anything
  #
  $scope.example_treedata = [
    label:'Animal'
    children:[
      label:'Dog'
      data:
        #
        # "data" is yours -- put anything in here
        # you can read it back in your on-select handler
        # as "branch.data"
        # 
        description:"man's best friend"
    , 
      label:'Cat'
      data:
        description:"Felis catus"
    ,
      label:'Hippopotamus'
      data:
        description:"hungry, hungry"
    ,
      label:'Chicken'
      children:['White Leghorn','Rhode Island Red','Jersey Giant']        
    ]
  ,

    label:'Vegetable'
    data:
      definition:"A plant or part of a plant used as food, typically as accompaniment to meat or fish, such as a cabbage, potato, carrot, or bean."
      data_can_contain_anything:true

    onSelect:(branch)->
      # special "on-select" function for this branch
      $scope.output = "Vegetable: "+branch.data.definition
      

    children:[
      label:'Oranges'
    ,
      label:'Apples'
      children:[
        label:'Granny Smith'
        onSelect:apple_selected
      ,
        label:'Red Delicous'
        onSelect:apple_selected
      ,
        label:'Fuji'
        onSelect:apple_selected
      ]
    ]
  ,
    label:'Mineral'
    children:[
      label:'Rock'
      # children can be simply a list of strings
      # if you are in a hurry
      children:['Igneous','Sedimentary','Metamorphic']
    ,
      label:'Metal'
      children:['Aluminum','Steel','Copper']
    ,
      label:'Plastic'
      children:[
        label:'Thermoplastic'
        children:['polyethylene', 'polypropylene', 'polystyrene',' polyvinyl chloride']
      ,
        label:'Thermosetting Polymer'
        children:['polyester','polyurethane','vulcanized rubber','bakelite','urea-formaldehyde']
      ,
      ]
      
    ]

  ]


  $scope.try_changing_the_tree_data = ()->
    $scope.example_treedata = [
      label:'North America'
      children:[
        label:'Canada'
        children:['Toronto','Vancouver']
      ,
        label:'USA'
        children:['New York','Los Angeles']
      ,
        label:'Mexico'
        children:['Mexico City','Guadalajara']
      ]
    ,
      label:'South America'
      children:[
        label:'Venezuela'
        children:['Caracas','Maracaibo']
      ,
        label:'Brazil'
        children:['Sao Paulo','Rio de Janeiro']
      ,
        label:'Argentina'
        children:['Buenos Aires','Cordoba']
      ]

    ]


