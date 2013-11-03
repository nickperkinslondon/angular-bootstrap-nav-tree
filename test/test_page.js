var app, deps;

deps = ['angularBootstrapNavTree'];

if (angular.version.full.indexOf("1.2") >= 0) {
  deps.push('ngAnimate');
}

app = angular.module('AbnTest', deps);

app.controller('AbnTestController', function($scope) {
  var apple_selected;
  $scope.my_tree_handler = function(branch) {
    var _ref;
    $scope.output = "You selected: " + branch.label;
    if ((_ref = branch.data) != null ? _ref.description : void 0) {
      return $scope.output += '(' + branch.data.description + ')';
    }
  };
  apple_selected = function(branch) {
    return $scope.output = "APPLE! : " + branch.label;
  };
  $scope.example_treedata = [
    {
      label: 'Animal',
      children: [
        {
          label: 'Dog',
          data: {
            description: "man's best friend"
          }
        }, {
          label: 'Cat',
          data: {
            description: "Felis catus"
          }
        }, {
          label: 'Hippopotamus',
          data: {
            description: "hungry, hungry"
          }
        }, {
          label: 'Chicken',
          children: ['White Leghorn', 'Rhode Island Red', 'Jersey Giant']
        }
      ]
    }, {
      label: 'Vegetable',
      data: {
        definition: "A plant or part of a plant used as food, typically as accompaniment to meat or fish, such as a cabbage, potato, carrot, or bean.",
        data_can_contain_anything: true
      },
      onSelect: function(branch) {
        return $scope.output = "Vegetable: " + branch.data.definition;
      },
      children: [
        {
          label: 'Oranges'
        }, {
          label: 'Apples',
          children: [
            {
              label: 'Granny Smith',
              onSelect: apple_selected
            }, {
              label: 'Red Delicous',
              onSelect: apple_selected
            }, {
              label: 'Fuji',
              onSelect: apple_selected
            }
          ]
        }
      ]
    }, {
      label: 'Mineral',
      children: [
        {
          label: 'Rock',
          children: ['Igneous', 'Sedimentary', 'Metamorphic']
        }, {
          label: 'Metal',
          children: ['Aluminum', 'Steel', 'Copper']
        }, {
          label: 'Plastic',
          children: [
            {
              label: 'Thermoplastic',
              children: ['polyethylene', 'polypropylene', 'polystyrene', ' polyvinyl chloride']
            }, {
              label: 'Thermosetting Polymer',
              children: ['polyester', 'polyurethane', 'vulcanized rubber', 'bakelite', 'urea-formaldehyde']
            }
          ]
        }
      ]
    }
  ];
  return $scope.try_changing_the_tree_data = function() {
    return $scope.example_treedata = [
      {
        label: 'North America',
        children: [
          {
            label: 'Canada',
            children: ['Toronto', 'Vancouver']
          }, {
            label: 'USA',
            children: ['New York', 'Los Angeles']
          }, {
            label: 'Mexico',
            children: ['Mexico City', 'Guadalajara']
          }
        ]
      }, {
        label: 'South America',
        children: [
          {
            label: 'Venezuela',
            children: ['Caracas', 'Maracaibo']
          }, {
            label: 'Brazil',
            children: ['Sao Paulo', 'Rio de Janeiro']
          }, {
            label: 'Argentina',
            children: ['Buenos Aires', 'Cordoba']
          }
        ]
      }
    ];
  };
});
