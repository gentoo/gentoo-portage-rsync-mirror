# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydns/pydns-3.0.1.ebuild,v 1.3 2012/04/05 06:16:52 jdhore Exp $

EAPI="4"
PYTHON_DEPEND="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.*"

inherit distutils

DESCRIPTION="Python module for DNS (Domain Name Service)"
HOMEPAGE="http://pydns.sourceforge.net/ http://pypi.python.org/pypi/pydns"
SRC_URI="http://downloads.sourceforge.net/project/pydns/py3dns/${P/py/py3}.tar.gz"

LICENSE="CNRI"
SLOT="3"
KEYWORDS="amd64 x86"
IUSE="examples"

DEPEND="!dev-python/py3dns
	virtual/libiconv"
RDEPEND=""

DOCS="CHANGES CREDITS"
PYTHON_MODNAME="DNS"

S="${WORKDIR}/${P/py/py3}"

src_prepare() {
	# Don't compile bytecode.
	sed -i -e 's:^\(compile\|optimize\).*:\1 = 0:g' setup.cfg

	# cleanup docs
	rm -f -- "README-guido.txt"
	mv -f -- "README.txt" "README"
	mv -f -- "CREDITS.txt" "CREDITS"
}

src_install(){
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		docompress -x /usr/share/doc/${PF}/examples
		doins tests/*.py tools/*.py
	fi
}
