# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtkdialog/gtkdialog-0.7.20.ebuild,v 1.4 2012/05/05 04:53:49 jdhore Exp $

EAPI=2
inherit eutils

DESCRIPTION="GUI-creation utility that can be used with an arbitrary interpreter"
HOMEPAGE="http://linux.pte.hu/~pipas/gtkdialog"
SRC_URI="ftp://linux.pte.hu/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	gnome-base/libglade"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-name_conflict.patch
}

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog TODO
}
