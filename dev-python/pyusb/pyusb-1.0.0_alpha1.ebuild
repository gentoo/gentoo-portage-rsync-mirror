# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyusb/pyusb-1.0.0_alpha1.ebuild,v 1.4 2014/08/10 21:20:21 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="*:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

MY_P="${P/_alpha/-a}"

DESCRIPTION="USB support for Python"
HOMEPAGE="http://pyusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

### This version is compatible with both 0.X and 1.X versions of libusb
DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="usb"

src_test() {
	cd tests

	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" testall.py
	}
	python_execute_function testing
}
