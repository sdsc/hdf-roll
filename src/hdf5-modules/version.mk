ifndef ROLLCOMPILER
  COMPILERNAME = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME    = hdf5-modules_$(ROLLCOMPILER)
VERSION = 1.8.12
RELEASE = 0
RPM.EXTRAS         = AutoReq:No
