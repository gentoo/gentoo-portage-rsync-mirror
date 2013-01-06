# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtkam/gtkam-0.2.0.ebuild,v 1.1 2012/09/15 11:48:29 pacho Exp $

EAPI="4"
GCONF_DEBUG="yes"

inherit eutils gnome2

DESCRIPTION="A frontend for gPhoto 2"
HOMEPAGE="http://gphoto.org/proj/gtkam"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="gimp gnome nls"

# FIXME: why is exif not optional ?
RDEPEND="x11-libs/gtk+:2
	>=media-libs/libgphoto2-2.5.0
	>=media-libs/libexif-0.3.2
	media-libs/libexif-gtk
	gimp? ( >=media-gfx/gimp-2 )
	gnome? (
		>=gnome-base/libbonobo-2
		>=gnome-base/libgnomeui-2 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	app-text/scrollkeeper
	nls? ( >=sys-devel/gettext-0.14.1 )"

pkg_setup() {
	DOCS="AUTHORS CHANGES NEWS README TODO"
	G2CONF="${G2CONF}
		$(use_with gimp)
		$(use_with gnome)
		$(use_with gnome bonobo)
		$(use_enable nls)
		--disable-scrollkeeper
		--with-rpmbuild=/bin/false"
}

src_prepare() {
	gnome2_src_prepare

	# Fix .desktop validity, bug #271569
	epatch "${FILESDIR}/${PN}-0.1.18-desktop-validation.patch"
}
src_install() {
	gnome2_src_install
	rm -rf "${ED}"/usr/share/doc/gtkam || die "rm failed"
}
