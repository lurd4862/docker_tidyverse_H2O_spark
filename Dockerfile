# Starting the container from the the latest ubuntu docker
FROM ubuntu

# nitial update
RUN apt-get update

# install wget for downloading the Rstudio installers
RUN apt-get -y install wget

# for the functionality to work I will need to build things with the latest version of Rstudio v1.2
RUN wget https://s3.amazonaws.com/rstudio-ide-build/desktop/bionic/amd64/rstudio-1.2.1335-amd64.deb

# get gdebi for installing deb files
RUN apt-get -y install gdebi

# install rstudio
RUN gdebi --non-interactive rstudio-1.2.1335-amd64.deb

# create an user to run Rstudio with
RUN useradd -ms /bin/bash  rstudio

# Expose the Rstudio port 8787
EXPOSE 8787 8787
