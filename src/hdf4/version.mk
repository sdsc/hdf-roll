ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME               = hdf4_$(COMPILERNAME)
VERSION            = 2.9
RELEASE            = 1
PKGROOT            = /opt/hdf4/$(COMPILERNAME)
RPM.EXTRAS         = AutoReq:No

SRC_SUBDIR         = hdf4

SOURCE_NAME        = hdf-4
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME).$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

ZLIB_NAME          = zlib
ZLIB_VERSION       = 1.2.7
ZLIB_SUFFIX        = tar.gz
ZLIB_PKG           = $(ZLIB_NAME)-$(ZLIB_VERSION).$(SOURCE_SUFFIX)
ZLIB_DIR           = $(ZLIB_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG) $(ZLIB_PKG)
RPM.EXTRAS         = AutoReq:No
