# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyenchant/pyenchant-1.6.5.ebuild,v 1.6 2011/02/13 17:24:39 armin76 Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Python bindings for the Enchant spellchecking system"
HOMEPAGE="http://pyenchant.sourceforge.net http://pypi.python.org/pypi/pyenchant"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=app-text/enchant-${PV%.*}
	dev-python/setuptools"
RDEPEND="${DEPEND}"

DOCS="README.txt TODO.txt"
PYTHON_MODNAME="enchant"

src_test() {
	if [[ -n "$(LC_ALL="en_US.UTF-8" bash -c "" 2>&1)" ]]; then
		ewarn "Disabling tests due to missing en_US.UTF-8 locale"
	else
		distutils_src_test
	fi
}
