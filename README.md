# Coder Rust Template

This repository is filled with Docker images and templates for [Coder](https://github.com/coder/coder). All ready for Rust development with [code-server](https://github.com/coder/code-server)

**Looking for more languages? Check out [Coder Universal Template](https://gitlab.com/8Bitz0/coder-universal-template).**

## Getting Started

Make sure you've installed [Coder](https://coder.com/docs/coder-oss/latest/install) and [Docker](https://www.docker.com/get-started/) on your server. Make sure you're logged into the Coder command-line utility on your client. More information is available [here](https://coder.com/docs/coder-oss/latest/quickstart).

If you are ready to get the templates, this part should be easy. Clone the Git repository:

`git clone https://gitlab.com/8Bitz0/coder-rust-template`

Decide a Linux "distro" and version to use. Usually the format is `<distro>/<version>` Change your working directory to the template you chose.

`cd coder-rust-templates/templates/<distro>/<version>/`

If you are logged into your Coder instance, you can run `coder template create`. It will ask you to confirm, if all went well, you've got the template installed! Go onto your instance's dashboard, and click `Templates`. Open up your new template, and click `Settings`. Configure it as you need.

You should have a template ready to use!

## Credits

 - [jsjoeio/coder-templates @ GitHub](https://github.com/jsjoeio/coder-templates) - Docker templates that prompt for dotfiles and base Docker image.

## Contributing

There are multiple ways you can help:

 - The README needs some changes to be more clear
 - GitLab CI/CD needs to be set up
 - Docker images may need some extra installed packages
