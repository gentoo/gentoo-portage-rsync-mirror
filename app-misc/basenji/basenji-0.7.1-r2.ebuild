# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/basenji/basenji-0.7.1-r2.ebuild,v 1.4 2012/03/27 18:27:08 ssuominen Exp $

EAPI="3"

inherit multilib

DESCRIPTION="Basenji is a volume indexing tool designed for easy and fast indexing of volume collections."
HOMEPAGE="http://launchpad.net/basenji"
SRC_URI="http://launchpad.net/basenji/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

CDEPEND="dev-dotnet/gtk-sharp
	dev-dotnet/ndesk-dbus
	dev-dotnet/ndesk-dbus-glib
	dev-dotnet/gnome-sharp
	media-libs/libextractor"

DEPEND="${CDEPEND}"

RDEPEND="${CDEPEND}
	sys-fs/udisks:0"

src_prepare() {
	sed -i -e "s/-pkg:mono-cairo/-r:Mono.Cairo/" Basenji/Makefile || die "sed failed."
}

src_configure() {
	./configure --prefix="${EPREFIX}/usr"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	rm "${D}/usr/$(get_libdir)/pkgconfig/libextractor.pc"
}
