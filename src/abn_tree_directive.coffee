
module = angular.module 'angularBootstrapNavTree',[]

module.directive 'abnTree',($timeout)-> 
  restrict:'E'
  templateUrl:'../dist/abn_tree_template.html'  # FIXME?
  scope:
    treeData:'='
    onSelect:'&'
    initialSelection:'='

  link:(scope,element,attrs)->


    attrs.iconExpand   ?= 'icon-plus'
    attrs.iconCollapse ?= 'icon-minus'
    attrs.iconLeaf     ?= 'icon-chevron-right'
    attrs.expandLevel  ?= '3'



    expand_level = parseInt attrs.expandLevel,10

    scope.header = attrs.header

    # check args
    if !scope.treeData
      alert 'no treeData defined for the tree!'
    if !scope.treeData.length?
      if treeData.label?
        scope.treeData = [ treeData ]
      else
        alert 'treeData should be an array of root branches'


    #
    # internal utilities...
    # 
    for_each_branch = (f)->      
      do_f = (branch,level)->
        f(branch,level)
        if branch.children?
          for child in branch.children
            do_f(child,level + 1)
      for root_branch in scope.treeData
        do_f(root_branch,1)


    #
    # if children is just a list of strings...
    # ...change them into objects:
    # 


    for_each_branch (branch)->
      if branch.children
        if branch.children.length > 0
          branch.children = branch.children.map (e)->
            if typeof e == 'string'
              label:e
              children:[]
            else
              e
      else
        branch.children = []




    #
    # expand to proper level
    #
    for_each_branch (b,level)->
      b.level = level
      b.expanded = b.level < expand_level
      # give each Branch a UID ( to keep AngularJS happy )
      b.uid = ""+Math.random()

    expand_all = ->
      for_each_branch (branch)->
        branch.expanded = true

    unselect_all = ->
      for_each_branch (branch)->
        branch.selected = false


    
    #
    # only one branch can be selected at a time
    # 
    selected_branch = null
    select_branch = (branch)->
      if branch isnt selected_branch
        unselect_all()
        branch.selected = true
        selected_branch = branch
        if branch.onSelect?
          #
          # finish changing branches,
          # ( so the new branch is highlighted ),
          # before calling the "onSelect" function.
          #
          $timeout ->
            branch.onSelect(branch)
        else
          #
          # is there a default "onSelect" for this tree?
          # 
          if scope.onSelect?
            scope.onSelect({branch:branch})


    scope.user_clicks_branch = (branch)->
      if branch isnt selected_branch
         select_branch(branch)


    # To make the Angular rendering simpler,
    #  ( and to avoid recursive templates )
    #  we transform the TREE of data into a LIST of data
    #  (that also includes a "level" for each element)
    #
    # Children of un-expanded parents are included, 
    #  but are set to "visible:false" ( and filtered out during rendering )
    # ( we could maybe just leave them out of the list altogether ?)
  

    #
    # when tree data changes,
    # re-create the "tree_rows" data that is used
    # to actually render the tree
    #
    scope.tree_rows = []
    on_treeData_change = ->
      
      scope.tree_rows = []

      add_all = (level,branch,visible)->
        #
        # add_all: recursively add one branch
        # and all of it's children to the list
        #
        #if branch.selected ?= true
        #  select_branch(branch)

        if not branch.expanded?
          branch.expanded = false

        #
        # icons can be Bootstrap or Font-Awesome icons:
        # they will be rendered like:
        # <i class="icon-plus"></i>
        #

        if branch.children.length == 0 
          tree_icon = attrs.iconLeaf
        else
          if branch.expanded
            tree_icon = attrs.iconCollapse
          else
            tree_icon = attrs.iconExpand 




        #
        # append to the list of "Tree Row" objects:
        #
        scope.tree_rows.push
          level     : level
          branch    : branch
          label     : branch.label
          tree_icon : tree_icon
          visible   : visible

        #
        # recursively add all children of this branch...( at Level+1 )
        #
        if branch.children?
          for child in branch.children
            #
            # all branches are added to the list,
            #  but some are not visible
            # ( if parent is collapsed )
            # 
            child_visible = visible and branch.expanded
            add_all level+1, child, child_visible

      #
      # start with root branches,
      # and recursively add all children to the list
      #
      for root_branch in scope.treeData        
        add_all 1, root_branch, true



    if attrs.initialSelection?
      for_each_branch (b)->
        if b.label == attrs.initialSelection
          select_branch b

    #
    # make sure to do a "deep watch" on the tree data
    # ( by passing "true" as the third arg )
    #
    scope.$watch 'treeData',on_treeData_change,true
