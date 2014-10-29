module = angular.module 'angularBootstrapNavTree',[]

module.directive 'abnTree',['$timeout',($timeout)-> 
  restrict:'E'
  
  #templateUrl: '../dist/abn_tree_template.html' # <--- another way to do this

  template: """{html}""" # will be replaced by Grunt, during build, with the actual Template HTML
  replace:true
  scope:
    treeData:'='
    onSelect:'&'
    initialSelection:'@'
    treeControl:'='

  link:(scope,element,attrs)->


    error = (s) ->
      console.log 'ERROR:'+s
      debugger
      return undefined


    # default values ( Font-Awesome 3 or 4 or Glyphicons )
    attrs.iconExpand   ?= 'icon-plus  glyphicon glyphicon-plus  fa fa-plus'    
    attrs.iconCollapse ?= 'icon-minus glyphicon glyphicon-minus fa fa-minus'
    attrs.iconLeaf     ?= 'icon-file  glyphicon glyphicon-file  fa fa-file'

    attrs.expandLevel  ?= '3'

    expand_level = parseInt attrs.expandLevel,10

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

      #console.log 'tree-data-change!'
      
      #
      # if "children" is just a list of strings...
      # ...change them into objects:
      # 
      for_each_branch (branch)->
        if branch.children
          if branch.children.length > 0
            # don't use Array.map ( old browsers don't have it )
            f = (e)->
              if typeof e == 'string'
                label:e
                children:[]
              else
                e
            branch.children = ( f(child) for child in branch.children )

        else
          branch.children = []


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
      # add_branch_to_list: recursively add one branch
      # and all of it's children to the list
      #
      add_branch_to_list = (level,branch,visible)->

        if not branch.expanded?
          branch.expanded = false

        if not branch.classes?
          branch.classes = []

        #
        # icons can be Bootstrap or Font-Awesome icons:
        # they will be rendered like:
        # <i class="icon-plus"></i>
        #
        if not branch.noLeaf and (not branch.children or branch.children.length == 0)
          tree_icon = attrs.iconLeaf
          branch.classes.push "leaf" if "leaf" not in branch.classes
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
          classes   : branch.classes
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

    #
    # expand to the proper level
    #
    n = scope.treeData.length
    console.log 'num root branches = '+n
    for_each_branch (b,level)->
      b.level = level
      b.expanded = b.level < expand_level
      #b.expanded = false


    #
    # TREE-CONTROL : the API to the Tree
    #
    #  if we have been given an Object for this,
    #  then we attach all of tree-control functions 
    #  to that given object:
    #
    if scope.treeControl?
      if angular.isObject scope.treeControl
        tree = scope.treeControl

        tree.expand_all = ->
          for_each_branch (b,level)->
            b.expanded = true

        tree.collapse_all = ->
          for_each_branch (b,level)->
            b.expanded = false

        tree.get_first_branch = ->
          n = scope.treeData.length
          if n > 0
            return scope.treeData[0]

        tree.select_first_branch = ->
          b = tree.get_first_branch()
          tree.select_branch(b)

        tree.get_selected_branch = ->
          selected_branch

        tree.get_parent_branch = (b)->
          get_parent(b)

        tree.select_branch = (b)->
          select_branch(b)
          b

        tree.get_children = (b)->
          b.children

        tree.select_parent_branch = (b)->
          if not b?
            b = tree.get_selected_branch()
          if b?
            p = tree.get_parent_branch(b)
            if p?
              tree.select_branch(p)
              p


        tree.add_branch = (parent,new_branch)->
          if parent?
            parent.children.push new_branch
            parent.expanded = true
          else
            scope.treeData.push new_branch
          #tree.select new_branch
          new_branch

        tree.add_root_branch = (new_branch)->
          tree.add_branch null, new_branch
          new_branch

        tree.expand_branch = (b)->
          if not b?
            b = tree.get_selected_branch()
          if b?
            b.expanded = true
            b

        tree.collapse_branch = (b)->
          b ?= selected_branch
          if b?
            b.expanded = false
            b


        tree.get_siblings = (b)->
          b ?= selected_branch
          if b?
            p = tree.get_parent_branch(b)
            if p
              siblings = p.children
            else
              siblings = scope.treeData # the root branches
            return siblings


        tree.get_next_sibling = (b)->
          b ?= selected_branch
          if b?
            siblings = tree.get_siblings(b)
            n = siblings.length
            i = siblings.indexOf b
            if i < n
              return siblings[i+1]


        tree.get_prev_sibling = (b)->
          b ?= selected_branch
          siblings = tree.get_siblings(b)
          n = siblings.length
          i = siblings.indexOf b
          if i > 0
            return siblings[i-1]


        tree.select_next_sibling = (b)->
          b ?= selected_branch
          if b?
            next = tree.get_next_sibling(b)
            if next?
              tree.select_branch next


        tree.select_prev_sibling = (b)->
          b ?= selected_branch
          if b?
            prev = tree.get_prev_sibling(b)
            if prev?
              tree.select_branch prev


        tree.get_first_child = (b)->
          b ?= selected_branch
          if b?
            if b.children?.length > 0
              return b.children[0]


        tree.get_closest_ancestor_next_sibling = (b)->
          next = tree.get_next_sibling(b)
          if next?
            return next
          else
            parent = tree.get_parent_branch(b)
            return tree.get_closest_ancestor_next_sibling(parent)




        tree.get_next_branch = (b)->
          #
          # "next" in the sense of...vertically, from top to bottom
          #
          # try:
          # 1) next sibling
          # 2) first child
          # 3) parent.get_next() // recursive
          #
          b ?= selected_branch
          if b?
            next = tree.get_first_child(b)
            if next?
              return next
            else
              next = tree.get_closest_ancestor_next_sibling(b)
              return next


        tree.select_next_branch = (b)->          
          b ?= selected_branch
          if b?
            next = tree.get_next_branch(b)
            if next?
              tree.select_branch(next)
              next


        tree.last_descendant = (b)->
          if not b?
            debugger
          n = b.children.length
          if n == 0
            return b
          else
            last_child = b.children[n-1]
            return tree.last_descendant(last_child)


        tree.get_prev_branch = (b)->
          b ?= selected_branch
          if b?
            prev_sibling = tree.get_prev_sibling(b)
            if prev_sibling?
              return tree.last_descendant prev_sibling
            else
              parent = tree.get_parent_branch(b)
              return parent

        tree.select_prev_branch = (b)->
          b ?= selected_branch
          if b?
            prev = tree.get_prev_branch(b)
            if prev?
              tree.select_branch(prev)
              return prev
]










