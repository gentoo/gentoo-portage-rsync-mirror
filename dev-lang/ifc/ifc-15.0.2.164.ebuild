# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ifc/ifc-15.0.2.164.ebuild,v 1.2 2015/02/12 10:43:08 jlec Exp $

EAPI=5

INTEL_DPN=parallel_studio_xe
INTEL_DID=5207
INTEL_DPV=2015_update2
INTEL_SUBDIR=composerxe
INTEL_SINGLE_ARCH=false

inherit intel-sdp

DESCRIPTION="Intel FORTRAN Compiler"
HOMEPAGE="http://software.intel.com/en-us/articles/intel-composer-xe/"

IUSE="linguas_ja"
KEYWORDS="-* ~amd64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="!dev-lang/ifc[linguas_jp]"
RDEPEND="${DEPEND}
	~dev-libs/intel-common-${PV}[compiler,multilib=]"

INTEL_BIN_RPMS="compilerprof compilerprof-devel"
INTEL_DAT_RPMS="compilerprof-common compilerprof-vars"

CHECKREQS_DISK_BUILD=375M

src_install() {
	if ! use linguas_ja; then
		find "${S}" -type d -name ja_JP -exec rm -rf '{}' + || die
	fi

	rm opt/intel/composerxe-2015_update2.2.164/documentation/en_US/third-party-programs.txt || die

	intel-sdp_src_install
}
