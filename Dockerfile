# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# eclipse-temurin:25.0.3_9-jdk
FROM eclipse-temurin@sha256:dfc0093e3dbf43dae57827111c6e374f5b44fac19a9451584b2b336b81474d64

# Install dependecies
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Create a non-root user and group to follow least-privilege principles.
RUN groupadd --system app \
 && useradd --system --gid app app

# Set working directory for the action's code inside the container image
WORKDIR /app

RUN chown -R app:app /app
COPY --chown=app:app verify-header-licenses json.xsl ./

# Make script executable
RUN chmod +x /app/verify-header-licenses

# Drop privileges
USER app

# Run the script with sh
ENTRYPOINT ["/bin/bash", "/app/verify-header-licenses"]
