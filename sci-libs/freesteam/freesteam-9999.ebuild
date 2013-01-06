# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/freesteam/freesteam-9999.ebuild,v 1.1 2012/12/15 12:44:23 mgorny Exp $

EAPI=4

inherit base multilib scons-utils toolchain-funcs

#if LIVE
ESVN_REPO_URI=https://freesteam.svn.sourceforge.net/svnroot/freesteam/trunk
inherit subversion
#endif

DESCRIPTION="Open source implementation of IF97 steam tables"
HOMEPAGE="http://freesteam.sourceforge.net/"
SRC_URI="mirror://sourceforge/freesteam/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sci-libs/gsl"
DEPEND="${RDEPEND}"

#if LIVE
KEYWORDS=
SRC_URI=
#endif

src_prepare() {
	local PATCHES=(
		"${FILESDIR}"/${PN}-flags.patch
	)

	base_src_prepare
}

src_configure() {
	myesconsargs=(
		INSTALL_PREFIX=/usr
		INSTALL_LIB=/usr/$(get_libdir)
		INSTALL_ROOT="${D}"

		CC="$(tc-getCC)"
		SWIG=false
	)

	mkdir -p "${D}" || die
}

src_compile() {
	escons
}

src_install() {
	escons install
}
