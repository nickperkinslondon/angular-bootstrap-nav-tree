
module = angular.module 'angularBootstrapNavTree',[]

module.directive 'abnTree',($timeout)-> 
  restrict:'E'
  templateUrl:'abn_tree_template.html'  
  scope:
    treedata:'='

  link:(scope,element,attrs)->

    # check args
    if !scope.treedata
      alert 'no treedata defined for the tree!'
    if !scope.treedata.length?
      if treedata.label?
        scope.treedata = [ treedata ]
      else
        alert 'treedata should be an array of root branches'


    #
    # internal utilities...
    # 
    for_each_branch = (f)->      
      do_f = (branch)->
        f(branch)
        if branch.children?
          for child in branch.children
            do_f(child)
      for root_branch in scope.treedata
        do_f(root_branch)

    expand_all = ->
      for_each_branch (branch)->
        if not branch.collapsed
          branch.expanded = true

    unselect_all = ->
      for_each_branch (branch)->
        branch.selected = false

    #
    # the default is to have all branches expanded
    #
    if not attrs.collapsed? and not attrs.collapse
      # be 
      expand_all()

    #
    # give each Branch a UID ( to keep AngularJS happy )
    # 
    for_each_branch (branch)->
      branch.uid = ""+Math.random()

    
    #
    # only one branch can be selected at a time
    # 
    selected_branch = null
    select_branch = (branch)->
      unselect_all()
      branch.selected = true
      selected_branch = branch
      if branch.onSelect?
        $timeout ->
          branch.onSelect(branch)


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
    on_treedata_change = ->
      
      scope.tree_rows = []

      add_all = (level,branch,visible)->
        #
        # add_all: recursively add one branch
        # and all of it's children
        # to the list
        #

        if branch.selected ?= true
          select_branch(branch)

        if not branch.expanded?
          branch.expanded = false

        #
        # icons can be Bootstrap or Font-Awesome icons:
        # they will be rendered like:
        # <i class="icon-plus"></i>
        #
        tree_icon = attrs.iconExpand if not branch.expanded and branch.children
        tree_icon = attrs.iconCollapse if branch.expanded
        tree_icon = attrs.iconLeaf if not branch.children

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
      for root_branch in scope.treedata        
        add_all 1, root_branch, true


    #
    # make sure to do a "deep watch" on the tree data
    # ( by passing "true" as the third arg )
    #
    scope.$watch 'treedata',on_treedata_change,true
