FROM mintproject/base-ubuntu18

# ------
# TauDEM
# ------

# ENV TAUDEM_VERSION 5.3.7

# RUN git clone --branch v${TAUDEM_VERSION} https://github.com/dtarb/TauDEM && \
#     cd TauDEM/src && \
#     mkdir build && \
#     cd build && \
#     cmake .. && \
#     make && make install && \
#     cd ../../.. && \
#     rm -rf TauDEM

# --------
# PIHMgisR
# --------

RUN Rscript -e 'install.packages("devtools"); library("devtools"); install_github("shulele/PIHMgisR");'

# ------
# PIHM++
# ------

ENV SUNDIALS_VERSION 3.2.1

RUN wget -nv https://computation.llnl.gov/projects/sundials/download/sundials-${SUNDIALS_VERSION}.tar.gz && \
    tar xvf sundials-${SUNDIALS_VERSION}.tar.gz && \
    cd sundials-${SUNDIALS_VERSION} && \
    mkdir build-dir && \
    cd build-dir && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/sundials -DOPENMP_ENABLE=1 -DMPI_ENABLE=1 .. && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf sundials*

ENV LD_LIBRARY_PATH /usr/local/sundials/lib

ENV PIHM_VERSION 4.0

RUN wget "https://github.com/shulele/PIHM-${PIHM_VERSION}/archive/master.zip" && \
    unzip master.zip && \
    cd PIHM-${PIHM_VERSION}-master && \
    make pihm && \
    mv pihm++ /usr/bin && \
    cd .. && \
    rm -rf master.zip PIHM*

# --------
# AutoPIHM
# --------

# RUN wget "https://github.com/shulele/AutoPIHM/archive/master.zip" && \
#     unzip master.zip && \
#     mv AutoPIHM-master AutoPIHM && \
#     rm -rf master.zip
