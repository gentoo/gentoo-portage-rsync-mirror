# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gl/gst-plugins-gl-0.10.2.ebuild,v 1.3 2013/01/23 08:33:04 eva Exp $

EAPI=2

DESCRIPTION="GStreamer OpenGL plugins"
HOMEPAGE="http://gstreamer.freedesktop.org/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=media-libs/glew-1.5
	>=media-libs/libpng-1.4
	>=media-libs/gstreamer-0.10.28:0.10
	>=media-libs/gst-plugins-base-0.10.28:0.10
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
	econf \
		--disable-static \
		--disable-dependency-tracking \
		$(use_enable nls) \
		--disable-examples \
		--disable-valgrind \
		--with-package-origin="http://packages.gentoo.org/package/media-plugins/gst-plugins-gl" \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README RELEASE TODO
	find "${D}" -name '*.la' -exec rm -f '{}' +
}
