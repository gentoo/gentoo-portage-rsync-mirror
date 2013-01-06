# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychart/pychart-1.39.ebuild,v 1.9 2010/04/07 17:53:15 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P=PyChart-${PV}

DESCRIPTION="Python library for creating charts"
HOMEPAGE="http://home.gna.org/pychart/"
SRC_URI="http://download.gna.org/pychart/${MY_P}.tar.gz
	doc? ( http://download.gna.org/pychart/${PN}-doc.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc x86"
IUSE="doc examples"

DEPEND="app-text/ghostscript-gpl"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r "${WORKDIR}/${PN}/"* || die "dohtml failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demos/*
	fi
}
