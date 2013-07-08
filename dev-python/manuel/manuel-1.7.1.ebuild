# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/manuel/manuel-1.7.1.ebuild,v 1.4 2013/07/08 15:58:31 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} python{3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1 eutils

DESCRIPTION="Manuel lets you build tested documentation."
HOMEPAGE="https://github.com/benji-york/manuel/ http://pypi.python.org/pypi/manuel"
# A snapshot was required since upstream missed out half the source
SRC_URI="http://dev.gentoo.org/~idella4/tarballs/${P}-20130316.tar.bz2"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
# Required to run tests
DISTUTILS_IN_SOURCE_BUILD=1

DOCS=( CHANGES.txt )

PATCHES=( "${FILESDIR}"/${PN}-1.7-rm_zope_test.patch )

python_test() {
	PYTHONPATH=src/ esetup.py test
}
