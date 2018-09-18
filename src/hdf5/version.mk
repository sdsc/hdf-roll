ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME           = sdsc-hdf5_$(COMPILERNAME)_$(MPINAME)
VERSION        = 1.10.3
RELEASE        = 0
PKGROOT        = /opt/hdf5/$(COMPILERNAME)/$(MPINAME)

SRC_SUBDIR     = hdf5

SOURCE_NAME    = hdf5
SOURCE_VERSION = $(VERSION)
SOURCE_SUFFIX  = tar.bz2
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_BZ2        = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
RPM.PREFIX     = $(PKGROOT)
