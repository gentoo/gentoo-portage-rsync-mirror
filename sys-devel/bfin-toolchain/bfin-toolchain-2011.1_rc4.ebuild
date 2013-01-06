# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bfin-toolchain/bfin-toolchain-2011.1_rc4.ebuild,v 1.1 2012/07/18 11:48:04 vapier Exp $

DESCRIPTION="toolchain for Blackfin processors"
HOMEPAGE="http://blackfin.uclinux.org/gf/project/toolchain"
FRS_ID="531"
BASE_URI="http://blackfin.uclinux.org/gf/download/frsrelease/${FRS_ID}"
MY_PN="blackfin-toolchain"
MY_PV=${PV/./R}
MY_PV=${MY_PV/_rc/-RC}
src_uri() {
	local arch=$1
	echo ${BASE_URI}/$2/${MY_PN}-${MY_PV}.${arch}.tar.bz2
	echo ${BASE_URI}/$3/${MY_PN}-elf-gcc-4.3-${MY_PV}.${arch}.tar.bz2
	echo ${BASE_URI}/$4/${MY_PN}-uclibc-default-${MY_PV}.${arch}.tar.bz2
}
SRC_URI="
	amd64? ( $(src_uri x86_64 9646 9648 9650) )
	x86?   ( $(src_uri i386   9509 9513 9515) )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# These archives are large, and the Blackfin site uses akamai for mirroring,
# so they should be just as good (probably better) as Gentoo's mirrors.
RESTRICT="strip mirror"
QA_PREBUILT="*"

DEPEND=""
RDEPEND="=sys-libs/readline-6*
	sys-libs/ncurses
	sys-libs/zlib"

S=${WORKDIR}

src_install() {
	mv "${S}"/opt "${D}"/ || die
}
