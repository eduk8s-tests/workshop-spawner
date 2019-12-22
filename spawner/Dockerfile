FROM fedora:31

RUN HOME=/root && \
    INSTALL_PKGS=" \
        findutils \
        gcc \
        gettext \
        git \
        glibc-langpack-en \
        httpd \
        httpd-devel \
        jq \
        less \
        nodejs \
        procps \
        python3 \
        python3-devel \
        python3-pip \
        python3-virtualenv \
        redhat-rpm-config \
        supervisor \
        sudo \
        which \
    " && \
    dnf install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    dnf clean -y --enablerepo='*' all && \
    sed -i.bak -e '1i auth requisite pam_deny.so' /etc/pam.d/su && \
    sed -i.bak -e 's/^%wheel/# %wheel/' /etc/sudoers && \
    useradd -u 1001 -g 0 -M -d /home/eduk8s eduk8s && \
    mkdir -p /home/eduk8s && \
    chown -R 1001:0 /home/eduk8s && \
    chmod -R g=u /home/eduk8s && \
    chmod g+w /etc/passwd && \
    chown 1001:0 /opt

RUN HOME=/root && \
    npm install -g configurable-http-proxy

COPY usr/. /usr/

COPY --chown=1001:0 opt/. /opt/

ENV PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    PIP_NO_CACHE_DIR=off \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

RUN rm /etc/supervisord.conf && \
    ln -s /opt/eduk8s/etc/supervisord.conf /etc/supervisord.conf && \
    mkdir -p /var/run/spawner/data && \
    chown -R 1001:0 /opt && \
    chmod -R g=u /var/run/spawner

USER 1001

RUN HOME=/opt/spawner && \
    cd /opt/spawner && \
    virtualenv /opt/spawner/venv && \
    source /opt/spawner/venv/bin/activate && \
    pip install -U pip setuptools wheel && \
    pip install -r requirements.txt

ENV HOME=/home/eduk8s

WORKDIR /home/eduk8s

RUN fix-permissions /home/eduk8s

ENV BASH_ENV=/opt/eduk8s/etc/profile \
    ENV=/opt/eduk8s/etc/profile \
    PROMPT_COMMAND=". /opt/eduk8s/etc/profile"

ENTRYPOINT [ "container-entrypoint" ]

EXPOSE 8080

CMD [ "start-container" ]
