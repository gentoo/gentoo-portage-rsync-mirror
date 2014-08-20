# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lockfile/lockfile-0.8-r1.ebuild,v 1.2 2014/08/20 14:05:28 armin76 Exp $

EAPI="5"
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="Platform-independent file locking module"
HOMEPAGE="http://code.google.com/p/pylockfile/ http://pypi.python.org/pypi/lockfile http://smontanaro.dyndns.org/python/"
SRC_URI="http://pylockfile.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
RDEPEND=""

DOCS=( ACKS README RELEASE-NOTES )

python_compile() {
	distutils-r1_python_compile

	if use doc; then
		einfo "Generation of documentation"
		cd doc
		emake html || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils-r1_python_install_all

	if use doc; then
		cd doc/.build/html
		docinto html
		cp -R [a-z]* _static "${ED}usr/share/doc/${PF}/html" || die "Installation of documentation failed"
	fi
}
