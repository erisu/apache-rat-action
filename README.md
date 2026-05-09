# Apache Creadur RAT - GitHub Action

## What is RAT Action?

[Apache Release Audit Tool (RAT)](https://creadur.apache.org/rat) is a release audit tool, focused on licenses.

The goal of this GitHub Action is to allow Apache projects to run the release audit tool with in their GitHub Action workflow (CI).

This would allow projects to quickly detect if new files during a PR submission or commit push was missing the license header.

## Usage

### Example Project Directory Structure

```text
.
├── .github
│   └── workflows
│       └── action.yml
├── .ratignore
```

### Configuring the Project Workflow

In your project repo, create a new GitHub Action workflow file at:

```text
.github/workflows/action.yml
```

> [!NOTE]
> The file can be renamed to anything you prefer (e.g., `rat.yml`), but it must remain in the `.github/workflows/` directory and use the `.yml` extension.

For consistency, we will refer to this file as `action.yml` throughout this documentation.

Add the following configuration to `.github/workflows/action.yml`:

```yml
name: Release Auditing

on: [push, pull_request]

jobs:
  apacherat:
    name: Apache RAT (License Header Checker)

    permissions:
      contents: read

    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
        with:
          persist-credentials: false
      - uses: erisu/apache-rat-action@v3
```

This workflow checks out the repository contents and runs the Apache Creadur RAT tool.

### Configuring the RAT Exclude File

The RAT exclude configuration file is optional.

To exclude specific files or directories from being tested, create either a `.ratignore` or `.rat-excludes` file and list the items you want excluded.

By default, this action searches for the following files in this order, and uses the first file it finds:

1. `.ratignore`
2. `.rat-excludes`

You can also define a custom exclude file name using the `rat-exclude-filename` setting in the `with` block:

```yml
- uses: erisu/apache-rat-action@v3
  with:
    rat-exclude-filename: '.custom-rat-excludes'
```

The exclude file must reside in the project's root directory.

> [!WARNING]
> The workflow will fail if `rat-exclude-filename` is specified but the file does not exist. In this case, the action will not fall back to the default exclude files.

### Configuring the Apache Creadur RAT Version

When using the `erisu/apache-rat-action` GitHub Action, you can choose which version of the Apache Creadur RAT tool to run.

Although the action provides a default version (recommended in most cases), you can override it if needed.

> [!WARNING]
> Not every Apache Creadur RAT release is guaranteed to work with every version of the action. Before changing the version, review the Version Compatibility Matrix in this README.

To override the default version, add the `rat-version` setting to the `with` block:

```yml
- uses: erisu/apache-rat-action@v3
  with:
    rat-version: '0.18'
```

## Testing Locally

This action can be tested locally by building the Docker image and running it against a target directory.

1. Ensure Docker is installed and running.
2. Clone this repository and change your working directory to the cloned repository.
3. Build the Docker image:

  ```bash
  docker build -t apache-rat-action .
  ```

4. Navigate to the target directory you want to analyze.
5. Run the image:

  ```bash
  docker run --rm -t \
    --cap-drop=ALL \
    --security-opt=no-new-privileges \
    -e GITHUB_WORKSPACE=/workspace \
    -e INPUT_RAT_VERSION=0.18 \
    -v "$(pwd):/workspace:ro" \
    apache-rat-action
  ```

## Version Compatibility Matrix

| Action Version | Default Apache Creadur RAT Version | Compatible Apache Creadur RAT Version |
| -- | -- | -- |
| 3.0.0 | 0.18 | 0.17 & newer |
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
