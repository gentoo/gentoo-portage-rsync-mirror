# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javatoolkit/javatoolkit-0.3.0-r9.ebuild,v 1.1 2013/04/16 09:42:35 sera Exp $

EAPI="5"

PYTHON_COMPAT=(jython2_5 python2_{5,6,7})
PYTHON_REQ_USE="xml(+)"

inherit eutils multilib distutils-r1

DESCRIPTION="Collection of Gentoo-specific tools for Java"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

python_prepare_all() {
	epatch "${FILESDIR}/${P}-python2.6.patch"
	epatch "${FILESDIR}/${P}-no-pyxml.patch"
}

python_configure_all() {
	mydistutilsargs=( --install-scripts="${EPREFIX}"/usr/$(get_libdir)/${PN}/bin )
}
