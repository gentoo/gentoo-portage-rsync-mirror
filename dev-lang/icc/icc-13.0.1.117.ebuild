# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icc/icc-13.0.1.117.ebuild,v 1.1 2012/12/10 19:35:25 jlec Exp $

EAPI=4

INTEL_DPN=parallel_studio_xe
INTEL_DID=2872
INTEL_DPV=2013_update1
INTEL_SUBDIR=composerxe

inherit intel-sdp

DESCRIPTION="Intel C/C++ Compiler"
HOMEPAGE="http://software.intel.com/en-us/articles/intel-composer-xe/"

IUSE="eclipse"

DEPEND="
	eclipse? ( dev-util/eclipse-sdk )"
RDEPEND="${DEPEND}
	~dev-libs/intel-common-${PV}[compiler]"

INTEL_BIN_RPMS="compilerproc compilerproc-devel"
INTEL_DAT_RPMS="compilerproc-common"

src_install() {
	intel-sdp_src_install
	local i
	local idir=${INTEL_SDP_EDIR}/compiler/lib
	for i in ${idir}/{ia32,intel64}/locale/ja_JP/{diagspt,flexnet,helpxi}.cat; do
		if [[ -e "${i}" ]]; then
			rm -rvf "${D}${i}" || die
		fi
	done
}
