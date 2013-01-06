# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hgsvn/hgsvn-0.1.9.ebuild,v 1.1 2011/12/04 13:47:40 cedk Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A set of scripts to work locally on Subversion checkouts using Mercurial"
HOMEPAGE="http://pypi.python.org/pypi/hgsvn"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
	dev-vcs/subversion"

src_prepare() {
	distutils_src_prepare

	sed -e "/use_setuptools/d" -i setup.py || die "sed failed"
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/hgsvn/unittests"
	}
	python_execute_function -q delete_tests
}
