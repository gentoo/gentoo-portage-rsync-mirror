# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nevow/nevow-0.10.0.ebuild,v 1.15 2014/08/10 21:14:27 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython"
DISTUTILS_SRC_TEST="trial formless nevow"
DISTUTILS_DISABLE_TEST_DEPENDENCY="1"

inherit twisted

MY_PN="Nevow"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A web templating framework that provides LivePage, an automatic AJAX toolkit"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodNevow http://pypi.python.org/pypi/Nevow"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-linux"
IUSE="doc"

DEPEND=">=dev-python/twisted-core-2.5
	>=dev-python/twisted-web-8.1.0
	net-zope/zope-interface"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="formless nevow"
TWISTED_PLUGINS="nevow.plugins"

src_test() {
	TWISTED_DISABLE_WRITING_OF_PLUGIN_CACHE="1" distutils_src_test
}

src_install() {
	distutils_src_install

	doman doc/man/nevow-xmlgettext.1
	if use doc; then
		insinto /usr/share/doc/${PF}/
		doins -r doc/{howto,html,old} examples
	fi
	rm -fr "${ED}usr/doc"
}
