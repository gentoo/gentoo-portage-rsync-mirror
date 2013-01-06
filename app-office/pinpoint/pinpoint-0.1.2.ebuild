# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/pinpoint/pinpoint-0.1.2.ebuild,v 1.2 2012/05/03 20:00:41 jdhore Exp $

EAPI=4

GNOME_TARBALL_SUFFIX="bz2"

inherit gnome.org

DESCRIPTION="A tool for making hackers do excellent presentations"
HOMEPAGE="https://live.gnome.org/Pinpoint"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples +gstreamer +pdf"

# rsvg is used for svg-in-pdf -- clubbing it under pdf for now
RDEPEND=">=media-libs/clutter-1.4:1.0
	>=dev-libs/glib-2.28:2
	>=x11-libs/cairo-1.9.4
	x11-libs/pango
	x11-libs/gdk-pixbuf:2
	gstreamer? ( >=media-libs/clutter-gst-1.3:1.0 )
	pdf? ( gnome-base/librsvg:2 )"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

src_configure() {
	# dax support is disabled because we don't have it in tree yet and it's
	# experimental
	econf --disable-dax \
		$(use_enable gstreamer cluttergst) \
		$(use_enable pdf rsvg)
}

src_install() {
	default

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins introduction.pin bg.jpg bowls.jpg linus.jpg
	fi
}
