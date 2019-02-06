FROM debian:jessie
MAINTAINER info@tango-controls.org

echo "deb https://dl.bintray.com/tango-controls/<REPOSITORY_NAME> {distribution} {components}" | sudo tee -a /etc/apt/sources
RUN apt-get update && apt-get install -y tango-test-dev
