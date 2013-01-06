# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/acovea-gtk/acovea-gtk-1.0.1.ebuild,v 1.1 2009/04/23 22:06:05 patrick Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Analysis of Compiler Options via Evolutionary Algorithm GUI"
HOMEPAGE="http://www.coyotegulch.com/products/acovea/"
SRC_URI="http://www.coyotegulch.com/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="unicode"

RDEPEND=">=app-benchmarks/acovea-5
	dev-cpp/gtkmm:2.4"
DEPEND="${RDEPEND}"

src_prepare() {
	use unicode && epatch "${FILESDIR}"/${P}-unicode.patch
	epatch "${FILESDIR}"/${P}-{libsigc,gcc4.3}.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	make_desktop_entry "${PN}" Acovea-gtk \
		/usr/share/acovea-gtk/pixmaps/acovea_icon_064.png System
	dodoc ChangeLog NEWS README || die "no docs sorry!"
}
