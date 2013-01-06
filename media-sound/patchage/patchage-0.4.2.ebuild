# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/patchage/patchage-0.4.2.ebuild,v 1.6 2012/05/05 08:45:11 mgorny Exp $

EAPI=1

DESCRIPTION="Modular patch bay for audio and MIDI systems"
HOMEPAGE="http://wiki.drobilla.net/Patchage"
SRC_URI="http://download.drobilla.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa dbus debug jack"

RDEPEND=">=media-libs/raul-0.5.1
	>=x11-libs/flowcanvas-0.5.1
	>=dev-cpp/gtkmm-2.11.12:2.4
	dev-cpp/glibmm:2
	dev-cpp/libglademm:2.4
	dev-cpp/libgnomecanvasmm:2.6
	dev-libs/boost
	jack? ( >=media-sound/jack-audio-connection-kit-0.107 )
	alsa? ( media-libs/alsa-lib )
	dbus? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	econf $(use_enable debug) \
		$(use_enable debug pointer-debug) \
		$(use_enable alsa ) \
		$(use_enable jack) \
		$(use_enable dbus)
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
}
