# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysfml/pysfml-1.6.ebuild,v 1.3 2012/12/01 00:05:10 radhermit Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

DESCRIPTION="Python library for the Simple and Fast Multimedia Library (SFML)"
HOMEPAGE="http://sfml.sourceforge.net/"
SRC_URI="mirror://sourceforge/sfml/SFML-${PV}-python-sdk.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="media-libs/libsfml"
RDEPEND="${DEPEND}"

S="${WORKDIR}/SFML-${PV}/python"

PYTHON_CXXFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="PySFML"

src_install() {
	distutils_src_install
	use doc && dohtml doc/*

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins -r samples/* || die "doins failed"
	fi
}
