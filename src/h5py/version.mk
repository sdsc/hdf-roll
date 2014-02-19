NAME               = h5py_$(ROLLCOMPILER)_$(ROLLMPI)_$(ROLLNETWORK)
VERSION            = 2.2.1
RELEASE            = 0
PKGROOT            = /opt/hdf5/$(ROLLCOMPILER)/$(ROLLMPI)/$(ROLLNETWORK)
RPM.EXTRAS         = AutoReq:No

SRC_SUBDIR         = h5py

SOURCE_NAME        = h5py
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
