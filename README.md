# SDSC "hdf" roll

## Overview

This roll bundles the HDF4 and HDF5 libraries and the h5py Python interface
to HDF5.

For more information about the various packages included in the hdf roll please visit their official web pages:

- <a href="http://www.hdfgroup.org/products/hdf4" target="_blank">HDF4</a> is a
library and multi-object file format for storing and managing data between
machines.
- <a href="http://www.hdfgroup.org/products/hdf5" target="_blank">HDF5</a> is a
data model, library, and file format for storing and managing data.
- The <a href="http://www.h5py.org" target="_blank">H5PY</a> package is a
Pythonic interface to the HDF5 binary data format.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate hdf source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

flex bison (from CentOS distribution)
numpy (h5py dependency)


## Building

To build the hdf-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `hdf-*.disk1.iso`.  If you built the
roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.

This roll source supports building with different compilers and for different
MPI flavors.  The `ROLLCOMPILER` and `ROLLMPI` make variables can be used to
specify the names of compiler and MPI modulefiles to use for building the
software, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mvapich2_ib 2>&1 | tee build.log
```

The build process recognizes "gnu", "intel" or "pgi" as the value for the
`ROLLCOMPILER` variable; any MPI modulefile name may be used as the value of
the `ROLLMPI` variable.  The default values are "gnu" and "rocks-openmpi".

The values of the `ROLLCOMPILER` and `ROLLMPI` variables are incorporated into
the names of the produced rpms.  For example,

```shell
make ROLLCOMPILER=intel ROLLMPI=mvapich2_ib 2>&1 | tee build.log
```

produces a roll containing an rpm with a name that begins
`hdf5_intel_mvapich2_ib`.

For gnu compilers, the roll also supports a `ROLLOPTS` make variable value of
'avx', indicating that the target architecture supports AVX instructions.

The roll also supports specifying building with/for python versions other than
the one included with the o/s.  To use this feature, specify a `ROLLPY` make
variable that includes a space-delimited list of python modulefiles, e.g.,

```shell
% make ROLLPY=opt-python 2>&1 | tee build.log
```

## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll hdf
% cd /export/rocks/install
% rocks create distro
% rocks run roll hdf | bash
```

In addition to the software itself, the roll installs hdf environment
module files in:

```shell
/opt/modulefiles/applications/.(compiler)/hdf[45]
```


## Testing

The hdf-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/hdf.t 
```
