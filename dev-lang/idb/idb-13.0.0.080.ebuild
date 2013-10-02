# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/idb/idb-13.0.0.080.ebuild,v 1.1 2013/10/02 13:20:50 jlec Exp $

EAPI=5

INTEL_DPN=parallel_studio_xe
INTEL_DID=3447
INTEL_DPV=2013_sp1
INTEL_SUBDIR=composerxe
INTEL_SINGLE_ARCH=false

inherit intel-sdp

DESCRIPTION="Intel C/C++/FORTRAN debugger"
HOMEPAGE="http://software.intel.com/en-us/articles/intel-composer-xe/"

IUSE="eclipse"
KEYWORDS="-* ~amd64 ~x86 ~amd64-linux ~x86-linux"

DEPEND=">=dev-libs/intel-common-13.1[compiler]"
RDEPEND="${DEPEND}
	virtual/jre
	eclipse? ( dev-util/eclipse-sdk )"

INTEL_BIN_RPMS="idb"
INTEL_DAT_RPMS="idb-common idbcdt"

CHECKREQS_DISK_BUILD=475M

src_prepare() {
	sed \
		-e "/^INSTALLDIR/s:=.*:=${INTEL_SDP_EDIR}:g" \
		-i ${INTEL_SDP_DIR}/bin/intel*/idb || die
}
