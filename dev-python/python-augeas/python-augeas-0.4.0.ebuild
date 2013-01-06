# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-augeas/python-augeas-0.4.0.ebuild,v 1.1 2011/05/11 16:00:41 matsuu Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Python bindings for Augeas"
HOMEPAGE="http://augeas.net/"
SRC_URI="http://augeas.net/download/python/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-admin/augeas"
RDEPEND="${DEPEND}"

DOCS="AUTHORS README.txt PKG-INFO"
PYTHON_MODNAME="augeas.py"

src_test() {
	cd test
	testing() {
		"$(PYTHON)" test_augeas.py
	}
	python_execute_function testing
}
