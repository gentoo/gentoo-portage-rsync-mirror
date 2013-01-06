# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydns/pydns-2.3.6.ebuild,v 1.1 2012/06/24 12:22:55 sbriesen Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python module for DNS (Domain Name Service)"
HOMEPAGE="http://pydns.sourceforge.net/ http://pypi.python.org/pypi/pydns"
SRC_URI="http://downloads.sourceforge.net/project/pydns/pydns/${P}/${P}.tar.gz"

LICENSE="CNRI"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="!dev-python/pydns:0
	virtual/libiconv"
RDEPEND=""

DOCS="CREDITS"
PYTHON_MODNAME="DNS"

src_prepare() {
	# Fix encodings (should be utf-8 but is latin1).
	for i in "${PYTHON_MODNAME}"/{Lib,Type}.py; do
		iconv -f ISO-8859-1 -t UTF-8 < "${i}" > "${i}~" && mv -f "${i}~" "${i}" || rm -f "${i}~"
	done

	# Don't compile bytecode.
	sed -i -e 's:^\(compile\|optimize\).*:\1 = 0:g' setup.cfg

	# Fix Python shebangs in examples.
	python_convert_shebangs -r 2 .

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
