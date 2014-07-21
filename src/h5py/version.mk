ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = eth
endif

ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif

ifndef ROLLPY
  ROLLPY = python
endif

ifndef PYVERSION
  PYVERSION = 2.6
endif

NAME               = h5py_$(COMPILERNAME)_$(ROLLMPI)_$(ROLLNETWORK)_py$(PYVERSION)
VERSION            = 2.2.1
RELEASE            = 2
RPM.EXTRAS         = AutoReq:No

SRC_SUBDIR         = h5py

SOURCE_NAME        = h5py
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
