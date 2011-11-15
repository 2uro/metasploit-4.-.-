#
# Configuration file for using the xslt library
#
XSLT_LIBDIR="-L/bitnami/rapid7stack-linux/output/common/lib"
XSLT_LIBS="-lxslt  -L/bitnami/rapid7stack-linux/output/common/lib -lxml2 -lz -lpthread -liconv -lm -lm"
XSLT_INCLUDEDIR="-I/bitnami/rapid7stack-linux/output/common/include"
MODULE_VERSION="xslt-1.1.22"
