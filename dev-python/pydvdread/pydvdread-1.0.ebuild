# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydvdread/pydvdread-1.0.ebuild,v 1.1 2012/12/31 08:30:05 vapier Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="A set of Python bindings for the libdvdread library"
HOMEPAGE="http://pydvdread.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""
RESTRICT="test" # Requires an actual DVD to test.

DEPEND="media-libs/libdvdread"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-py3k.patch
	epatch "${FILESDIR}"/${P}-api-update.patch
	sed -i '/assert_(isinstance(.*, int))/s:int))$:(int, long))):' tests/*.py || die
	distutils_src_prepare
}

src_compile() {
	# We had to patch some of the .i files, so regen the .py
	# so that the distutils copy doesn't import old stuff.
	# XXX: A python/swig expert might know a better way to do this.
	set -- swig -python -o src/dvdread/all_wrap.c src/dvdread/all.i
	echo "$@"
	"$@"  || die
	distutils_src_compile
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" tests/TestAll.py -q
	}
	python_execute_function testing
}
