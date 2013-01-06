# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sudsds/sudsds-1.0.1.ebuild,v 1.1 2012/12/20 13:46:21 scarabeus Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Lightweight SOAP client - Czech NIC labs fork"
HOMEPAGE="https://labs.nic.cz/page/969/"
SRC_URI="http://www.nic.cz/public_media/datove_schranky/releases/src/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-python/setuptools
	doc? ( dev-python/epydoc )"
RDEPEND=""

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		epydoc -n "Sudsds - ${DESCRIPTION}" -o doc ${PN} || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/* || die "Installation of documentation failed"
	fi
}
