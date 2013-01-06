# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/paprefs/paprefs-0.9.9.ebuild,v 1.6 2012/05/05 08:45:42 mgorny Exp $

EAPI=2

DESCRIPTION="PulseAudio Preferences, configuration dialog for PulseAudio"
HOMEPAGE="http://0pointer.de/lennart/projects/paprefs"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="nls"

RDEPEND="dev-cpp/gtkmm:2.4
	dev-cpp/libglademm:2.4
	>=dev-cpp/gconfmm-2.6
	>=dev-libs/libsigc++-2.2:2
	>=media-sound/pulseaudio-0.9.5[glib]
	|| ( x11-themes/tango-icon-theme x11-themes/gnome-icon-theme )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		dev-util/intltool )
	virtual/pkgconfig"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-lynx \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dohtml -r doc
	dodoc README
}
