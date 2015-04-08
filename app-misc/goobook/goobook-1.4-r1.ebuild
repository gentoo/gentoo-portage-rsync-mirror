# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/goobook/goobook-1.4-r1.ebuild,v 1.6 2015/04/08 07:30:35 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 readme.gentoo

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
	>=dev-python/simplejson-2.1.0[${PYTHON_USEDEP}]"

DEPEND="${PYTHON_DEPS}
	dev-python/setuptools"

# bug 449916, http://code.google.com/p/goobook/issues/detail?id=39
PATCHES=( "${FILESDIR}"/${P}-hcs-utils-1.3.patch )

src_install() {
	distutils-r1_src_install
	readme.gentoo_create_doc
}

FORCE_PRINT_ELOG=1 # remove in the next bump
DISABLE_AUTOFORMATTING=1
DOC_CONTENTS="
If you want to use goobook from mutt, add this in your .muttrc file:
	set query_command=\"goobook query '%s'\"
to query address book.

You may find more information and advanced configuration tips at
http://pypi.python.org/pypi/${PN}/${PV} in \"Configure/Mutt\" section"
