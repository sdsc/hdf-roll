RCOMPILER = intel/2015.2.164
CNAME := $(firstword $(subst /, ,$(RCOMPILER)))

RMPI = openmpi_ib
MNAME := $(firstword $(subst /, ,$(RMPI)))

NAME           = sdsc-hdf5_intel-2015.2.164_$(MNAME)
VERSION        = 1.8.14
RELEASE        = 2
PKGROOT        = /opt/hdf5/intel-2015.2.164/$(MNAME)

SRC_SUBDIR     = hdf5

SOURCE_NAME    = hdf5
SOURCE_VERSION = $(VERSION)
SOURCE_SUFFIX  = tar.gz
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
