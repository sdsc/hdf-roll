RCOMPILER=intel/2015.2.164
CNAME := $(firstword $(subst /, ,$(RCOMPILER)))

RMPI=openmpi_ib
MNAME := $(firstword $(subst /, ,$(ROLLMPI)))

#ROLLP = python/1-intel-2015.2.164
ROLLPY=python

ifndef PYVERSION
  PYVERSION = 2.7
endif

NAME           = sdsc-h5py_intel-2015.2.164_py$(PYVERSION)
VERSION        = 2.4.0
RELEASE        = 1
PKGROOT        = /opt/hdf5/$(CNAME)-2015.2.164/$(MNAME)

SRC_SUBDIR     = h5py

SOURCE_NAME    = h5py
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
