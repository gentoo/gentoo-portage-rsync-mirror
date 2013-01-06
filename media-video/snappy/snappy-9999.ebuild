# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/snappy/snappy-9999.ebuild,v 1.4 2011/11/07 07:43:30 nirbheek Exp $

EAPI="4"

if [[ ${PV} = 9999 ]]; then
	inherit autotools git-2
fi

DESCRIPTION="A simple media player written using GStreamer and Clutter"
HOMEPAGE="https://github.com/luisbg/snappy"

if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="git://github.com/luisbg/${PN}.git
		https://github.com/luisbg/${PN}.git"
	EGIT_BOOTSTRAP="eautoreconf"
	KEYWORDS=""
else
	SRC_URI="http://people.collabora.co.uk/~luisbg/${PN}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2 LGPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=dev-libs/glib-2.26:2
	>=media-libs/clutter-1.2.0:1.0
	>=media-libs/clutter-gst-1.0.0:1.0
	x11-libs/libXtst

	>=media-libs/gstreamer-0.10.30:0.10
	>=media-libs/gst-plugins-base-0.10.30:0.10

	>=media-plugins/gst-plugins-meta-0.10-r2:0.10

	!!net-misc/spice-gtk" # FIXME: File collision -- /usr/bin/snappy
DEPEND="${RDEPEND}"

DOCS="AUTHORS README THANKS ToDo docs/clutter_controls_layout docs/keyboard_controls"

src_configure() {
	# Just needs GDBus, will fallback gracefully without dbus installed.
	# Probably.
	econf --enable-dbus
}
