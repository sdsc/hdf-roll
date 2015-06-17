RCOMPILER = intel/2015.2.164
CNAME := $(firstword $(subst /, ,$(RCOMPILER)))
RMPI = openmpi_ib

ifndef PYVERSION
  PYVERSION = 2.6
endif

PACKAGE     = hdf5
CATEGORY    = applications

NAME        = sdsc-$(PACKAGE)-modules_$(CNAME)-2015.2.164
RELEASE     = 1
PKGROOT     = /opt/modulefiles/$(CATEGORY)/.$(CNAME)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)-intel-2015.2.164/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
