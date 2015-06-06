ROLLCOMPILER = intel/2015.2.164
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ROLLMPI = openmpi_ib
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME           = sdsc-hdf5_intel-2015.2.164
VERSION        = 1.8.14-intel-2015.2.164
RELEASE        = 0
PKGROOT        = /opt/hdf5/intel-2015.2.164/$(MPINAME)

SRC_SUBDIR     = hdf5

SOURCE_NAME    = hdf5
SOURCE_VERSION = $(VERSION)
SOURCE_SUFFIX  = tar.gz
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
