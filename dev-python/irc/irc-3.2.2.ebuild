# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/irc/irc-3.2.2.ebuild,v 1.2 2012/10/13 20:55:34 floppym Exp $

EAPI="4"
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5"

inherit distutils eutils

DESCRIPTION="IRC client framework written in Python."
HOMEPAGE="https://bitbucket.org/jaraco/irc http://pypi.python.org/pypi/irc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="app-arch/unzip"
RDEPEND="!>=dev-python/python-irclib-3.2.2"

src_prepare() {
	# Prevent setup from downloading hgtools package
	epatch "${FILESDIR}/irc-setup.py.patch"

	# Don't rely on hgtools for version
	sed -e "s/use_hg_version=True/version=\"${PV}\"/" -i setup.py || die
	sed -e "/^tag_/d" -i setup.cfg || die

	distutils_src_prepare
}

src_install() {
	distutils_src_install

	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		insinto "/usr/share/doc/${PF}/examples"
		doins scripts/*
	fi
}
