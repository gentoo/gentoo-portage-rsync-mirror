# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camorama/camorama-0.19-r1.ebuild,v 1.5 2012/05/05 08:58:53 jdhore Exp $

EAPI=1

inherit eutils gnome2

DESCRIPTION="a webcam application featuring various image filters."
HOMEPAGE="http://camorama.fixedgear.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	dev-util/intltool"

pkg_setup() {
	G2CONF="${G2CONF} --disable-schemas-install"
}

src_unpack() {
	gnome2_src_unpack

	# Fix sandbox access violation, bug #243274
	epatch "${FILESDIR}/${P}-gconf.patch"
}
