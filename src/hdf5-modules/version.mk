PACKAGE     = hdf5
CATEGORY    = applications

NAME        = sdsc-$(PACKAGE)-modules
RELEASE     = 11
PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

EXTRA_MODULE_VERSIONS = 1.8.21

RPM.EXTRAS  = AutoReq:No\nObsoletes:sdsc-hdf5-modules_gnu,sdsc-hdf5-modules_intel,sdsc-hdf5-modules_pgi
RPM.PREFIX  = $(PKGROOT)
