# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pyrenamer/pyrenamer-0.6.0.ebuild,v 1.2 2010/08/05 21:06:19 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python gnome2

DESCRIPTION="Mass rename files"
HOMEPAGE="http://www.infinicode.org/code/pyrenamer/"
SRC_URI="http://www.infinicode.org/code/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="music"

RDEPEND="dev-python/pygtk:2
	dev-python/gconf-python
	music? ( || ( dev-python/eyeD3 app-misc/hachoir-metadata ) )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
