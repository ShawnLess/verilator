FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential
RUN apt-get install -y software-properties-common
RUN apt-get install -y tmux curl git man unzip vim wget

# verilator dependencies
RUN apt-get install -y flex bison

ENV HOME /home
WORKDIR /home

# verilator simulator
ENV verilator_ver 3.904
ENV verilator_top ${HOME}/verilator
ENV verilator_ins ${verilator_top}/install
ENV verilator_dir ${verilator_top}/verilator-${verilator_ver}
ENV verilator_web http://www.veripool.org/ftp/verilator-${verilator_ver}.tgz
ENV verilator_tar ${verilator_top}/verilator-${verilator_ver}.tar.gz

RUN mkdir -p ${verilator_top}
RUN mkdir -p ${verilator_ins}

RUN wget ${verilator_web} -O ${verilator_tar}
RUN tar xf ${verilator_tar} -C ${verilator_top}
RUN cd ${verilator_dir} && ./configure --prefix=${verilator_ins}
RUN make -C ${verilator_dir} verilator_bin
RUN make -C ${verilator_dir} installbin installdata

# setting PATH
ENV PATH ${verilator_ins}/bin:${PATH}

RUN cd ${HOME}

CMD ["bash"]
