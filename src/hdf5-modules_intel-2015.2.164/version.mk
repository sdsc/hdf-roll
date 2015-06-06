ROLLCOMPILER = intel/2015.2.164
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef PYVERSION
  PYVERSION = 2.6
endif

PACKAGE     = hdf5
CATEGORY    = applications

NAME        = sdsc-$(PACKAGE)-modules_$(COMPILERNAME)-2015.2.164
RELEASE     = 0
PKGROOT     = /opt/modulefiles/$(CATEGORY)/.$(COMPILERNAME)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)-intel-2015.2.164/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
