# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyusb/pyusb-1.0.0_alpha3.ebuild,v 1.1 2013/01/05 05:58:05 idella4 Exp $

EAPI="3"
PYTHON_DEPEND="*:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

MY_P="${P/_alpha/a}"

DESCRIPTION="USB support for Python."
HOMEPAGE="http://pyusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

### This version is compatible with both 0.X and 1.X versions of libusb
DEPEND="virtual/libusb:1
	dev-python/setuptools"
RDEPEND="${DEPEND}"
DOCS="README.rst docs/tutorial.rst"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="usb"
