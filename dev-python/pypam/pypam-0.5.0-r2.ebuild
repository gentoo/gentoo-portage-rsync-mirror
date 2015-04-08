# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypam/pypam-0.5.0-r2.ebuild,v 1.7 2015/04/08 08:05:13 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 flag-o-matic

MY_PN="PyPAM"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python Bindings for PAM (Pluggable Authentication Modules)"
HOMEPAGE="http://www.pangalactic.org/PyPAM"
SRC_URI="http://www.pangalactic.org/PyPAM/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86"
IUSE=""

DEPEND=">=sys-libs/pam-0.64"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS=( AUTHORS examples/pamtest.py )

PATCHES=(
	# Fix a PyObject/PyMEM mixup.
	"${FILESDIR}/${P}-python-2.5.patch"
	# Fix a missing include.
	"${FILESDIR}/${P}-stricter.patch"
)

src_compile() {
	append-cflags -fno-strict-aliasing
	distutils-r1_src_compile
}

python_test() {
	"${PYTHON}" tests/PamTest.py
}
