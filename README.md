# The RailsBridge Documentation Project

[![Build
Status](https://travis-ci.org/railsbridge-boston/docs.png)](https://travis-ci.org/railsbridge-boston/docs)

## Overview

This is a Sinatra app, deployed at <http://docs.railsbridgeboston.org>. The RailsBridge documentation project is home to a few subprojects, including the RailsBridge installfest instructions, which leads students through the various complicated setup instructions for getting Ruby, Rails, Git, etc. installed on their computer (whatever combination of computer, OS, and version they happened to bring to the workshop!), as well as the RailsBridge workshop "Suggestotron" curriculum.

Each subproject (a "site") comprises files stored under the "sites" directory; for instance, the installfest instructions are located at ROOT/sites/en/installfest, while the intro rails curriculum can be found under ROOT/sites/en/intro-to-rails. (The "en" means "English" -- see "Locales" below.)

(If multiple files exist with the same base name, `.step` is preferred over `.md`, and `.md` over `.mw`.)

## Getting started

To set up your environment, run:

    bundle install

To run the server:

    bundle exec jekyll serve --incremental

Then open <http://127.0.0.1:4000/> in a web browser, and verify that you can navigate the installfest slides.

## Deploying

The app is hosted at fly.io and collaborators with access can manage the app here: https://fly.io/apps/rbb-docs

Only organizers and invited collaborators are allowed to deploy the app. To do so, run:

    fly deploy

## Contributing

Check out [CONTRIBUTING.md](CONTRIBUTING.md) to see how to join our
[list of contributors](https://github.com/railsbridge-boston/docs/contributors)!

## License

The documentation (including anything under the `sites` subdir as well as some hardcoded text elsewhere) is licensed under a Creative Commons license ([CC-BY,  specifically](http://creativecommons.org/licenses/by/3.0/)), which means you're welcome to share, remix, or use our content commercially. We just ask for attribution.

The code is licensed under an [MIT license](http://opensource.org/licenses/MIT), like Ruby itself. Copyright (c) 2010-2014 by RailsBridge.

## Other Resources

- Workshop organizers: See http://docs.railsbridgeboston.org/workshop for example slide decks you can use in your opening/closing presentations.
