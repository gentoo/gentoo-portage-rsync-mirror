# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywebkitgtk/pywebkitgtk-1.1.8-r1.ebuild,v 1.3 2013/06/23 15:26:55 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools-utils python-r1

DESCRIPTION="Python bindings for the WebKit GTK+ port"
HOMEPAGE="http://code.google.com/p/pywebkitgtk/"
SRC_URI="http://pywebkitgtk.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	dev-libs/libxslt[${PYTHON_USEDEP}]
	>=net-libs/webkit-gtk-1.1.15:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

RESTRICT="test"

src_configure() {
	local myeconfargs=( --disable-static )
	python_parallel_foreach_impl autotools-utils_src_configure
}

src_compile() {
	python_foreach_impl autotools-utils_src_compile
}

# Need fix a dbus session issue run as root
src_test() {
	testing() {
		local test
		pushd webkit > /dev/null
		ln -sf ../webkit.la . || die
		ln -sf ../.libs/webkit.so . || die
		popd > /dev/null
		for test in tests/test_*.py
		do
			if ! PYTHONPATH=. "${PYTHON}" ${test}; then
				die "Test ${test} failed under ${EPYTHON}"
			fi
		done
		einfo "Testsuite passed under ${EPYTHON}"
		# rm symlinks
		rm -f webkit/{webkit.la,webkit.so}
	}
	python_foreach_impl run_in_build_dir testing
}

src_install() {
	local AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
	local DOCS=( AUTHORS MAINTAINERS NEWS README )
	python_foreach_impl autotools-utils_src_install
}
