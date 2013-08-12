# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdstyler/dvdstyler-2.5.1.ebuild,v 1.1 2013/08/12 16:30:13 aballier Exp $

EAPI=5

MY_P=${P/dvds/DVDS}
WX_GTK_VER=2.8

inherit wxwidgets

DESCRIPTION="A cross-platform free DVD authoring application"
HOMEPAGE="http://www.dvdstyler.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug deprecated +udev"

COMMON_DEPEND=">=app-cdr/dvd+rw-tools-7.1
	media-libs/libexif
	>=media-libs/wxsvg-1.1.14
	>=media-video/dvdauthor-0.7
	>=media-video/xine-ui-0.99.1
	virtual/cdrtools
	>=virtual/ffmpeg-0.10[encode]
	virtual/jpeg
	>=x11-libs/wxGTK-2.8.7:2.8[gstreamer,X]
	deprecated? ( >=gnome-base/libgnomeui-2 )
	udev? ( virtual/udev )"
RDEPEND="${COMMON_DEPEND}
	>=app-cdr/dvdisaster-0.72.2"
DEPEND="${COMMON_DEPEND}
	virtual/yacc
	app-arch/zip
	app-text/xmlto
	sys-devel/gettext
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# libgnomeui-2 is very old, disable for now until someone complains
	use deprecated || sed -i -e '/PKG_CONFIG/s:libgnomeui-2.0:dIsAbLeAuToMaGiC&:' configure

	# rmdir: failed to remove `tempfoobar': Directory not empty
	sed -i -e '/rmdir "$$t"/d' docs/Makefile.in || die

	sed -i -e 's:@LIBS@:& -ljpeg:' wxVillaLib/Makefile.in || die #367863

	sed -i \
		-e '/Icon/s:.png::' \
		-e '/^Encoding/d' \
		-e '/Categories/s:Application;::' \
		data/dvdstyler.desktop || die
}

src_configure() {
	econf \
	 	--docdir=/usr/share/doc/${PF} \
		$(use_enable debug) \
		--with-wx-config=${WX_CONFIG}
}

src_install() {
	default
	rm -f "${ED}"usr/share/doc/${PF}/{COPYING*,INSTALL*}
}
