# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pybluez/pybluez-0.18.ebuild,v 1.5 2010/07/18 12:37:21 nixnut Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="PyBluez-${PV}"

DESCRIPTION="Python bindings for Bluez Bluetooth Stack"
HOMEPAGE="http://code.google.com/p/pybluez/"
SRC_URI="http://pybluez.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="examples"

DEPEND="net-wireless/bluez"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="bluetooth"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "doins failed"
	fi
}
