
angular-bootstrap-nav-tree
==========================

This is a Tree directive for Angular JS apps that use Bootstrap CSS.

example: http://nickperkinslondon.github.io/angular-bootstrap-nav-tree/test/test_abn_tree.html

The style is completely Bootstrap because the tree is actually just a Bootstrap "nav" list, with a few changes:  Indentation is added, expand/collapse icons are added, and Angular CSS animations are used during expand/collapse.

The normal Glyphicons work well, but they appear black instead of blue.  Alternatively, you can use the Font Awesome icons, which look even better, and match the blue color of the text.

You can change the icons used by specifying them in html attributes.

This tree is developed in CoffeeScript, Jade, and Less, but you don't need to be using any of those to use this tree -- you just have to be using Angular and Bootsrap.


How to use it:
Just include the 3 files from "dist":

    abn_tree_directive.js
    abn_tree_style.css
    abn_tree_template.html

NOTE: you will have to adjust the "templateUrl" in the directive js, to adjust for your directory structure.


Then put an `<abn-tree>` directive in your HTML.
( see the example in "test" )

At a miniumum, you must supply `tree-data` :

    <abn-tree tree-data="example_treedata"></abn-tree>

But there are other attributes to customize the tree:

    <abn-tree 
        header="This is the example tree"
        tree-data="example_treedata"
        icon-leaf="icon-file"
        icon-expand="icon-plus-sign"
        icon-contract="icon-minus-sign"
        on-select="my_default_handler(branch)"
        expand-level="2"
        initial-selection="Vegetable">      
    ></abn-tree>


The data to create the tree is defined in your controller, and could be as simple as this:

    $scope.my_data = [{
      label: 'Languages',
      children: ['Jade','Less','Coffeescript']
    }]

If you you this short-form for listing elements, then your "on-select" function will have to act based only upon the "branch.label".  If you use the long-form, where is branch is an object, then you can also attach "data" to a branch.



You can supply a single default "on-select" function for the whole tree -- it will be called whenever a branch is selected:

    $scope.my_default_hander = function(branch){...}


Or, you can put a custom "on-select" function on an individual branch:

    $scope.my_data = [{
      label: 'Languages',
      onSelect: function(branch){...},
      children: ['Jade','Less','Coffeescript']
    }]
    
Each branch can have a "data" element which you can use to hold whatever data you want.  It is not touched by the tree, and it is available to your "on-select" functions as "branch.data".  In the example, in the "test" folder, this technique is used in "my_default_handler" to add extra info to "Dog","Cat", and "Hippo".  

Warning: If you attach extra attributes directly to a branch (instead of to "branch.data"), they could conflict with the internal workings of the tree, which adds branch attributes at runtime, like "expanded" and "selected".


