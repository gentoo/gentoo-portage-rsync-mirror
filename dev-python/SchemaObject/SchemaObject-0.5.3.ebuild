# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/SchemaObject/SchemaObject-0.5.3.ebuild,v 1.3 2014/01/27 20:33:44 blueness Exp $

EAPI=4

PYTHON_DEPEND="2:2.5:2.7"

inherit distutils

DESCRIPTION="A simple Python object interface to a MySQL database schema"
HOMEPAGE="http://matuson.com/code/schemaobject/"
SRC_URI="http://www.matuson.com/code/schemaobject/downloads/${P}.tar.gz"

pn="${PN,,}"
S="${WORKDIR}/${pn}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

pkg_postinst() {
	python_mod_optimize "${pn}"
}

pkg_postrm() {
	python_mod_cleanup "${pn}"
}
