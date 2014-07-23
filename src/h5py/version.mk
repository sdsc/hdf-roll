ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
FIRSTCOMPILER = $(firstword $(ROLLCOMPILER))
COMPILERNAME := $(firstword $(subst /, ,$(FIRSTCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = eth
endif
FIRSTMPI = $(firstword $(ROLLMPI))

ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif
FIRSTNETWORK = $(firstword $(ROLLNETWORK))

ifndef ROLLPY
  ROLLPY = python
endif
FIRSTPY = $(firstword $(ROLLPY))

ifndef PYVERSION
  PYVERSION = 2.6
endif

NAME               = h5py_$(COMPILERNAME)_$(FIRSTMPI)_$(FIRSTNETWORK)_py$(PYVERSION)
VERSION            = 2.2.1
RELEASE            = 3
RPM.EXTRAS         = AutoReq:No

SRC_SUBDIR         = h5py

SOURCE_NAME        = h5py
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
