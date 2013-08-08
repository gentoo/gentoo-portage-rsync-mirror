# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gudev/python-gudev-147.2-r1.ebuild,v 1.1 2013/08/08 09:29:14 mgorny Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=modules
PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools-utils python-r1 vcs-snapshot

DESCRIPTION="Python binding to the GUDev udev helper library"
HOMEPAGE="http://github.com/nzjrs/python-gudev"
SRC_URI="https://github.com/nzjrs/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pygobject:2[${PYTHON_USEDEP}]
	virtual/udev[gudev]
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

src_configure() {
	python_foreach_impl autotools-utils_src_configure
}

src_compile() {
	python_foreach_impl autotools-utils_src_compile
}

src_test() {
	python_foreach_impl autotools-utils_src_test
}

src_install() {
	python_foreach_impl autotools-utils_src_install
}
