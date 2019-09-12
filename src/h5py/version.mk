ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

ifndef ROLLPY
  ROLLPY = python
endif

HDF5VERSION=$(shell grep ^\s*VERSION.*= $(REDHAT.ROOT)/src/hdf5/version.mk |awk -F "=" '{print $$2}'|sed 's/ //g')

# Query python version via shell macro so that we can use it in the rpm name.
PYVERSION := $(shell module load $(ROLLPY) > /dev/null 2>&1; python3 --version 2>&1 | grep -o '[0-9][0-9]*\.[0-9][0-9]*')

NAME           = sdsc-h5py_py$(PYVERSION)
VERSION        = 2.8.0
RELEASE        = 1
PKGROOT        = /opt/hdf5/$(HDF5VERSION)/$(COMPILERNAME)/$(MPINAME)

SRC_SUBDIR     = h5py

SOURCE_NAME    = h5py
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
RPM.PREFIX     = $(PKGROOT)
