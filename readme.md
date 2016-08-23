# CI Shell Scripts

Shell scripts taking care of common jobs related to Continuous Integration. While meant for [Travis CI][travis] these work on any Linux system.

## Features

- Setting up the Travis CI environment
- Deploying Maven artifacts, including the Maven site

## Usage

These scripts should be imported into the project environment, and then run as part of the CI process. As these are just shell scripts they can be copied into any folder, and be run just by calling them.

For example, to create the Maven settings file the following line can be used:

```
~/.scripts/java/maven/create-maven-settings.sh $VERSION_TYPE
```

To find out the exact requirements of each script check its comments.

Example Travis files are included, showing how they are meant to be used.

### Prerequisites

These are shell scripts, meant for a Linux system, and requiring a shell interpreter.

### Installing

The scripts should be taken from the repo prior to being used. It is recommended taking them from a specific tag, just like this:

```
git clone -b [tag] --single-branch https://github.com/Bernardo-MG/ci-shell-scripts.git ~/.scripts
```

With this the scripts will be located in the ~/.scripts folder.

## Collaborate

Any kind of help with the project will be well received, and there are two main ways to give such help:

- Reporting errors and asking for extensions through the issues management
- or forking the repository and extending the project

### Issues management

Issues are managed at the GitHub [project issues tracker][issues], where any Github user may report bugs or ask for new features.

### Getting the code

If you wish to fork or modify the code, visit the [GitHub project page][scm], where the latest versions are always kept. Check the 'master' branch for the latest release, and the 'develop' for the current, and stable, development version.

## License
The project has been released under the [MIT License][license].

[issues]: https://github.com/Bernardo-MG/ci-shell-scripts/issues
[license]: http://www.opensource.org/licenses/mit-license.php
[scm]: http://github.com/Bernardo-MG/ci-shell-scripts

[travis]: https://travis-ci.org/
