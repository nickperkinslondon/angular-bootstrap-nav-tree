# Contributing

Here are the guidelines and required reading for contributing.

## Getting Started

### Prerequisites
1. [Node.js](https://nodejs.org/en/)
2. [VS Code](https://code.visualstudio.com/) (optional but recommended)

### Setting up the repo
1. Fork the repo and clone to your work environment
2. Run `npm i` to install required dev dependencies
3. Run `npm i -g coffeescript@1.6.3` then run `coffee -c Gruntfile.coffee`
5. Run `grunt` to build the project

### Running Tests

After completing the 'Getting Started' section,
1. Run `webdriver-manager update` to ensure the webdriver for selenium (used by protractor) is up-to-date
2. Open an additional terminal and run `node e2e/express.js` to start serving the test pages
3. In the original terminal, run `protractor e2e/conf.js`

## Pull Request Process

1. Ensure any generated files are ignored.
2. Update the README.md and other documentation as it relates to your changes.
3. Rebase your branch on the latest version of the branch on which it is based. This may need to happen multiple times as other PRs are merged.
