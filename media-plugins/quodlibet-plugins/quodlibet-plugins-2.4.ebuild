# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-plugins/quodlibet-plugins-2.4.ebuild,v 1.6 2012/12/08 12:33:38 ago Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"

inherit python

DESCRIPTION="Plugins for Quod Libet and Ex Falso"
HOMEPAGE="http://code.google.com/p/quodlibet/"
SRC_URI="http://quodlibet.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=media-sound/quodlibet-${PV}"
DEPEND=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	rm -f README || die
}

src_install() {
	insinto "$(python_get_sitedir)"/quodlibet/plugins
	doins -r *
}

pkg_postinst() {
	python_mod_optimize quodlibet/plugins
}

pkg_postrm() {
	python_mod_cleanup quodlibet/plugins
}
