# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javatoolkit/javatoolkit-0.3.0-r6.ebuild,v 1.9 2013/02/05 05:28:26 zerochaos Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils eutils multilib

DESCRIPTION="Collection of Gentoo-specific tools for Java"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ia64 ppc ppc64 ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_VERSIONED_SCRIPTS=("/usr/lib(32|64)?/${PN}/bin/.*")
PYTHON_MODNAME="javatoolkit"

src_prepare(){
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-python2.6.patch"
	epatch "${FILESDIR}/${P}-no-pyxml.patch"
}

src_install() {
	distutils_src_install --install-scripts="/usr/$(get_libdir)/${PN}/bin"
}
