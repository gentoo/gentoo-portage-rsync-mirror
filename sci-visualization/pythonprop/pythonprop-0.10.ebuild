# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/pythonprop/pythonprop-0.10.ebuild,v 1.2 2011/02/09 18:34:42 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Scripts to prepare and plot VOACAP propagation predictions"
HOMEPAGE="http://www.qsl.net/hz1jw/pythonprop"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sci-electronics/voacapl
	dev-python/matplotlib[gtk]
	dev-python/basemap"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS TODO || die
}

pkg_postinst() {
	python_need_rebuild
	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
