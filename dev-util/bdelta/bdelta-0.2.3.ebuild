# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bdelta/bdelta-0.2.3.ebuild,v 1.2 2011/12/09 07:24:27 slyfox Exp $

EAPI="4"

inherit multilib toolchain-funcs eutils

DESCRIPTION="Binary Delta - Efficient difference algorithm and format"
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI="http://deltup.org/request.php?10 -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-linux"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.2.3-makefile-restect-user-s-LDFLAGS-CXXFLAGS-and-other-v.patch
	epatch "${FILESDIR}"/${PN}-0.2.3-bdelta.h-make-header-C-compatible.patch
	epatch "${FILESDIR}"/${PN}-0.2.3-fix-stack-smash.patch #bug 338327
	epatch "${FILESDIR}"/${PN}-0.2.3-libbdelta-rename-NDEBUG-to-DO_STATS_DEBUG.patch
	epatch "${FILESDIR}"/${PN}-0.2.3-Makefile-add-make-clean-target.patch
	epatch "${FILESDIR}"/${PN}-0.2.3-Makefile-fix-paralell-building-bdelta-depends-on-it-.patch
	epatch "${FILESDIR}"/${PN}-0.2.3-Makefile-create-LIBDIR-as-well.patch
}

src_compile() {
	# TODO: add soname versioning
	emake -C src CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	emake -C src DESTDIR="${ED}" LIBDIR="/usr/$(get_libdir)" install || die "make install failed"
	dodoc README
}
