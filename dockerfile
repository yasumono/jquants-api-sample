FROM nvcr.io/nvidia/tensorflow:23.09-tf2-py3

WORKDIR /root/src
ADD requirements.txt /root/src/

WORKDIR /root
RUN apt-get update && apt-get install -y \
	wget \
	make \
	build-essential \
	fonts-ipafont

WORKDIR /root
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
	tar -zxvf ta-lib-0.4.0-src.tar.gz && \
	rm -f ta-lib-0.4.0-src.tar.gz

WORKDIR /root/ta-lib
RUN ./configure --prefix=/usr && \
	make && \
	make install 
RUN pip install TA-Lib

RUN apt install -y fonts-ipaexfont

WORKDIR /root/src
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt


