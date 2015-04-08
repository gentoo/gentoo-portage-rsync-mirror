# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/elfix/elfix-0.8.4.ebuild,v 1.10 2014/08/10 20:23:53 slyfox Exp $

EAPI="5"

DESCRIPTION="A suite of tools to work with ELF objects on Hardened Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/pax-quickstart.xml
	http://dev.gentoo.org/~blueness/elfix/"
SRC_URI="http://dev.gentoo.org/~blueness/elfix/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="+ptpax +xtpax"

REQUIRED_USE="|| ( ptpax xtpax )"

# These only work with a properly configured PaX kernel
RESTRICT="test"

DEPEND="~dev-python/pypax-${PV}[ptpax=,xtpax=]
	ptpax? ( dev-libs/elfutils )
	xtpax? ( sys-apps/attr )"

RDEPEND="${DEPEND}"

src_configure() {
	rm -f "${S}/scripts/setup.py"
	econf --disable-tests \
		$(use_enable ptpax) \
		$(use_enable xtpax)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog INSTALL README THANKS TODO
}
