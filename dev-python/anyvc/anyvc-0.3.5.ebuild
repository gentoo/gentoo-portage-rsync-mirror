# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/anyvc/anyvc-0.3.5.ebuild,v 1.1 2010/10/30 16:25:34 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

DESCRIPTION="Library to access any version control system"
HOMEPAGE="http://pypi.python.org/pypi/anyvc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bazaar doc git mercurial subversion"

RDEPEND="dev-python/apipkg
	dev-python/execnet
	dev-python/py
	bazaar? ( dev-vcs/bzr )
	git? ( dev-python/dulwich )
	mercurial? ( dev-vcs/mercurial )
	subversion? ( dev-python/subvertpy )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		sphinx-build -b html docs docs_output || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd docs_output > /dev/null
		docinto html
		cp -R [a-z]* _static "${ED}usr/share/doc/${PF}/html" || die "Installation of documentation failed"
		popd > /dev/null
	fi
}
