# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/netsurf/netsurf-2.9.ebuild,v 1.6 2013/04/21 07:48:27 xmw Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="a free, open source web browser"
HOMEPAGE="http://www.netsurf-browser.org/"
SRC_URI="http://download.netsurf-browser.org/${PN}/releases/source-full/${P}-full-src.tar.gz
	http://xmw.de/mirror/netsurf-fb.modes-example.gz"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="bmp fbcon truetype gif gstreamer gtk javascript jpeg mng pdf-writer png rosprite svg svgtiny webp"

RDEPEND="dev-libs/libcss
	dev-libs/libxml2
	net-libs/hubbub
	net-misc/curl
	bmp? ( media-libs/libnsbmp )
	fbcon? ( dev-libs/libnsfb )
	truetype? ( media-fonts/dejavu
		media-libs/freetype )
	gif? ( media-libs/libnsgif )
	gtk? ( dev-libs/glib:2
		gnome-base/libglade:2.0
		media-libs/lcms:0
		x11-libs/gtk+:2 )
	jpeg? ( virtual/jpeg )
	mng? ( media-libs/libmng )
	pdf-writer? ( media-libs/libharu )
	png? ( media-libs/libpng )
	svg? ( svgtiny? ( media-libs/libsvgtiny )
		!svgtiny? ( gnome-base/librsvg:2 ) )
	webp? ( media-libs/libwebp )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	rosprite? ( media-libs/librosprite )"

REQUIRED_USE="|| ( fbcon gtk )"

src_unpack() {
	default
	einfo "remove bundled libs"
	cd "${WORKDIR}" || die
	mv ${P} ${P}_complete || die
	mv ${P}_complete/${P} . || die
	rm -r ${P}_complete || die
}

src_prepare() {
	sed -e '/CFLAGS \(:\|+\)=/d' \
		-i Makefile.defaults || die
	sed -e '/^#define NSFB_TOOLBAR_DEFAULT_LAYOUT/s:blfsrut:blfsrutc:' \
		-i framebuffer/gui.c || die
	sed -e 's/xml2-config/${PKG_CONFIG} libxml-2.0/g' \
		-i */Makefile.target || die

	epatch "${FILESDIR}"/${P}-buildsystem.patch
	epatch "${FILESDIR}"/${P}-includes.patch
	epatch "${FILESDIR}"/${P}-conditionally-include-image-headers.patch
}

src_configure() {
	netsurf_set() {
		echo "override $1 := $2" >> Makefile.config || die
	}
	netsurf_use() {
		local val=${4:-NO}
		use $2 && val=${3:-YES}
		echo "override $1 := $val" >> Makefile.config || die
	}
	#see Makefile.defaults
	netsurf_use NETSURF_USE_BMP bmp
	netsurf_use NETSURF_USE_GIF gif
	netsurf_use NETSURF_USE_JPEG jpeg
	netsurf_use NETSURF_USE_PNG png
	netsurf_use NETSURF_USE_MNG mng
	netsurf_use NETSURF_USE_WEBP webp
	netsurf_use NETSURF_USE_VIDEO gstreamer
	netsurf_use NETSURF_USE_JS javascript
	netsurf_use NETSURF_USE_HARU_PDF pdf-writer
	netsurf_set PREFIX /usr
	netsurf_set Q
	netsurf_set CC $(tc-getCC)
	netsurf_set LD $(tc-getCC)
	netsurf_set PKG_CONFIG $(tc-getPKG_CONFIG)

	if use svg ; then
		if use svgtiny ; then
			netsurf_set NETSURF_USE_NSSVG YES
			netsurf_set NETSURF_USE_RSVG NO
		else
			netsurf_set NETSURF_USE_NSSVG NO
			netsurf_set NETSURF_USE_RSVG YES
		fi
	else
		netsurf_set NETSURF_USE_NSSVG NO
		netsurf_set NETSURF_USE_RSVG NO
	fi
	if use fbcon ; then
		netsurf_set NETSURF_FB_FRONTEND linux
		netsurf_use NETSURF_FB_FONTLIB truetype freetype internal
		netsurf_set NETSURF_FB_FONTPATH /usr/share/fonts/dejavu
	fi
	netsurf_use NETSURF_USE_ROSPRITE rosprite
}

src_compile() {
	use gtk && emake PREFIX="/usr" TARGET=gtk
	use fbcon && emake PREFIX="/usr" TARGET=framebuffer
}

src_install() {
	if use gtk ; then
		emake DESTDIR="${D}" PREFIX="/usr" TARGET=gtk install
		mv "${D}"/usr/bin/netsurf{,-gtk} || die
		make_desktop_entry /usr/bin/netsurf-gtk NetSurf-gtk netsurf "Network;WebBrowser"
	fi
	if use fbcon ; then
		emake DESTDIR="${D}" PREFIX="/usr" TARGET=framebuffer install
		mv "${D}"/usr/bin/netsurf{,-fb} || die
		make_desktop_entry /usr/bin/netsurf-fb NetSurf-framebuffer netsurf "Network;WebBrowser"

		einfo
		elog "In order to setup the framebuffer console, netsurf needs an /etc/fb.modes"
		elog "You can use an example from /usr/share/doc/${PF}/fb.modes.* (bug 427092)."
		einfo
		elog "Please make /etc/input/mice readable to the account using netsurf-fb."
		elog "Either use chmod a+r /etc/input/mice (security!!!) or use an group."
		einfo
	fi
	insinto /usr/share/pixmaps
	doins gtk/res/netsurf.xpm

	dodoc -r Docs/{USING-*,ideas}
	newdoc "${WORKDIR}"/netsurf-fb.modes-example fb.modes
}
