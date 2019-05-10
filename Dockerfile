FROM centos:7 as builder
RUN yum install -y gcc gcc-c++ make rsync libpng-devel libuuid-devel mariadb-devel
WORKDIR /userApps
RUN curl -L http://hgdownload.soe.ucsc.edu/admin/exe/userApps.v381.src.tgz | tar xz --strip-components=2 \
    && make -j


FROM centos:7
RUN yum install -y libpng mariadb-libs libuuid
COPY --from=builder /userApps/bin/* /usr/local/bin/
RUN chmod -R a+x /usr/local/bin/
