# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subtitleeditor/subtitleeditor-0.40.0.ebuild,v 1.5 2012/05/04 00:50:42 tetromino Exp $

EAPI="4"

inherit eutils versionator flag-o-matic

DESCRIPTION="GTK+2 subtitle editing tool."
HOMEPAGE="http://home.gna.org/subtitleeditor/"
SRC_URI="http://download.gna.org/${PN}/$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug nls opengl"

RDEPEND="
	app-text/iso-codes
	>=dev-cpp/gtkmm-2.14:2.4
	>=dev-cpp/glibmm-2.16.3:2
	>=dev-cpp/libxmlpp-2.20:2.6
	>=app-text/enchant-1.4
	>=dev-cpp/gstreamermm-0.10.4
	>=media-libs/gst-plugins-good-0.10:0.10
	>=media-plugins/gst-plugins-meta-0.10-r2:0.10
	>=media-plugins/gst-plugins-pango-0.10:0.10
	>=media-plugins/gst-plugins-xvideo-0.10:0.10
	opengl? ( >=dev-cpp/gtkglextmm-1.2 )
"
# gst-plugins-pango needed for text overlay
# gst-plugins-xvideo needed for video output

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	# bug #413843, https://gna.org/bugs/index.php?19709
	epatch "${FILESDIR}/${P}-glib-2.31.patch"
}

src_configure() {
	export GST_REGISTRY="${T}/home/registry.cache.xml"

	# Avoid using --enable-debug as it mocks with CXXFLAGS and LDFLAGS
	use debug && append-flags -DDEBUG

	econf \
		--disable-debug \
		$(use_enable nls) \
		$(use_enable opengl gl)
}

src_install() {
	default

	# plugins are loaded without the help of libtool files
	find "${D}" -name '*.la' -delete || die "failed to remove *.la files"
}

pkg_postinst() {
	ewarn
	ewarn "If ${PN} doesn't play some video format, please check your"
	ewarn "USE flags on media-plugins/gst-plugins-meta"
	ewarn
}
