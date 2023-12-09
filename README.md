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

In the `.github/workflows/action.yml` file, write:

```yml
name: Release Auditing

on: [push, pull_request]

jobs:
  test:
    name: Check License Headers
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: erisu/apache-rat-action@v1
```

This action workflow will checkout the project's content and run the RAT tool.

Create the optional `.ratignore` file if you want to exclude certain files and folders from being tested.

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

If you want to contribute, feel free to branch from master and provide a pull request via Github.

<!-- Uncomment if Creadur RAT wants to take ownership of the project -->
<!--
You should file a Contributor License Agreement (CLA) in order to properly handle your input.

Apart from that you can file an issue in ASF's Jira: [project RAT](https://issues.apache.org/jira/browse/RAT
 -->
