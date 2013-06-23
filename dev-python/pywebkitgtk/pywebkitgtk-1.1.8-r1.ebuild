# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywebkitgtk/pywebkitgtk-1.1.8-r1.ebuild,v 1.5 2013/06/23 16:18:39 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools-utils python-r1 virtualx

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

src_configure() {
	local myeconfargs=( --disable-static )
	python_parallel_foreach_impl autotools-utils_src_configure
}

src_compile() {
	python_foreach_impl autotools-utils_src_compile
}

src_test() {
	testing() {
		local test st=0
		for test in tests/test_*.py; do
			PYTHONPATH="${BUILD_DIR}/.libs" "${PYTHON}" "${test}"
			(( st |= $? ))
		done
		return ${st}
	}
	VIRTUALX_COMMAND=testing python_foreach_impl virtualmake
}

src_install() {
	local AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
	local DOCS=( AUTHORS MAINTAINERS NEWS README )
	python_foreach_impl autotools-utils_src_install
}
