PACKAGE     = hdf4
CATEGORY    = applications

NAME        = sdsc-$(PACKAGE)-modules
RELEASE     = 6
PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No\nObsoletes:sdsc-hdf4-modules_gnu,sdsc-hdf4-modules_intel,sdsc-hdf4-modules_pgi
RPM.PREFIX  = $(PKGROOT)
