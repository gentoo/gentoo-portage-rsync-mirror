# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gcolor2/gcolor2-0.4-r3.ebuild,v 1.11 2012/05/05 04:53:53 jdhore Exp $

EAPI="1"

inherit eutils autotools

DESCRIPTION="a GTK+ color selector"
HOMEPAGE="http://gcolor2.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4:2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.27
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/modular-rgb.patch \
		"${FILESDIR}"/${P}-amd64.patch \
		"${FILESDIR}"/${P}-pkg-config-macro.patch

	# To check at each bump.
	sed "s/^#.*/[encoding: UTF-8]/" -i po/POTFILES.in || die "sed failed"
	echo "gcolor2.glade" >> po/POTFILES.in

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog
	make_desktop_entry ${PN} gcolor2 /usr/share/pixmaps/gcolor2/icon.png Graphics
}
