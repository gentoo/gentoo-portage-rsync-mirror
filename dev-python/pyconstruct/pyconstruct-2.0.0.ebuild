# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyconstruct/pyconstruct-2.0.0.ebuild,v 1.2 2010/06/08 19:04:28 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit python

DESCRIPTION="Library for constructing (parsing and building) of binary and textual data structures"
HOMEPAGE="http://construct.wikispaces.com/ http://pypi.python.org/pypi/construct"
SRC_URI="mirror://sourceforge/pyconstruct/construct-2.00-distro.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/construct"

src_install() {
	installation() {
		insinto $(python_get_sitedir)/construct
		doins -r *
	}
	python_execute_function installation
}

pkg_postinst() {
	python_mod_optimize construct
}

pkg_postrm() {
	python_mod_cleanup construct
}
