# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/mpi/mpi-2.0-r2.ebuild,v 1.1 2013/07/09 22:42:19 jsbronder Exp $

EAPI=2

DESCRIPTION="Virtual for Message Passing Interface (MPI) v2.0 implementation"
HOMEPAGE=""
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="cxx fortran romio"

RDEPEND="|| (
	sys-cluster/openmpi[cxx?,fortran?,romio?]
	sys-cluster/mpich[cxx?,fortran?,romio?]
	sys-cluster/mpich2[cxx?,fortran?,romio?]
	sys-cluster/mvapich2[fortran?,romio?]
	sys-cluster/native-mpi
)"

DEPEND=""
