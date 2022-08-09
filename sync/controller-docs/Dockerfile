FROM quay.io/centos/centos:stream8

RUN dnf install -y epel-release

RUN dnf install -y \
    latexmk \
    make \
    python3-pip \
    rsync \
    texlive \
    texlive-titlesec \
    texlive-fncychap \
    texlive-tabulary \
    texlive-framed \
    texlive-threeparttable \
    texlive-wrapfig \
    texlive-upquote \
    texlive-capt-of \
    texlive-multirow \
    texlive-eqparbox \
    texlive-needspace

ADD build-docs.sh /
RUN chmod +x /build-docs.sh

RUN alternatives --set python /usr/bin/python3

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["bash"]
