# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javatoolkit/javatoolkit-0.3.0-r4.ebuild,v 1.7 2012/02/05 01:25:05 floppym Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils multilib

DESCRIPTION="Collection of Gentoo-specific tools for Java"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-python/pyxml"
RESTRICT_PYTHON_ABIS="2.4 3.*"

PYTHON_MODNAME="javatoolkit"

src_prepare(){
	epatch "${FILESDIR}/${P}-python2.6.patch"
}

src_install() {
	distutils_src_install --install-scripts="/usr/$(get_libdir)/${PN}/bin"
}
