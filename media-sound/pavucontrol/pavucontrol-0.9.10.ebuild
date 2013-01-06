# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pavucontrol/pavucontrol-0.9.10.ebuild,v 1.5 2012/05/05 08:46:01 mgorny Exp $

EAPI=2

DESCRIPTION="Pulseaudio Volume Control, GTK based mixer for Pulseaudio"
HOMEPAGE="http://0pointer.de/lennart/projects/pavucontrol/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=dev-cpp/gtkmm-2.16:2.4
	dev-cpp/libglademm:2.4
	>=dev-libs/libsigc++-2.2:2
	>=x11-libs/gtk+-2.16:2
	>=media-sound/pulseaudio-0.9.16[glib]
	>=media-libs/libcanberra-0.16[gtk]
	|| ( x11-themes/tango-icon-theme x11-themes/gnome-icon-theme )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		dev-util/intltool )
	virtual/pkgconfig"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html \
		--disable-dependency-tracking \
		--disable-lynx \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
}
