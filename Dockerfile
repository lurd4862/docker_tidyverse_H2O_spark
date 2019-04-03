## Starting the container from the the latest ubuntu docker
FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

## initial update
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
## install wget and dependencies for downloading the Rstudio installers
RUN apt-get install -y ca-certificates
RUN apt-get install -y libpsl5
RUN apt-get install -y python3
RUN apt-get install -y libclang-6.0-dev
RUN apt-get install -y psmisc
RUN apt-get install -y libapparmor1
RUN apt-get install -y libedit2
RUN apt-get install -y sudo
RUN apt-get install -y lsb-release
RUN apt-get install -y libclang-dev

RUN apt-get update -qq \
	&& apt-get install -y --no-install-recommends \
		bash-completion \
		bison \
		debhelper \
		default-jdk \
		g++ \
		gcc \
		gdb \
		gfortran \
		groff-base \
		libblas-dev \
		libbz2-dev \
		libcairo2-dev \
		libcurl4-openssl-dev \
		libjpeg-dev \
		liblapack-dev \
		liblzma-dev \
		libncurses5-dev \
		libpango1.0-dev \
		libpcre3-dev \
		libpng-dev \
		libreadline-dev \
		libtiff5-dev \
		libx11-dev \
		libxt-dev \
		mpack \
		subversion \
		tcl8.6-dev \
		texinfo \
		texlive-base \
		texlive-extra-utils \
		texlive-fonts-extra \
		texlive-fonts-recommended \
		texlive-generic-recommended \
		texlive-latex-base \
		texlive-latex-extra \
		texlive-latex-recommended \
		tk8.6-dev \
		x11proto-core-dev \
		xauth \
		xdg-utils \
		xfonts-base \
		xvfb \
		zlib1g-dev

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libsqlite-dev \
  libmariadbd-dev \
  libmariadb-client-lgpl-dev \
  libpq-dev \
  libssh2-1-dev 

RUN apt-get install -y wget

## for the functionality to work I will need to build things with the latest version of Rstudio v1.2
RUN wget https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-1.2.1335-amd64.deb

## get gdebi for installing deb files
###RUN apt-get -y install gdebi

## install rstudio
###RUN gdebi --non-interactive rstudio-server-1.2.1335-amd64.deb
RUN dpkg -i rstudio-server-1.2.1335-amd64.deb

RUN rm rstudio-server-1.2.1335-amd64.deb

## create an user to run Rstudio with
RUN useradd -ms /bin/bash  rstudio

## expose the Rstudio port 8787
EXPOSE 8787 8787

## run rstudio server
CMD ["rstudio-server", "start"]

ENTRYPOINT ["/bin/sh", "-c", "while true; do sleep 1; done"]
