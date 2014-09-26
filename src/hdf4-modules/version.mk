ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME        = hdf4-modules_$(COMPILERNAME)
RELEASE     = 2
PKGROOT     = /opt/modulefiles/applications/.$(COMPILERNAME)/hdf4

VERSION_SRC = $(REDHAT.ROOT)/src/hdf4/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
