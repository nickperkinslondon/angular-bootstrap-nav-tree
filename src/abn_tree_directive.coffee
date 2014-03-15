
module = angular.module 'angularBootstrapNavTree',[]


module.directive 'abnTree',($timeout)-> 
  restrict:'E'
  templateUrl: '../dist/abn_tree_template.html'

  scope:
    treeData:'='
    onSelect:'&'
    initialSelection:'@'

  link:(scope,element,attrs)->


    error = (s) ->
      console.log 'ERROR:'+s
      debugger
      return undefined


    # default values ( Font-Awesome 4 )
    attrs.iconExpand   ?= 'icon-plus  glyphicon glyphicon-plus  fa fa-plus'    
    attrs.iconCollapse ?= 'icon-minus glyphicon glyphicon-minus fa fa-minus'
    attrs.iconLeaf     ?= 'icon-file  glyphicon glyphicon-file  fa fa-file'

    # font-awesome 3 or just plain bootstrap
    # attrs.iconExpand   ?= 'icon-plus'    
    # attrs.iconCollapse ?= 'icon-minus'
    # attrs.iconLeaf     ?= 'icon-file'


    attrs.expandLevel  ?= '3'


    expand_level = parseInt attrs.expandLevel,10

    scope.header = attrs.header

    # check args
    if !scope.treeData
      alert 'no treeData defined for the tree!'
      return

    if !scope.treeData.length?
      if treeData.label?
        scope.treeData = [ treeData ]
      else
        alert 'treeData should be an array of root branches'
        return


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
    # expand to the proper level
    #
    for_each_branch (b,level)->
      b.level = level
      b.expanded = b.level < expand_level

    
    #
    # only one branch can be selected at a time
    # 
    selected_branch = null
    select_branch = (branch)->

      if not branch
        if selected_branch?
          selected_branch.selected = false
        selected_branch = null
        return

      if branch isnt selected_branch
        if selected_branch?
          selected_branch.selected = false

        branch.selected = true
        selected_branch = branch
        expand_all_parents(branch)


        #
        # check:
        # 1) branch.onSelect
        # 2) tree.onSelect
        #
        if branch.onSelect?
          #
          # use $timeout
          # so that the branch becomes fully selected
          # ( and highlighted )
          # before calling the "onSelect" function.
          #
          $timeout ->
            branch.onSelect(branch)
        else
          if scope.onSelect?
            $timeout ->
              scope.onSelect({branch:branch})


    scope.user_clicks_branch = (branch)->
      if branch isnt selected_branch
         select_branch(branch)


    get_parent = (child)->
      parent = undefined
      if child.parent_uid
        for_each_branch (b)->
          if b.uid == child.parent_uid
            parent = b
      return parent

    for_all_ancestors = ( child, fn )->
      parent = get_parent( child )
      if parent?
        fn( parent )
        for_all_ancestors( parent, fn )


    expand_all_parents = ( child )->
      for_all_ancestors child, (b)->
        b.expanded = true


    #
    # To make the Angular rendering simpler,
    #  ( and to avoid recursive templates )
    #  we transform the TREE of data into a LIST of data.
    #  ( "tree_rows" )
    #
    # We do this whenever data in the tree changes.
    # The tree itself is bound to this list.
    # 
    # Children of un-expanded parents are included, 
    #  but are set to "visible:false" 
    #  ( and then they filtered out during rendering )
    #
    scope.tree_rows = []
    on_treeData_change = ->


      # give each Branch a UID ( to keep AngularJS happy )
      for_each_branch (b,level)->
        if not b.uid
          b.uid = ""+Math.random()
      console.log 'UIDs are set.'


      # set all parents:
      for_each_branch (b)->
        if angular.isArray b.children
          for child in b.children
            child.parent_uid = b.uid


      scope.tree_rows = []

      #
      # if "children" is just a list of strings...
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
      # add_branch_to_list: recursively add one branch
      # and all of it's children to the list
      #
      add_branch_to_list = (level,branch,visible)->

        if not branch.expanded?
          branch.expanded = false

        #
        # icons can be Bootstrap or Font-Awesome icons:
        # they will be rendered like:
        # <i class="icon-plus"></i>
        #
        if not branch.children or branch.children.length == 0 
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
            add_branch_to_list level+1, child, child_visible

      #
      # start with root branches,
      # and recursively add all children to the list
      #
      for root_branch in scope.treeData        
        add_branch_to_list 1, root_branch, true


    #
    # make sure to do a "deep watch" on the tree data
    # ( by passing "true" as the third arg )
    #
    scope.$watch 'treeData',on_treeData_change,true


    #
    # initial-selection="Branch Label"
    # if specified, find and select the branch:
    #
    if attrs.initialSelection?
      for_each_branch (b)->
        if b.label == attrs.initialSelection
          $timeout ->
            select_branch b
