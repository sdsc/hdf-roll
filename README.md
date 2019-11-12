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

For the more recent version of hdf5 , both parallel and serial libraries are built.

Tne directory structure of the installation is:

/opt/hdf5/[version]/[compiler]/[mpi stack or serial]/


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate hdf source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

yum install flex bison libjpeg-turbo-devel

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.

The roll sources assume that modulefiles provided by SDSC compiler and python
rolls are available, but it will build without them as long as the environment
variables they provide are otherwise defined.  It also depends on python
modules (e.g., cython) from the python roll.


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
MPI flavors and python installations.  The `ROLLCOMPILER`, `ROLLMPI`, and
`ROLLPY` make variables can be used to specify the names of compiler, MPI, and
python modulefiles to use for building the software, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mvapich2_ib ROLLPY=opt-python 2>&1 | tee build.log
```

The build process recognizes "gnu", "intel" or "pgi" as the value for the
`ROLLCOMPILER` variable; any MPI modulefile name may be used as the value of
the `ROLLMPI` variable, and any python modulefile name for the ROLLPY variable.
The default values are "gnu", "rocks-openmpi", and "python".

For gnu compilers, the roll also supports a `ROLLOPTS` make variable value of
'avx', indicating that the target architecture supports AVX instructions.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll hdf
% cd /export/rocks/install
% rocks create distro
```

Subsequent installs of compute and login nodes will then include the contents
of the hdf-roll.  To avoid cluttering the cluster frontend with unused
software, the hdf-roll is configured to install only on compute and
login nodes. To force installation on your frontend, run this command after
adding the hdf-roll to your distro

```shell
% rocks run roll hdf host=NAME | bash
```

where NAME is the DNS name of a compute or login node in your cluster.

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
