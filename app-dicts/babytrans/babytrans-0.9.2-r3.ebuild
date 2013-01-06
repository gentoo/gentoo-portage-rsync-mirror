# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/babytrans/babytrans-0.9.2-r3.ebuild,v 1.11 2009/10/17 22:38:44 halcy0n Exp $

inherit eutils

DESCRIPTION="BabyTrans is a Linux clone of the popular Babylon Translator for Windows."
SRC_URI="http://fjolliton.free.fr/babytrans/test/${P}.tar.gz"
HOMEPAGE="http://fjolliton.free.fr/babytrans/index.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*"
RDEPEND="${DEPEND}
	app-dicts/babytrans-en"

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	epatch "${FILESDIR}"/${P}-gcc.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch

	# Using make install instead of einstall causes a problem with sandbox.
	# This simple patch is supposed to solve this.
	cd "${S}"/po
	epatch "${FILESDIR}"/${P}-nls.patch
}

src_install() {
	# Requested by bug 72019
	make install DESTDIR="${D}" || die

	insinto /usr/share/babytrans
	doins "${FILESDIR}"/dictionary
	dodoc AUTHORS README
}

pkg_postinst() {
	elog
	elog "Now you should install one of the babytrans dictionaries"
	elog "available in portage. You can find then in $PORTDIR under"
	elog "the app-dicts category"
	elog
}
