# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycurl/pycurl-7.19.0.ebuild,v 1.20 2014/10/23 16:00:50 idella4 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="python binding for curl/libcurl"
HOMEPAGE="http://pycurl.sourceforge.net/ http://pypi.python.org/pypi/pycurl"
SRC_URI="http://pycurl.sourceforge.net/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="examples"

DEPEND=">=net-misc/curl-7.19.0"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="curl"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-linking.patch"
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" tests/test_internals.py -q
	}
	python_execute_function testing
}

src_install() {
	sed -e "/data_files=/d" -i setup.py || die "sed in setup.py failed"

	distutils_src_install

	dohtml -r doc/* || die "dohtml failed"

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples tests || die "doins failed"
	fi
}
