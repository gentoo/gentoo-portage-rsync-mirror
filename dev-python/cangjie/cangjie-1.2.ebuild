# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cangjie/cangjie-1.2.ebuild,v 1.1 2015/03/02 06:51:18 dlan Exp $

EAPI=5
PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit autotools-utils python-r1

DESCRIPTION="The Python bindings to libcangjie"
HOMEPAGE="http://cangjians.github.io"
SRC_URI="https://github.com/Cangjians/pycangjie/releases/download/v${PV}/cangjie-${PV}.tar.xz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${PYTHON_DEPS}
	app-i18n/libcangjie
	dev-python/cython[${PYTHON_USEDEP}]"

RDEPEND="app-i18n/libcangjie
	${PYTHON_DEPS}"

PATCHES=( "${FILESDIR}/${P}-cython-022.patch" )

src_configure() {
	python_foreach_impl autotools-utils_src_configure
}

src_compile() {
	python_foreach_impl autotools-utils_src_compile
}

src_install() {
	python_foreach_impl autotools-utils_src_install
}
