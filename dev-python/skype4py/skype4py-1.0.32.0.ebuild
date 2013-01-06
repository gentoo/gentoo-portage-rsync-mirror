# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/skype4py/skype4py-1.0.32.0.ebuild,v 1.3 2012/03/17 05:36:29 radhermit Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
# ctypes module required.
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit distutils

DESCRIPTION="Python wrapper for the Skype API"
HOMEPAGE="https://developer.skype.com/wiki/Skype4Py http://sourceforge.net/projects/skype4py/"
SRC_URI="mirror://sourceforge/${PN}/Skype4Py-${PV}.tar.gz
		 doc? ( mirror://sourceforge/${PN}/Skype4Py-${PV}-htmldoc.zip )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="net-im/skype"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Skype4Py-${PV}"

PYTHON_MODNAME="Skype4Py"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml "${WORKDIR}/Skype4Py-${PV}-htmldoc/"* || die "dohtml failed"
	fi
}
