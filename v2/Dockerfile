FROM mintproject/base-ubuntu18

# R packages for data transforms and helpers
COPY Rprofile /root/.Rprofile
RUN Rscript -e 'install.packages("rgeos"); install.packages("ncdf4"); install.packages("rgdal"); install.packages("raster"); install.packages("zoo"); install.packages("abind"); install.packages("xts")'

RUN wget -nv https://computation.llnl.gov/projects/sundials/download/sundials-2.2.0.tar.gz && \
    tar xvf sundials-2.2.0.tar.gz && \
    cd sundials && \
    ./configure --prefix=/opt/sundials && \
    make && \
    make install && \
    cd .. && \
    rm -rf sundials*

RUN wget -nv http://www.pihm.psu.edu/PIHM_v2.2.tar && \
    tar xvf PIHM_v2.2.tar && \
    cd PIHM_v2.2 && \
    (make clean || true) && \
    (grep -rl Makefile . | xargs sed -i 's;/Users/xxy113/software;/opt;g') && \
    make pihm && \
    mv pihm /usr/bin && \
    cd .. && \
    rm -rf PIHM*
