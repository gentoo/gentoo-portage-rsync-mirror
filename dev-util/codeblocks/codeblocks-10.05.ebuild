# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/codeblocks/codeblocks-10.05.ebuild,v 1.3 2012/04/30 20:27:26 scarabeus Exp $

EAPI="4"
WX_GTK_VER="2.8"

inherit wxwidgets flag-o-matic

DESCRIPTION="The open source, cross platform, free C++ IDE."
HOMEPAGE="http://www.codeblocks.org/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
SRC_URI="mirror://berlios/codeblocks/${P}-src.tar.bz2"

IUSE="contrib debug pch static-libs"

RDEPEND="x11-libs/wxGTK:2.8[X]"
DEPEND="${RDEPEND}
	app-arch/zip"

S=${WORKDIR}/${P}-release

src_configure() {
	# C::B is picky on CXXFLAG -fomit-frame-pointer
	# (project-wizard crash, instability ...)
	filter-flags -fomit-frame-pointer
	append-flags -fno-strict-aliasing

	econf \
		--with-wx-config="${WX_CONFIG}" \
		$(use_enable debug) \
		$(use_enable pch) \
		$(use_enable static-libs static) \
		$(use_with contrib contrib-plugins all)
}
