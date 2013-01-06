# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pqiv/pqiv-0.12.ebuild,v 1.4 2012/06/20 08:36:26 jdhore Exp $

EAPI=4
inherit linux-info toolchain-funcs

DESCRIPTION="Modern rewrite of Quick Image Viewer"
HOMEPAGE="http://github.com/phillipberndt/pqiv http://www.pberndt.com/Programme/Linux/pqiv/"
SRC_URI="mirror://github/phillipberndt/${PN}/${P}.tbz
	http://www.pberndt.com/raw/Programme/Linux/${PN}/_download/${P}.tbz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="kernel_linux"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.12:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	if use kernel_linux; then
		CONFIG_CHECK="~INOTIFY_USER"
		linux-info_pkg_setup
	fi
}

src_configure() {
	./configure --prefix=/usr --destdir="${D}" || die
}

src_compile() {
	tc-export CC
	emake
}

src_install() {
	emake install
	dodoc README.markdown
}
