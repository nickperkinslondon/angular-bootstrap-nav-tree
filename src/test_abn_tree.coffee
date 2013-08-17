  
app = angular.module 'AbnTest', ['angularBootstrapNavTree']
app.controller 'AbnTestController',($scope)->
  
  
  $scope.my_default_handler = (branch)->
    $scope.output = "You selected: "+branch.label
    #
    # your handler can do anything here...
    # 


  apple_selected = (branch)->
    $scope.output = "APPLE! : "+branch.label
    #
    # your handler can do anything here...
    # 


  #
  # The TREE DATA
  # 
  # Each branch can have the following attributes:
  #
  # label    : the displayed text for the branch
  # children : an array of branches
  # onSelect : a function to run when branch is selected
  # data     : a place to put your own data -- can be anything
  #
  $scope.example_treedata = [
    label:'Animal'
    children:[
      label:'Dog'
      data:
        description:"man's best friend"
    , 
      label:'Cat'
      data:
        description:"spawn of satan"
    ,
      label:'Hippopotomus'
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

    #
    # a single branch can define it's own "on-select" handler:
    #
    onSelect:(branch)->
      $scope.output = "Fruit: "+branch.data.definition


    children:[
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
    ,
      label:'Oranges'
    ]
  ,
    label:'Mineral'
    # children can be simply a list of strings:
    children:[
      label:'Rock'
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

