ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
FIRSTCOMPILER = $(firstword $(ROLLCOMPILER))
COMPILERNAME := $(firstword $(subst /, ,$(FIRSTCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
FIRSTMPI = $(firstword $(ROLLMPI))
MPINAME := $(firstword $(subst /, ,$(FIRSTMPI)))

ifndef ROLLPY
  ROLLPY = python
endif
FIRSTPY = $(firstword $(ROLLPY))

ifndef PYVERSION
  PYVERSION = 2.6
endif

NAME           = h5py_$(COMPILERNAME)_$(MPINAME)_py$(PYVERSION)
VERSION        = 2.3.1
RELEASE        = 1
PKGROOT        = /opt/hdf5/$(COMPILERNAME)/$(MPINAME)

SRC_SUBDIR     = h5py

SOURCE_NAME    = h5py
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
