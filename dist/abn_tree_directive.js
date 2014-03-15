var module;

module = angular.module('angularBootstrapNavTree', []);

module.directive('abnTree', function($timeout) {
  return {
    restrict: 'E',
    templateUrl: '../dist/abn_tree_template.html',
    scope: {
      treeData: '=',
      onSelect: '&',
      initialSelection: '@'
    },
    link: function(scope, element, attrs) {
      var error, expand_all_parents, expand_level, for_all_ancestors, for_each_branch, get_parent, on_treeData_change, select_branch, selected_branch;
      error = function(s) {
        console.log('ERROR:' + s);
        debugger;
        return void 0;
      };
      if (attrs.iconExpand == null) {
        attrs.iconExpand = 'fa fa-plus';
      }
      if (attrs.iconCollapse == null) {
        attrs.iconCollapse = 'fa fa-minus';
      }
      if (attrs.iconLeaf == null) {
        attrs.iconLeaf = 'fa fa-file';
      }
      if (attrs.expandLevel == null) {
        attrs.expandLevel = '3';
      }
      expand_level = parseInt(attrs.expandLevel, 10);
      scope.header = attrs.header;
      if (!scope.treeData) {
        alert('no treeData defined for the tree!');
        return;
      }
      if (scope.treeData.length == null) {
        if (treeData.label != null) {
          scope.treeData = [treeData];
        } else {
          alert('treeData should be an array of root branches');
          return;
        }
      }
      for_each_branch = function(f) {
        var do_f, root_branch, _i, _len, _ref, _results;
        do_f = function(branch, level) {
          var child, _i, _len, _ref, _results;
          f(branch, level);
          if (branch.children != null) {
            _ref = branch.children;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              child = _ref[_i];
              _results.push(do_f(child, level + 1));
            }
            return _results;
          }
        };
        _ref = scope.treeData;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          root_branch = _ref[_i];
          _results.push(do_f(root_branch, 1));
        }
        return _results;
      };
      for_each_branch(function(b, level) {
        b.level = level;
        return b.expanded = b.level < expand_level;
      });
      selected_branch = null;
      select_branch = function(branch) {
        if (!branch) {
          if (selected_branch != null) {
            selected_branch.selected = false;
          }
          selected_branch = null;
          return;
        }
        if (branch !== selected_branch) {
          if (selected_branch != null) {
            selected_branch.selected = false;
          }
          branch.selected = true;
          selected_branch = branch;
          expand_all_parents(branch);
          if (branch.onSelect != null) {
            return $timeout(function() {
              return branch.onSelect(branch);
            });
          } else {
            if (scope.onSelect != null) {
              return $timeout(function() {
                return scope.onSelect({
                  branch: branch
                });
              });
            }
          }
        }
      };
      scope.user_clicks_branch = function(branch) {
        if (branch !== selected_branch) {
          return select_branch(branch);
        }
      };
      get_parent = function(child) {
        var parent;
        parent = void 0;
        if (child.parent_uid) {
          for_each_branch(function(b) {
            if (b.uid === child.parent_uid) {
              return parent = b;
            }
          });
        }
        return parent;
      };
      for_all_ancestors = function(child, fn) {
        var parent;
        parent = get_parent(child);
        if (parent != null) {
          fn(parent);
          return for_all_ancestors(parent, fn);
        }
      };
      expand_all_parents = function(child) {
        return for_all_ancestors(child, function(b) {
          return b.expanded = true;
        });
      };
      scope.tree_rows = [];
      on_treeData_change = function() {
        var add_branch_to_list, root_branch, _i, _len, _ref, _results;
        for_each_branch(function(b, level) {
          if (!b.uid) {
            return b.uid = "" + Math.random();
          }
        });
        console.log('UIDs are set.');
        for_each_branch(function(b) {
          var child, _i, _len, _ref, _results;
          if (angular.isArray(b.children)) {
            _ref = b.children;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              child = _ref[_i];
              _results.push(child.parent_uid = b.uid);
            }
            return _results;
          }
        });
        scope.tree_rows = [];
        for_each_branch(function(branch) {
          if (branch.children) {
            if (branch.children.length > 0) {
              return branch.children = branch.children.map(function(e) {
                if (typeof e === 'string') {
                  return {
                    label: e,
                    children: []
                  };
                } else {
                  return e;
                }
              });
            }
          } else {
            return branch.children = [];
          }
        });
        add_branch_to_list = function(level, branch, visible) {
          var child, child_visible, tree_icon, _i, _len, _ref, _results;
          if (branch.expanded == null) {
            branch.expanded = false;
          }
          if (!branch.children || branch.children.length === 0) {
            tree_icon = attrs.iconLeaf;
          } else {
            if (branch.expanded) {
              tree_icon = attrs.iconCollapse;
            } else {
              tree_icon = attrs.iconExpand;
            }
          }
          scope.tree_rows.push({
            level: level,
            branch: branch,
            label: branch.label,
            tree_icon: tree_icon,
            visible: visible
          });
          if (branch.children != null) {
            _ref = branch.children;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              child = _ref[_i];
              child_visible = visible && branch.expanded;
              _results.push(add_branch_to_list(level + 1, child, child_visible));
            }
            return _results;
          }
        };
        _ref = scope.treeData;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          root_branch = _ref[_i];
          _results.push(add_branch_to_list(1, root_branch, true));
        }
        return _results;
      };
      scope.$watch('treeData', on_treeData_change, true);
      if (attrs.initialSelection != null) {
        return for_each_branch(function(b) {
          if (b.label === attrs.initialSelection) {
            return $timeout(function() {
              return select_branch(b);
            });
          }
        });
      }
    }
  };
});
