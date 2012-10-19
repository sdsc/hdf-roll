#!/usr/bin/perl -w
# hdf roll installation test.  Usage:
# hdf.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $TESTFILE = "tmphdf";

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $output;

my @COMPILERS = split(/\s+/, 'ROLLCOMPILER');
my @NETWORKS = split(/\s+/, 'ROLLNETWORK');
my @MPIS = split(/\s+/, 'ROLLMPI');
my @PACKAGES = ('hdf4', 'hdf5');
my %CC = ('gnu' => 'gcc', 'intel' => 'icc', 'pgi' => 'pgcc');
my %LIBS = (
  'hdf4'=>'-lmfhdf -ldf -ljpeg -lz', 'hdf5'=>'-lhdf5'
);

open(OUT, ">${TESTFILE}hdf4.c");
# Adapted from sd_create.c downloaded from
# http://www.hdfgroup.org/training/HDFtraining/examples/sd_examples.html
print OUT <<END;
#include <stdio.h>
#include "mfhdf.h"

void check(int32 result) {
  if(result == FAIL) {
    printf("FAIL\\n");
    exit(1);
  }
}

#define DIMCOUNT 2
#define DIM0 10
#define DIM1 2

int main() {
  int32 dims[DIMCOUNT] = {DIM0, DIM1};
  int32 start[DIMCOUNT] = {0, 0};
  int32 sd_id, sds_id;
  int16 array_data[DIM0][DIM1];
  intn i, j;

  check(sd_id = SDstart("$TESTFILE.hdf", DFACC_CREATE));
  check(sds_id = SDcreate(sd_id, "data1", DFNT_INT16, DIMCOUNT, dims));
  for(j = 0; j < DIM0; j++) {
    for(i = 0; i < DIM1; i++)
      array_data[j][i] = (i + j) + 1;
   }
  check(SDwritedata(sds_id, start, NULL, dims, (VOIDP)array_data));
  check(SDendaccess(sds_id));
  check(SDend(sd_id));
  printf("SUCCEED\\n");
  return 0;
}
END

open(OUT, ">${TESTFILE}hdf5.c");
# Adapted from h5_write.c downloaded from
# http://www.hdfgroup.org/ftp/HDF5/examples/src-html/c.html
print OUT <<END;
#include <stdio.h>
#include <stdlib.h>
#include "hdf5.h"

void check(long result) {
  if(result < 0) {
    printf("FAIL\\n");
    exit(1);
  }
}

#define NX   5
#define NY   6
#define RANK 2

int main (void) {

  hid_t   file, dataset, datatype, dataspace;
  hsize_t dimsf[RANK] = {NX, NY};
  int     data[NX][NY];
  int     i, j;

  for(j = 0; j < NX; j++)
    for(i = 0; i < NY; i++)
      data[j][i] = i + j;

  check(file = H5Fcreate("$TESTFILE.h5", H5F_ACC_TRUNC, H5P_DEFAULT, H5P_DEFAULT));
  check(dataspace = H5Screate_simple(RANK, dimsf, NULL));
  check(datatype = H5Tcopy(H5T_NATIVE_INT));
  check(H5Tset_order(datatype, H5T_ORDER_LE));
  check(dataset = H5Dcreate2(file, "IntArray", datatype, dataspace,
    H5P_DEFAULT, H5P_DEFAULT, H5P_DEFAULT));
  check(H5Dwrite(dataset, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT, data));

  H5Sclose(dataspace);
  H5Tclose(datatype);
  H5Dclose(dataset);
  H5Fclose(file);

  printf("SUCCEED\\n");
  return 0;
}
END

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
if test -f /etc/profile.d/modules.sh; then
  . /etc/profile.d/modules.sh
  module load \$1 \${2}_\$3
fi
export LD_LIBRARY_PATH=\$4/lib:\$LD_LIBRARY_PATH
\$5 -I \$4/include -I \${MPIHOME}/include -o $TESTFILE.exe \$6 -L \$4/lib \$7
./$TESTFILE.exe
END

# hdf-doc.xml
SKIP: {
  skip 'not server', 1 if $appliance ne 'Frontend';
  ok(-d '/var/www/html/roll-documentation/hdf', 'doc installed');
}

# hdf-common.xml
foreach my $package(@PACKAGES) {
  foreach my $compiler(@COMPILERS) {

    SKIP: {

      skip "$package/$compiler not installed", 5
        if ! -d "/opt/$package/$compiler";
 
      MPITEST:
      foreach my $mpi(@MPIS) {
        foreach my $network(@NETWORKS) {

          my $subdir =
            $package eq 'hdf4' ? "$compiler" : "$compiler/$mpi/$network";

          $output = `bash $TESTFILE.sh $compiler $mpi $network /opt/$package/$subdir $CC{$compiler} $TESTFILE$package.c "$LIBS{$package}" 2>&1`;
          ok(-f "$TESTFILE.exe", "compile/link with $package/$subdir");
          like($output, qr/SUCCEED/, "run with $package/$subdir");
          `/bin/rm $TESTFILE.exe`;

        }
      }

      skip 'modules not installed', 1 if ! -f '/etc/profile.d/modules.sh';
      `/bin/ls /opt/modulefiles/applications/.$compiler/$package/[0-9]* 2>&1`;
      ok($? == 0, "$package/$compiler module installed");
      `/bin/ls /opt/modulefiles/applications/.$compiler/$package/.version.[0-9]* 2>&1`;
      ok($? == 0, "$package/$compiler version module installed");
      ok(-l "/opt/modulefiles/applications/.$compiler/$package/.version",
         "$package/$compiler version module link created");

    }

  }
}

`/bin/rm -fr $TESTFILE*`;
