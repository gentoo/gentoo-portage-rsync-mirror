# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/irc/irc-8.3.1.ebuild,v 1.2 2013/09/05 18:46:18 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="IRC client framework written in Python."
HOMEPAGE="https://bitbucket.org/jaraco/irc http://pypi.python.org/pypi/irc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="app-arch/unzip
	app-text/dos2unix"

RDEPEND="!>=dev-python/python-irclib-3.2.2[${PYTHON_USEDEP}]"

python_prepare_all() {
	# Prevent setup from downloading hgtools package
	dos2unix setup.py || die "Oopsie"
	epatch "${FILESDIR}/irc-setup.py.8.0.1.patch"

	# Don't rely on hgtools for version
	sed -e "s/use_hg_version=True/version=\"${PV}\"/" -i setup.py || die
	sed -e "/^tag_/d" -i setup.cfg || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	use examples && local EXAMPLES=( scripts/. )
	distutils-r1_python_install_all
}
