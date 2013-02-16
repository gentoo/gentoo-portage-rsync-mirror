# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pyrenamer/pyrenamer-0.6.0-r1.ebuild,v 1.1 2013/02/16 00:24:16 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

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
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
	gnome2_src_prepare
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
