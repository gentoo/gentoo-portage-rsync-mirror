# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/irc/irc-8.0.ebuild,v 1.1 2013/03/09 09:46:26 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1 eutils

DESCRIPTION="IRC client framework written in Python."
HOMEPAGE="https://bitbucket.org/jaraco/irc http://pypi.python.org/pypi/irc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

DEPEND="app-arch/unzip
	app-text/dos2unix
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

RDEPEND="!>=dev-python/python-irclib-3.2.2"

src_prepare() {
	# Prevent setup from downloading hgtools package
	# Don't rely on hgtools for version, patch MUST be applied first
	epatch "${FILESDIR}/${PN}-8-setup.py.patch"
	dos2unix setup.py || die "Oops :("
	sed -e "s/use_hg_version=True/version=\"${PV}\"/" \
		-i setup.py || die
	sed -e "/^tag_/d" -i setup.cfg || die
	distutils-r1_src_prepare
}

python_test() {
	py.test || die
}

src_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		insinto "/usr/share/doc/${PF}/examples"
		doins scripts/*
	fi
}
