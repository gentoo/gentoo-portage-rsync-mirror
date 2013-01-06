# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/pysize/pysize-0.2.ebuild,v 1.6 2012/03/31 16:14:58 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="A graphical and console tool for exploring the size of directories"
HOMEPAGE="http://guichaz.free.fr/pysize/"
SRC_URI="http://guichaz.free.fr/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="gtk ncurses"

DEPEND="
	gtk? ( dev-python/pygtk:2 )
	ncurses? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}"

src_prepare() {
	if ! use gtk; then
		sed -e '/^from pysize.ui.gtk/d' \
		    -e "s~'gtk': ui_gtk.run,~~g" \
		    -e 's:ui_gtk.run,::g' \
		    -i pysize/main.py || die "Failed to remove gtk support"
		rm -rf pysize/ui/gtk || die "Failed to remove gtk support"
	fi

	if ! use ncurses; then
		sed -e '/^from pysize.ui.curses/d' \
		    -e "s~'curses': ui_curses.run,~~g" \
		    -e 's:ui_curses.run,::g' \
		    -i pysize/main.py || die "Failed to remove ncurses support"
		rm -rf pysize/ui/curses || die "Failed to remove ncurses support"
	fi

	epatch "${FILESDIR}/psyco-${PV}"-automagic.patch

	epatch "${FILESDIR}"/${PV}-setuptools-automagic.patch
	distutils_src_prepare
}
