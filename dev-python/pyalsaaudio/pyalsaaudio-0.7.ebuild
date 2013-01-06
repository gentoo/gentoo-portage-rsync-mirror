# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyalsaaudio/pyalsaaudio-0.7.ebuild,v 1.1 2012/02/14 04:56:16 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

DESCRIPTION="A Python wrapper for the ALSA API"
HOMEPAGE="http://www.sourceforge.net/projects/pyalsaaudio http://pypi.python.org/pypi/pyalsaaudio"
SRC_URI="mirror://sourceforge/pyalsaaudio/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.6 )"
RESTRICT="test"

DOCS="CHANGES README"

src_compile() {
	distutils_src_compile

	if use doc; then
		cd doc
		emake html || die "emake html failed"
	fi
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" test.py -v
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/html/
	fi

	insinto /usr/share/doc/${PF}/examples
	doins *test.py
}
