# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/elfix/elfix-0.6.0.ebuild,v 1.5 2012/12/06 04:07:27 phajdan.jr Exp $

EAPI="4"

DESCRIPTION="Tools to work with ELF binaries and libraries on Hardened Gentoo."
HOMEPAGE="http://dev.gentoo.org/~blueness/elfix/"
SRC_URI="http://dev.gentoo.org/~blueness/elfix/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~sparc x86"
IUSE="test +ptpax xtpax"

DEPEND="
	dev-libs/elfutils
	=dev-python/pypax-${PV}[xtpax=]
	xtpax? ( sys-apps/attr )"

RDEPEND="${DEPEND}"

src_configure() {
	rm -f "${S}/scripts/setup.py"
	econf \
		$(use_enable test tests) \
		$(use_enable ptpax ptpax) \
		$(use_enable xtpax xtpax)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog INSTALL README THANKS TODO
}
