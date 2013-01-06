# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/elfix/elfix-0.8.0.ebuild,v 1.1 2012/12/29 15:33:45 blueness Exp $

EAPI="4"

DESCRIPTION="Tools to work with ELF binaries and libraries on Hardened Gentoo."
HOMEPAGE="http://dev.gentoo.org/~blueness/elfix/
	http://www.gentoo.org/proj/en/hardened/pax-quickstart.xml"
SRC_URI="http://dev.gentoo.org/~blueness/elfix/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="+ptpax +xtpax"

# These only work on a properly configured pax kernel
RESTRICT="test"

DEPEND="
	dev-libs/elfutils
	=dev-python/pypax-${PV}[ptpax=,xtpax=]
	xtpax? ( sys-apps/attr )"

RDEPEND="${DEPEND}"

src_configure() {
	rm -f "${S}/scripts/setup.py"
	econf \
		--disable-tests \
		$(use_enable ptpax) \
		$(use_enable xtpax)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog INSTALL README THANKS TODO
}
