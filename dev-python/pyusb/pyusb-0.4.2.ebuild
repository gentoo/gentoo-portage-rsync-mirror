# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyusb/pyusb-0.4.2.ebuild,v 1.3 2010/01/07 16:34:10 fauli Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils flag-o-matic

DESCRIPTION="USB support for Python."
HOMEPAGE="http://pyusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

### The bus enumeration does not appear to work with libusb-compat
### A new version based on libusb-1.x is in the works, but not yet released
DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}"

RESTRICT_PYTHON_ABIS="3*"

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r samples
	fi
}
