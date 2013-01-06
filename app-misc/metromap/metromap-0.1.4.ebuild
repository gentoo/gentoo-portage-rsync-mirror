# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/metromap/metromap-0.1.4.ebuild,v 1.1 2012/05/21 19:40:55 maksbotan Exp $

EAPI="4"

PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Metromap is simple pygtk+2 programm for finding paths in metro(subway) maps."
HOMEPAGE="http://metromap.antex.ru/"
SRC_URI="http://metromap.antex.ru/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.8:2"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_compile() { :; }

src_install() {
	emake DESTDIR="${D}"/usr install
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}/modules
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}/modules
}
