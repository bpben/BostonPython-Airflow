FROM centos:8

ARG AIRFLOW_VERSION=1.10.6
ENV AIRFLOW_HOME /usr/local/airflow

COPY scripts/entrypoint.sh /entrypoint.sh
COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

# check that certain services have started properly
COPY scripts/check_postgres.py ${AIRFLOW_HOME}/check_postgres.py
COPY scripts/check_postgres.py ${AIRFLOW_HOME}/check_redis.py

# these are needed only to install necessary packages
COPY ./yum_requirements.txt /tmp/yum_requirements.txt
COPY ./pip_requirements.txt /tmp/pip_requirements.txt

# install system and python packages
RUN  yum -y update \
    && yum -y install $(cat /tmp/yum_requirements.txt) \
    && useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow \
    && pip3 install -r /tmp/pip_requirements.txt \
    && yum clean all \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

# setup directories and users
RUN chown -R airflow: ${AIRFLOW_HOME} \
    && mkdir -p /tmp/work/ \
    && chown -R airflow: /tmp/work \
    && chmod 755 /entrypoint.sh \
    && chmod u+w /etc/sudoers \
    && echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

EXPOSE 8080 5555 8793

USER airflow
WORKDIR ${AIRFLOW_HOME}
RUN mkdir /usr/local/airflow/logs
ENTRYPOINT ["/entrypoint.sh"]
