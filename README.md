Suggest-lib Pipeline
===
#### This repository contains the suggest-lib pipeline. The pipeline is used to build, test, and release an application.

The pipeline includes the following steps:
===
#### Build (mvn verify)

- Compile the code
- Run tests

#### When is Master

- Compile the code
- Run tests
- Publish the code as a snapshot (using mvn depot)

#### When is Release

- Calculate the correct version based on the branch and the last tag
- Update the version in the source code (using mvn versions: set)
- Compile the code
- Run tests
- Publish the code
- Tag the release (using git clean, git tag, and git push)

#### Multibranch Pipeline Stages

- When the branch is a release branch, calculate the correct version based on the branch and the last tag
Compile the code
- Run tests
- When the branch is a release branch or the master branch, publish the code
- When the branch is a release branch, tag the release
