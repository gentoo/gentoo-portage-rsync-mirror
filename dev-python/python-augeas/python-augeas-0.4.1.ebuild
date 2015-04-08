# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-augeas/python-augeas-0.4.1.ebuild,v 1.2 2014/12/28 19:28:15 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python bindings for Augeas"
HOMEPAGE="http://augeas.net/"
SRC_URI="https://fedorahosted.org/released/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-admin/augeas"
RDEPEND="${DEPEND}"

DOCS="AUTHORS README.txt PKG-INFO"

python_test() {
	cd test || die
	"${PYTHON}" test_augeas.py || die
}
