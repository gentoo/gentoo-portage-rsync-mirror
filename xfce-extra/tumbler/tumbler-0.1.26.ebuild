# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/tumbler/tumbler-0.1.26.ebuild,v 1.1 2012/12/10 07:55:22 ssuominen Exp $

EAPI=5
inherit xfconf

DESCRIPTION="A thumbnail service for the filemanager of Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/thunar/"
SRC_URI="mirror://xfce/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug ffmpeg gstreamer jpeg odf pdf raw"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.100
	>=dev-libs/glib-2.24
	media-libs/freetype:2
	>=media-libs/libpng-1.2:0
	>=sys-apps/dbus-1.6
	>=x11-libs/gdk-pixbuf-2.14
	ffmpeg? ( >=media-video/ffmpegthumbnailer-2.0.8 )
	gstreamer? (
		=media-libs/gstreamer-1.0*
		=media-libs/gst-plugins-base-1.0*
		)
	jpeg? ( virtual/jpeg )
	odf? ( >=gnome-extra/libgsf-1.14.20 )
	pdf? ( >=app-text/poppler-0.12.4[cairo] )
	raw? ( >=media-libs/libopenraw-0.0.8[gtk] )"
RDEPEND="${COMMON_DEPEND}
	>=xfce-base/thunar-1.4"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		$(use_enable jpeg jpeg-thumbnailer)
		$(use_enable ffmpeg ffmpeg-thumbnailer)
		$(use_enable gstreamer gstreamer-thumbnailer)
		$(use_enable odf odf-thumbnailer)
		$(use_enable pdf poppler-thumbnailer)
		$(use_enable raw raw-thumbnailer)
		$(xfconf_use_debug)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
