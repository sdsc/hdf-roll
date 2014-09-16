ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif

ifndef ROLLMPI
  ROLLMPI = openmpi
endif

ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif

ifndef ROLLPY
  ROLLPY = python
endif

NAME       = hdf-roll-test
VERSION    = 1
RELEASE    = 3

RPM.EXTRAS = AutoReq:No
