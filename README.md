# Apache Creadur RAT - GitHub Action

## What is RAT Action?

[Apache Release Audit Tool (Rat)](https://creadur.apache.org/rat) is a release audit tool, focused on licenses.

The goal of this GitHub Action is to allow Apache projects to run the release audit tool with in their GitHub Action workflow (CI).

This would allow projects to quickly detect if new files during a PR submission or commit push was missing the license header.

## Usage

In your project repo, create a new GitHub Action workflow.

E.g. Directory Structure & Files

```text
.
├── .github
│   └── workflows
│       └── action.yml
├── .ratignore
```

The `action.yml` file can be renamed to anything you prefer (e.g., `rat.yml`), but it must remain in this folder path and have the `.yml` extension. For consistency, we will refer to this file as `action.yml` throughout this documentation.

In the `.github/workflows/action.yml` file, write:

```yml
name: Release Auditing

on: [push, pull_request]

permissions:
  contents: read

jobs:
  test:
    name: Check License Headers
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - uses: erisu/apache-rat-action@v2
```

This action workflow will checkout the project's content and run the RAT tool.

Create the optional `.ratignore` file if you want to exclude certain files and folders from being tested.

### Configure the Apache Creadur RAT version

When using the `erisu/apache-rat-action` GitHub Action you can choose which version of the Apache Creadur RAT tool to run.

Although the action has a default version (which is usually recommended), you can override it.

Note: Not every Apache Creadur RAT release is guaranteed to work with every version of the action. Please review the Version Compatibility Matrix in this README before changing the version.

To override the version, add the `rat-version` setting to the `with` block when using this action. For example:

```yml
- uses: erisu/apache-rat-action@v2
  with:
    rat-version: '0.17'
```

## Version Compatibility Matrix

| Action Version | Default Apache Creadur RAT Version | Compatible Apache Creadur RAT Version |
| -- | -- | -- |
| 2.0.0 | 0.17 | 0.17 & newer |
| 1.2.0 | 0.16.1 | 0.14 - 0.16.x |

## License

  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

## Contribution

If you want to contribute, fork the repo, create a branch from main, and submit a pull request on GitHub.

<!-- Uncomment if Creadur RAT wants to take ownership of the project -->
<!--
You should file a Contributor License Agreement (CLA) in order to properly handle your input.

Apart from that you can file an issue in ASF's Jira: [project RAT](https://issues.apache.org/jira/browse/RAT
 -->
