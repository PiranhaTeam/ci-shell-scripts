# CI Shell Scripts

Shell scripts for common Continous Integration tasks. They are meant for [Travis CI][travis].

While they are meant to be generic, these scripts were prepared for my own projects, and in some cases may have very specific requirements.

To see how these scripts are meant to be used, take a look at these template projects:

- [Library Maven Archetype][library_archetype]
- [Cookiecutter Python Library][cookiecutter-python]

## Features

- Setting up the Travis CI environment
- Deploying Maven artifacts, including the Maven site and JARs
- CI flow control, run or skip scripts based on the context

## Usage

To use them copy the repository. Use a specific tag to ensure having always the same version:

```
git clone -b [tag] --single-branch https://github.com/Bernardo-MG/ci-shell-scripts.git ~/.scripts
```

In this case they are copied to the ~/.scripts folder.

Ensure they have execution permissions:

```
chmod -R +x ~/.scripts/*
```

To find out the exact requirements of each script check its comments.

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

[library_archetype]: https://github.com/Bernardo-MG/library-maven-archetype
[cookiecutter-python]: https://github.com/Bernardo-MG/cookiecutter-python-library

[issues]: https://github.com/Bernardo-MG/ci-shell-scripts/issues
[license]: http://www.opensource.org/licenses/mit-license.php
[scm]: http://github.com/Bernardo-MG/ci-shell-scripts

[travis]: https://travis-ci.org/
