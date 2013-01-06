# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vifm/vifm-0.5-r1.ebuild,v 1.1 2011/03/29 20:41:03 wired Exp $

EAPI=3
inherit base

DESCRIPTION="Console file manager with vi(m)-like keybindings"
HOMEPAGE="http://vifm.sourceforge.net/"
SRC_URI="mirror://sourceforge/vifm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.8"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS TODO README )

PATCHES=( "${FILESDIR}"/"${P}"-ncurses-5.8.patch )

src_prepare() {
	sed -i -e "s:(datadir)/@PACKAGE@:(datadir)/${P}:" Makefile.in

	cd "${S}"/src
	sed -i -e "s:(datadir)/@PACKAGE@:(datadir)/${P}:" Makefile.in
	sed -i -e "s:/usr/local/share/vifm:/usr/share/${P}:g" config.c

	base_src_prepare
}

pkg_postinst() {
	elog "To use vim to view the vifm help, copy /usr/share/${P}/vifm.txt"
	elog "to ~/.vim/doc/ and run ':helptags ~/.vim/doc' in vim"
	elog "Then edit ~/.vifm/vifmrc${PV/a/} and set USE_VIM_HELP=1"
	elog ""
	elog "To use the vifm plugin in vim, copy /usr/share/${P}/vifm.vim to"
	elog "/usr/share/vim/vimXX/"
}
