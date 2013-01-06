# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kinterbasdb/kinterbasdb-3.2.2.ebuild,v 1.3 2010/11/10 17:20:57 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="firebird/interbase interface for Python."
HOMEPAGE="http://kinterbasdb.sourceforge.net/"
SRC_URI="mirror://sourceforge/firebird/${P}.tar.gz"

IUSE="doc"
KEYWORDS="~amd64 -sparc x86"
LICENSE="kinterbasdb"
SLOT="0"

DEPEND=">=dev-db/firebird-1.0_rc1
	>=dev-python/egenix-mx-base-2.0.1"
RDEPEND="${DEPEND}"

DOCS="docs/changelog.txt"

src_prepare() {
	distutils_src_prepare

	# firebird headers are in /opt/firebird/include
	# don't byte-compile .py files
	sed -i \
		-e 's:^#\(database_include_dir=\).*:\1/usr/include:' \
		-e 's:\(compile=\)1:\10:' \
		-e 's:\(optimize=\)1:\10:' \
		setup.cfg || die "sed in setup.cfg failed"

	epatch "${FILESDIR}/${PN}-3.2-no_doc.patch"
}

src_install() {
	distutils_src_install

	use doc && dohtml docs/*
}
