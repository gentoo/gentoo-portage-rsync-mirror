# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/keepnote/keepnote-0.7.9-r1.ebuild,v 1.1 2012/09/26 12:14:16 hasufell Exp $

EAPI=4

PYTHON_COMPAT="python2_6 python2_7"
PYTHON_USE="sqlite,xml"

inherit eutils gnome2-utils python-distutils-ng

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

DOCS=( CHANGES )

python_prepare_all() {
	epatch "${FILESDIR}"/${PN}-0.7.8-desktopfile.patch
}

python_test() {
	"${PYTHON}" test/testing.py || die
}

python_install_all() {
	dodoc ${DOCS[@]}
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update

	einfo
	elog "optional dependencies:"
	elog "  app-text/gtkspell:2 (spell checking)"
	einfo
}

pkg_postrm() {
	gnome2_icon_cache_update
}
