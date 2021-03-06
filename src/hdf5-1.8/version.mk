ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME           = sdsc-hdf5-1.8_$(COMPILERNAME)_$(MPINAME)
VERSION        = 1.8.21
RELEASE        = 0
PKGROOT        = /opt/hdf5/$(VERSION)/$(COMPILERNAME)/$(MPINAME)

SRC_SUBDIR     = hdf5

SOURCE_NAME    = hdf5
SOURCE_VERSION = $(VERSION)
SOURCE_SUFFIX  = tar.gz
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
RPM.PREFIX     = $(PKGROOT)
