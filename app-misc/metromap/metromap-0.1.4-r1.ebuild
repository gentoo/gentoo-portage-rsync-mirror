# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/metromap/metromap-0.1.4-r1.ebuild,v 1.1 2013/04/16 16:12:46 maksbotan Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-single-r1

DESCRIPTION="Metromap is simple pygtk+2 programm for finding paths in metro(subway) maps."
HOMEPAGE="http://metromap.antex.ru/"
SRC_URI="http://metromap.antex.ru/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.8:2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	python_fix_shebang .
	sed -e 's,Gtk;,GTK;,' -i metromap.desktop || die
}

src_compile() { :; }

src_install() {
	emake DESTDIR="${ED}"/usr install
	python_optimize "${ED}"/usr/share/metromap/modules/
}
