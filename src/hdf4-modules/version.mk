ifndef ROLLCOMPILER
  COMPILERNAME = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME    = hdf4-modules_$(COMPILERNAME)
VERSION = 2.9
RELEASE = 1
RPM.EXTRAS         = AutoReq:No
