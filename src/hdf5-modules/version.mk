ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef PYVERSION
  PYVERSION = 2.6
endif

NAME        = hdf5-modules_$(COMPILERNAME)
RELEASE     = 3
PKGROOT     = /opt/modulefiles/applications/.$(COMPILERNAME)/hdf5

VERSION_SRC = $(REDHAT.ROOT)/src/hdf5/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
