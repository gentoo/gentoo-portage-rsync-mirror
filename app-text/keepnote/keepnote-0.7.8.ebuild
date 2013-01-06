# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/keepnote/keepnote-0.7.8.ebuild,v 1.2 2012/08/14 08:23:20 hasufell Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.*"

inherit eutils gnome2-utils python distutils

DESCRIPTION="A note taking application"
HOMEPAGE="http://keepnote.org/"
SRC_URI="http://keepnote.org/download-test/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-python/pygobject:2
	dev-python/pygtk:2
	x11-misc/xdg-utils"

DOCS="CHANGES"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}"/${P}-desktopfile.patch
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/testing.py
	}
	python_execute_function testing
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_icon_cache_update

	einfo
	elog "optional dependencies:"
	elog "  app-text/gtkspell:2 (spell checking)"
	einfo
}

pkg_postrm() {
	distutils_pkg_postrm
	gnome2_icon_cache_update
}
