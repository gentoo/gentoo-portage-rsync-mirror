# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/activity-log-manager/activity-log-manager-0.9.4.ebuild,v 1.2 2012/05/21 19:00:55 tetromino Exp $

EAPI=4

inherit autotools eutils gnome2 versionator

DESCRIPTION="GUI which lets you easily control what gets logged by Zeitgeist"
HOMEPAGE="https://launchpad.net/activity-log-manager/"
SRC_URI="http://launchpad.net/history-manager/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

VALASLOT="0.10"

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
	dev-lang/vala:${VALASLOT}
	dev-util/intltool
	sys-devel/gettext
"

#S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	DOCS="README NEWS INSTALL ChangeLog AUTHORS"
# no without possible
#	G2CONF="${G2CONF}
#		--without-ccpanel
#		--without-whoopsie"
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.9.0.1-gold.patch \
		"${FILESDIR}"/${PN}-0.9.1-ccpanel.patch
	sed \
		-e "/^almdocdir/s:=.*$:= \${prefix}/share/doc/${PF}:g" \
		-i Makefile.am || die
	sed \
		-e 's:-g::g' \
		-i src/Makefile.am || die
	eautoreconf
	export VALAC="$(type -p valac-${VALASLOT})"
	gnome2_src_prepare
}
