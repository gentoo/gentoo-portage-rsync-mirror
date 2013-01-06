# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/lyntin/lyntin-4.2.ebuild,v 1.9 2011/04/06 20:10:23 arfrever Exp $

EAPI=3

PYTHON_DEPEND="2"
PYTHON_USE_WITH_OPT="tk"
PYTHON_USE_WITH="tk"

inherit eutils python games distutils

DESCRIPTION="tintin mud client clone implemented in Python"
HOMEPAGE="http://lyntin.sourceforge.net/"
SRC_URI="mirror://sourceforge/lyntin/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="tk"

DEPEND="dev-python/setuptools"
RDEPEND=""

DOCS="COMMANDS PKG-INFO HACKING README"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	games_pkg_setup
}

src_install() {
	distutils_src_install
	dogamesbin "${D}/usr/bin/runlyntin" || die "dogamesbin failed"
	rm -rf "${D}/usr/bin/"
	prepgamesdirs
}

pkg_postinst() {
	distutils_pkg_postinst
	games_pkg_postinst
	if use tk ; then
		elog "To start lyntin in GUI mode, create a config file"
		elog "with this in it:"
		elog
		elog "[Lyntin]"
		elog "ui:    tk"
		elog
		elog "Then start lyntin like this:"
		elog
		elog "runlyntin -c /path/to/config_file\n"
	fi
}
