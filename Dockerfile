ARG  TANGO_VER=9.3.3-rc1
FROM tangocs/tango-libs:${TANGO_VER}
MAINTAINER info@tango-controls.org

RUN runtimeDeps='supervisor' \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends $runtimeDeps

# Configure supervisord. Ensure supervisord.conf contains entries for your device!
COPY supervisord.conf /etc/supervisor/conf.d/
COPY tango_register_device /usr/local/bin/

RUN useradd --create-home --home-dir /home/tango tango

RUN echo "tango ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/tango \
    && chmod 0440 /etc/sudoers.d/tango

#TODO failed to start supervisor under tango user - Permission denied
USER root

# Start supervisor as daemon
CMD ["/usr/bin/supervisord", "--configuration", "/etc/supervisor/supervisord.conf"]