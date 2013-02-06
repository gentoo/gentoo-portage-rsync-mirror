# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vifm/vifm-0.7.4b.ebuild,v 1.1 2013/02/06 11:54:36 wired Exp $

EAPI=5
inherit base vim-plugin

DESCRIPTION="Console file manager with vi(m)-like keybindings"
HOMEPAGE="http://vifm.sourceforge.net/"
SRC_URI="mirror://sourceforge/vifm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~x86"
IUSE="X +extended-keys gtk +magic vim"

DEPEND="
	>=sys-libs/ncurses-5.7-r7
	magic? ( sys-apps/file )
	gtk? ( x11-libs/gtk+:2 )
	X? ( x11-libs/libX11 )
"
RDEPEND="
	${DEPEND}
"

DOCS=( AUTHORS TODO README )

src_configure() {
	econf \
		$(use_enable extended-keys) \
		$(use_with magic libmagic) \
		$(use_with gtk) \
		$(use_with X X11)
}

src_install() {
	base_src_install

	if use vim; then
		local s="${S}"
		S="${S}"/data/vim/
		vim-plugin_src_install
		S="${s}"
	fi
}

pkg_postinst() {
	use vim && vim-plugin_pkg_postinst
}

pkg_postrm() {
	use vim && vim-plugin_pkg_postrm
}
