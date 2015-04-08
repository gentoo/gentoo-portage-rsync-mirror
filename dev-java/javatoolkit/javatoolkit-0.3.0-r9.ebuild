# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javatoolkit/javatoolkit-0.3.0-r9.ebuild,v 1.3 2013/09/05 18:27:44 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=(python2_{6,7})
PYTHON_REQ_USE="xml(+)"

inherit distutils-r1 eutils multilib

DESCRIPTION="Collection of Gentoo-specific tools for Java"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}/${P}-python2.6.patch"
		"${FILESDIR}/${P}-no-pyxml.patch"
	)

	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install \
		--install-scripts="${EPREFIX}"/usr/$(get_libdir)/${PN}/bin
}
