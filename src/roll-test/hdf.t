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
my @MPIS = split(/\s+/, 'ROLLMPI');
my @PYTHONS = split(/\s+/, 'ROLLPY');
my $python = $PYTHONS[0]; # Only expect one python
my @PACKAGES = ('hdf4', 'hdf5');
my %CC = ('gnu' => 'gcc', 'intel' => 'icc', 'pgi' => 'pgcc');
my %LIBS = (
  'hdf4'=>'-lmfhdf -ldf -ljpeg -lz', 'hdf5'=>'-lhdf5'
);
my %HVERS = ('hdf4' => '2.14','hdf5' => '1.8.21 1.10.3');

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
close(OUT);

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
close(OUT);


open(OUT, ">${TESTFILE}.py");
print OUT <<END;
import h5py
fileName="${TESTFILE}.h5"
file=h5py.File(fileName,"r")

ar=file['IntArray']
for i in range(len(ar)):
	print i,ar[i]
END
close(OUT);

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
module load \$1 \$2
export LD_LIBRARY_PATH=\$3/lib:\$LD_LIBRARY_PATH
\$4 -I \$3/include -I \${MPIHOME}/include -o $TESTFILE.exe \$5 -L \$3/lib \$6
./$TESTFILE.exe
END
close(OUT);

# hdf-common.xml
foreach my $package(@PACKAGES) {

  my @hdfversions = split(/\s+/,$HVERS{$package});

  foreach my $hdfversion(@hdfversions) {

     foreach my $compiler(@COMPILERS) {

         my $compilername = (split('/', $compiler))[0];

     SKIP: {

      my $ext =
          $package eq 'hdf4' ? "" : "/$hdfversion";

      skip "$package$ext/$compilername not installed", 5
        if ! -d "/opt/$package$ext/$compilername";

      if ( $package eq "hdf5" )
      {
       foreach my $mpi(@MPIS) {

          $subdir="$hdfversion/$compiler/$mpi";
          $output = `bash $TESTFILE.sh $compiler $mpi /opt/$package/$subdir $CC{$compilername} $TESTFILE$package.c "$LIBS{$package}" 2>&1`;
          ok(-f "$TESTFILE.exe", "compile/link with $package/$subdir");
          like($output, qr/SUCCEED/, "run with $package/$subdir");
          if( $compiler eq $COMPILERS[0] && $mpi eq $MPIS[0] ) {
             $output=`module load $compiler $mpi $package  $python;python $TESTFILE.py`;
             like($output, qr/4 \[4 5 6 7 8 9\]/, "h5py read in file with $package version $hdfversion");
          }
          `/bin/rm $TESTFILE.exe`;
         }
         $output = `module load $compiler $package/$hdfversion; echo \$HDF5HOME 2>&1`;
         my $firstmpi = $MPIS[0];
         $firstmpi =~ s#/.*##;
         like($output, qr#/opt/hdf5/$hdfversion/$compiler/$firstmpi#, "hdf5 version $hdfversion modulefile defaults to first mpi");
       }
       else
       {
         $subdir=$compiler;
         $output = `bash $TESTFILE.sh $compiler $MPIS[0]  /opt/$package/$subdir $CC{$compilername} $TESTFILE$package.c "$LIBS{$package}" 2>&1`;
        ok(-f "$TESTFILE.exe", "compile/link with $package/$subdir");
        like($output, qr/SUCCEED/, "run with $package/$subdir");
        `/bin/rm $TESTFILE.exe`;
      }

     }
    }
  }

  `/bin/ls /opt/modulefiles/applications/$package/[0-9]* 2>&1`;
  ok($? == 0, "$package module installed");
  `/bin/ls /opt/modulefiles/applications/$package/.version.[0-9]* 2>&1`;
  ok($? == 0, "$package version module installed");
  ok(-l "/opt/modulefiles/applications/$package/.version",
     "$package version module link created");

}

`/bin/rm -fr $TESTFILE*`;
