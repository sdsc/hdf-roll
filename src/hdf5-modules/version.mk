ifndef ROLLCOMPILER
  COMPILERNAME = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef PYVERSION
  PYVERSION = 2.6
endif

NAME    = hdf5-modules_$(ROLLCOMPILER)
VERSION = 1.8.12
RELEASE = 1
RPM.EXTRAS         = AutoReq:No
