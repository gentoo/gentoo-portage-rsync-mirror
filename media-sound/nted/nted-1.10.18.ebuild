# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/nted/nted-1.10.18.ebuild,v 1.7 2012/07/12 19:08:53 hwoarang Exp $

EAPI=4

inherit eutils

DESCRIPTION="WYSIWYG score editor for GTK+"
HOMEPAGE="http://vsr.informatik.tu-chemnitz.de/staff/jan/nted/nted.xhtml"
SRC_URI="http://vsr.informatik.tu-chemnitz.de/staff/jan/${PN}/sources/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2 NTED_FONT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc debug nls"

RDEPEND=">=dev-libs/glib-2
	media-libs/alsa-lib
	>=media-libs/freetype-2
	x11-libs/cairo
	>=x11-libs/gdk-pixbuf-2
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-text/xmlto )
	nls? ( sys-devel/gettext )"

DOCS="ABOUT_THE_EXAMPLES.TXT AUTHORS FAQ README"

src_prepare() {
	# bug #424291
	epatch "${FILESDIR}"/${P}-gcc47.patch
}

src_configure() {
	# Trick ./configure to believe we have gnome-extra/yelp installed.
	has_version gnome-extra/yelp || export ac_cv_path_YELP="$(type -P true)"

	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_with doc)
}
