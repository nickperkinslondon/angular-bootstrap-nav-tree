angular-bootstrap-nav-tree
==========================

This is a Tree directive for Angular JS apps that use Bootstrap CSS.

example: http://nickperkinslondon.github.io/angular-bootstrap-nav-tree/test/bs3_ng120_test_page.html

The style is completely Bootstrap because the tree is actually just a Bootstrap "nav" list, with a few changes:  Indentation is added, expand/collapse icons are added, and Angular CSS animations are used during expand/collapse.

The abn-tree now works Bootsrap 2, or Bootstrap 3, and with Angular 1.1.5 or 1.2.0

The normal Glyphicons work well, but they appear black instead of blue.  Alternatively, you can use the Font Awesome icons, which look even better, and match the blue color of the text.

You can change the icons used by specifying them in html attributes.

This tree is developed using CoffeeScript and Jade, but you don't need to be using either of those to use this tree -- you just have to be using Angular and Bootsrap.


How to use it:
Just include the 2 files from "dist",

    abn_tree_directive.js
    abn_tree.css

Add `'angularBootstrapNavTree'` to your module's list of dependencies.

Then put an `<abn-tree>` directive in your HTML.
( see the example in "test" )

At a miniumum, you must supply `tree-data` :

    <abn-tree tree-data="example_treedata"></abn-tree>

But there are other attributes to customize the tree:

    <abn-tree 
        tree-data         = "my_treedata"
        tree-control      = "my_tree"
        icon-leaf         = "icon-file"
        icon-expand       = "icon-plus-sign"
        icon-collapse     = "icon-minus-sign"
        on-select         = "my_tree_handler(branch)"
        expand-level      = "2"
        initial-selection = "Vegetable">      
    ></abn-tree>

The example uses Font-Awesome 3, but Font-Awsome 4 also works.
Use the following syntax:

    icon-leaf = "fa fa-file"
    
( in general, use spaces to apply multiple classes to icon elements )


The data to create the tree is defined in your controller, and could be as simple as this:

    $scope.my_data = [{
      label: 'Languages',
      children: ['Jade','Less','Coffeescript']
    }]

There is a long-form for elements, in which each node is an object with a "label", and optionally other stuff like "data", and "children".
There is a short-form for listing nodes children (as used for "children" above), where the "children" is just a list of strings.
If you use the short-form for listing elements, then your "on-select" function will have to act based only upon the "branch.label".  If you use the 
long-form, where is branch is an object, then you can also attach "data" to a branch.

If you would like to add classes to a certain node, give it an array of classes like so:

    $scope.my_data = [{
      label: 'Languages',
      children: ['Jade','Less','Coffeescript']
      classes: ["special", "red"]
    }]

Each element without children, or leaf, is automatically given a leaf class. If you would like to force certain nodes not to be leaves (won't get leaf class and will show expand/collapse icons), set noLeaf to true in a long-form listing like so:

    {
      label: 'Coffeescript',
      noLeaf: true
    }

You can supply a single default "on-select" function for the whole tree -- it will be called whenever a branch is selected:

    $scope.my_tree_hander = function(branch){...}


Or, you can put a custom "on-select" function on an individual branch:

    $scope.my_data = [{
      label: 'Languages',
      onSelect: function(branch){...},
      children: ['Jade','Less','Coffeescript']
    }]
    
Each branch can have a "data" element which you can use to hold whatever data you want.  It is not touched by the tree, and it is available to your "on-select" function as "branch.data".  In the example, in the "test" folder, this technique is used in "my_tree_handler" to add extra info to "Dog","Cat", and "Hippo".  

Warning: If you attach extra attributes directly to a branch (instead of to "branch.data"), they could conflict with the internal workings of the tree, which adds branch attributes at runtime, like "expanded" and "selected".

Tree-Control API:
If you pass an empty object to the tree as "tree-control", it will be populated with a set of functions for navigating and controlling the tree.  See the example page for a demo...
