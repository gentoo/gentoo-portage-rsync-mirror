# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/emilpro/emilpro-3-r1.ebuild,v 1.2 2014/03/26 14:22:00 zerochaos Exp $

EAPI=5

inherit cmake-utils eutils

DESCRIPTION="a graphical disassembler for a large number of instruction sets"
HOMEPAGE="http://www.emilpro.com/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/SimonKagstrom/emilpro"
	inherit git-r3
	KEYWORDS=""
	SRC_URI="mirror://gnu/binutils/binutils-2.23.2.tar.bz2"
else
	SRC_URI="http://www.emilpro.com/${P}.tar.gz
		!system-binutils? ( mirror://gnu/binutils/binutils-2.23.2.tar.bz2 )"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+system-binutils"

DEPEND="|| ( dev-libs/elfutils dev-libs/libelf )
	dev-cpp/gtkmm:3.0
	dev-cpp/gtksourceviewmm:3.0
	dev-cpp/libxmlpp:2.6
	system-binutils? ( sys-devel/binutils[multitarget] )
	net-misc/curl"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/respect-cflags.patch
	if use system-binutils; then
		epatch "${FILESDIR}"/use-gentoo-binutils.patch
	else
		sed -i "s#wget -O binutils.tar.bz2 http://ftp.gnu.org/gnu/binutils/binutils-2.23.2.tar.bz2#cp \"${DISTDIR}/binutils-2.23.2.tar.bz2\" ./binutils.tar.bz2#" cmake/BuildBinutils.cmake
	fi
	cmake-utils_src_prepare
}

src_compile() {
	if use system-binutils; then
		cmake-utils_src_compile
	else
		#bundled binutils is broken, always builds with one thread
		#but somehow it still fails if I don't do this
		cd "${BUILD_DIR}"
		emake -j1
	fi
}

src_install() {
	dobin "${BUILD_DIR}"/emilpro
}
