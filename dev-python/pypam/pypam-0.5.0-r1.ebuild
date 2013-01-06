# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypam/pypam-0.5.0-r1.ebuild,v 1.2 2012/12/17 20:00:09 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1

MY_PN="PyPAM"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python Bindings for PAM (Pluggable Authentication Modules)"
HOMEPAGE="http://www.pangalactic.org/PyPAM"
SRC_URI="http://www.pangalactic.org/PyPAM/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-libs/pam-0.64"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS=( AUTHORS examples/pamtest.py )

PATCHES=(
	# Fix a PyObject/PyMEM mixup.
	"${FILESDIR}/${P}-python-2.5.patch"
	# Fix a missing include.
	"${FILESDIR}/${P}-stricter.patch"
)

python_test() {
	"${PYTHON}" tests/PamTest.py
}
