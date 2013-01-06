# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.99.6.ebuild,v 1.15 2012/05/05 08:58:59 jdhore Exp $

EAPI=3
inherit fdo-mime gnome2-utils eutils

DESCRIPTION="Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 x86 ~x86-fbsd"
IUSE="aalib curl debug libcaca lirc nls readline vdr X xinerama"

RDEPEND=">=media-libs/libpng-1.4
	>=media-libs/xine-lib-1.1.17[aalib?,libcaca?]
	aalib? ( media-libs/aalib )
	curl? ( >=net-misc/curl-7.10.2 )
	libcaca? ( media-libs/libcaca )
	lirc? ( app-misc/lirc )
	nls? ( virtual/libintl )
	readline? ( sys-libs/readline )
	X? ( x11-libs/libX11
		x11-libs/libXrender
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXext
		x11-libs/libXxf86vm
		x11-libs/libXv
		x11-libs/libXtst
		x11-libs/libXft
		xinerama? ( x11-libs/libXinerama ) )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	X? ( x11-libs/libXt
		x11-proto/xf86vidmodeproto
		x11-proto/inputproto
		xinerama? ( x11-proto/xineramaproto ) )
	virtual/pkgconfig
	app-arch/xz-utils"

src_prepare() {
	rm -f misc/xine-bugreport
	epatch "${FILESDIR}/${P}-libpng15.patch" \
		"${FILESDIR}/${P}-curl-headers.patch"
}

src_configure() {
	if use lirc; then
		export LIRC_CFLAGS="-I/usr/include/lirc" LIRC_LIBS="-llirc_client"
	fi

	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable xinerama) \
		$(use_enable lirc) \
		$(use_enable vdr vdr-keys) \
		--disable-nvtvsimple \
		$(use_enable debug) \
		$(use_with X x) \
		$(use_with readline) \
		$(use_with curl) \
		$(use_with aalib) \
		$(use_with libcaca caca)
}

src_install() {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}" \
		docsdir="/usr/share/doc/${PF}" install || die
	dodoc AUTHORS ChangeLog NEWS README

	dodir /usr/share/applications
	mv -vf "${D}"/usr/share/xine/desktop/xine.desktop "${D}"/usr/share/applications
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
