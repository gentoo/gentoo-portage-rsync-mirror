# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/nitrogen/nitrogen-1.4-r1.ebuild,v 1.5 2012/05/05 04:53:45 jdhore Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="GTK+ background browser and setter for X."
HOMEPAGE="http://projects.l3ib.org/nitrogen/"
SRC_URI="http://projects.l3ib.org/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="xinerama"

RDEPEND="dev-cpp/gtkmm:2.4
	>=gnome-base/librsvg-2.20:2
	x11-libs/gtk+:2
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	xinerama? ( x11-proto/xineramaproto )"

src_prepare () {
	epatch "${FILESDIR}"/${P}-png.patch \
		"${FILESDIR}"/Makefile-as-needed.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable xinerama) || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
