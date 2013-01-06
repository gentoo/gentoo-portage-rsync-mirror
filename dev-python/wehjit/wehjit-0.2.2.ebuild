# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wehjit/wehjit-0.2.2.ebuild,v 1.3 2012/11/07 16:25:18 idella4 Exp $

EAPI=3

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
#DISTUTILS_SRC_TEST="nosetests" # for now can't be used in src_test
PYTHON_TESTS_RESTRICTED_ABIS="2.5"
inherit distutils eutils

DESCRIPTION="A Python web-widget library"
HOMEPAGE="http://jderose.fedorapeople.org/wehjit"
SRC_URI="http://jderose.fedorapeople.org/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-python/genshi
		dev-python/assets
		dev-python/paste
		dev-python/pygments
		"
DEPEND="${RDEPEND}"

DOCS="README TODO NEWS AUTHORS"

python_enable_pyc

src_prepare() {

	epatch "${FILESDIR}"/${P}-SkipTest.patch
}

src_test() {
	testing() {
		if [[ "${PYTHON_ABI:2:1}" == '6' ]]; then
			nosetests -I test_app* -e=*getitem
		else
			nosetests
		fi
	}
	python_execute_function testing
}
