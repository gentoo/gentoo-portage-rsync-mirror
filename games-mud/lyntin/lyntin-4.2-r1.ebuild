# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/lyntin/lyntin-4.2-r1.ebuild,v 1.5 2013/09/05 19:44:52 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )
PYTHON_REQ_USE="tk?"

inherit distutils-r1 games

DESCRIPTION="tintin mud client clone implemented in Python"
HOMEPAGE="http://lyntin.sourceforge.net/"
SRC_URI="mirror://sourceforge/lyntin/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="tk"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

DOCS=( COMMANDS PKG-INFO HACKING README )

python_install() {
	distutils-r1_python_install --install-scripts="${GAMES_BINDIR}"
}

src_prepare() {
	distutils-r1_src_prepare
}

src_compile() {
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
	prepgamesdirs
}

pkg_postinst() {
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
