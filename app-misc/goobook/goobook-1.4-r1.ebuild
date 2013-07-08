# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/goobook/goobook-1.4-r1.ebuild,v 1.2 2013/07/08 17:26:20 xmw Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 eutils

DESCRIPTION="Google Contacts wrapper for mutt"
HOMEPAGE="http://code.google.com/p/goobook/"
SRC_URI="mirror://pypi/g/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/gdata-2.0.7[${PYTHON_USEDEP}]
	>=dev-python/hcs-utils-1.3[${PYTHON_USEDEP}]
	>=dev-python/keyring-0.2[${PYTHON_USEDEP}]
	>=dev-python/simplejson-2.1.0[${PYTHON_USEDEP}]
	virtual/python-argparse"

# bug 476186, http://code.google.com/p/goobook/issues/detail?id=40
DEPEND="${PYTHON_DEPS}
	<dev-python/setuptools-0.7"
ESTRICT_PYTHON_ABIS="3.*"

python_prepare_all() {
	epatch "${FILESDIR}"/${P}-hcs-utils-1.3.patch
}

pkg_postinst() {
	einfo "If you want to use goobook from mutt"
	einfo "add this in your .muttrc file:"
	einfo "set query_command=\"goobook query '%s'\""
	einfo "to query address book."
	einfo
	einfo "You may find more information and advanced configuration tips at"
	einfo "http://pypi.python.org/pypi/${PN}/${PV} in \"Configure/Mutt\" section"
}
