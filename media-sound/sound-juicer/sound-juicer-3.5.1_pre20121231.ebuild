# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sound-juicer/sound-juicer-3.5.1_pre20121231.ebuild,v 1.1 2012/12/31 14:04:55 eva Exp $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="CD ripper for GNOME"
HOMEPAGE="http://www.burtonini.com/blog/computers/sound-juicer/"
SRC_URI="http://dev.gentoo.org/~eva/distfiles/${PN}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="flac test vorbis"

COMMON_DEPEND="
	>=dev-libs/glib-2.32:2
	>=x11-libs/gtk+-2.90:3
	media-libs/libcanberra[gtk3]
	>=app-cdr/brasero-2.90
	>=gnome-base/gconf-2:2
	sys-apps/dbus

	media-libs/libdiscid
	>=media-libs/musicbrainz-5.0.1:5

	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0[vorbis?]
	flac? ( media-plugins/gst-plugins-flac:1.0 )
"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gvfs[cdda,udev]
	|| (
		media-plugins/gst-plugins-cdparanoia:1.0
		media-plugins/gst-plugins-cdio:1.0 )
	media-plugins/gst-plugins-meta:1.0
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	>=app-text/scrollkeeper-0.3.5
	app-text/gnome-doc-utils
	virtual/pkgconfig
	test? ( ~app-text/docbook-xml-dtd-4.3 )"

# Upstream did not do a post-release version bump.
S="${WORKDIR}/${PN}-3.5.0"

src_prepare() {
	gnome2_src_prepare

	# FIXME: gst macros does not take GST_INSPECT override anymore but we need a
	# way to disable inspection due to gst-clutter always creating a GL context
	# which is forbidden in sandbox since it needs write access to
	# /dev/card*/dri
	sed -e "s|\(gstinspect=\).*|\1$(type -P true)|" \
		-i configure || die
}

pkg_postinst() {
	gnome2_pkg_postinst
	ewarn "If ${PN} does not rip to some music format, please check your USE flags"
	ewarn "on media-libs/libgnome-media-profiles and media-plugins/gst-plugins-meta"
	ewarn
	ewarn "The list of audio encoding profiles in ${P} is non-customizable."
	ewarn "A possible workaround is to rip to flac using ${PN}, and convert to"
	ewarn "your desired format using a separate tool."
}
