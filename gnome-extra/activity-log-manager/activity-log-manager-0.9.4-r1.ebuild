# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/activity-log-manager/activity-log-manager-0.9.4-r1.ebuild,v 1.3 2013/04/24 06:17:46 jlec Exp $

EAPI=5

GNOME2_LA_PUNT="yes"
VALA_MIN_API_VERSION="0.10"

inherit autotools eutils gnome2 vala versionator

DESCRIPTION="GUI which lets you easily control what gets logged by Zeitgeist"
HOMEPAGE="https://launchpad.net/activity-log-manager/"
SRC_URI="http://launchpad.net/history-manager/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/libzeitgeist
	dev-libs/libgee:0
	dev-libs/glib:2
	gnome-extra/zeitgeist
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/pango"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/intltool
	sys-devel/gettext"

src_prepare() {
	DOCS="README NEWS INSTALL ChangeLog AUTHORS"
	epatch \
		"${FILESDIR}"/${PN}-0.9.0.1-gold.patch \
		"${FILESDIR}"/${PN}-0.9.1-ccpanel.patch \
		"${FILESDIR}"/${P}-muxer.patch
	cp "${FILESDIR}"/config.vapi src/ || die
	sed \
		-e "/^almdocdir/s:=.*$:= \${prefix}/share/doc/${PF}:g" \
		-i Makefile.am || die
	vala_src_prepare
	eautoreconf
	gnome2_src_prepare
}
