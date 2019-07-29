ARG  TANGO_VER
FROM tangocs/tango-libs:${TANGO_VER}
MAINTAINER info@tango-controls.org

RUN runtimeDeps='supervisor' \
    && DEBIAN_FRONTEND=noninteractive sudo apt-get update \
    && DEBIAN_FRONTEND=noninteractive sudo apt-get -y install --no-install-recommends $runtimeDeps

# Configure supervisord. Ensure supervisord.conf contains entries for your device!
COPY supervisord.conf /etc/supervisor/conf.d/

#TODO failed to start supervisor under tango user - Permission denied
USER root

# Start supervisor as daemon
CMD ["/usr/bin/supervisord", "--configuration", "/etc/supervisor/supervisord.conf"]