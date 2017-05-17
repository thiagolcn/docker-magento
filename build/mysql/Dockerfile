FROM mysql:5.6.23

COPY ./sampledata/magento-sample-data-1.9.1.0.tgz /opt/
COPY ./bin/export-magento-data /usr/local/bin/export-magento-data
RUN chmod +x /usr/local/bin/export-magento-data

VOLUME /var/lib/mysql