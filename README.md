
angular-bootstrap-nav-tree
==========================

This is a Tree directive for Angular JS apps that use Bootstrap CSS.  The tree style will match everything else because the tree is actually just a Bootstrap "nav" list, with a few changes:  Indentation is added to make the list look like a tree, icons are used for the expand/collapse controls,and Angular CSS animations are used during expand/collapse.

The result is a very clean-looking control that resebles a cross between a traditional Tree control, and a Bootsrap "nav-stacked" control.  It will always match the style of the other Bootrap stuff on your page because it _is_ Bootstrap.

The normal Glyphicons work well, but you can also include the Font Awesome icons, which work nicely, with no changes required.  You can change the icons used by specifying them in html attributes.

This tree is developed in CoffeeScript, Jade, and Less, but you don't need to be using any of those to use this tree -- you just have to be using Angular and Bootsrap.


How to use it:
Just include the 3 files from "dist":

    abn_tree_directive.js
    abn_tree_style.css
    abn_tree_template.html


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

    $sope.my_default_hander = function(branch){...}

Whatever datastructure you provide as `tree-data` will be used by the tree, which will also add attributes ( like "expanded" and "icon" ).  If you want to keep your "real" data separate and un-modified, you could do a `$watch` on your real data, and modify the tree-data accordingly.


