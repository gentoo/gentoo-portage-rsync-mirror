# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/google-gadgets/google-gadgets-0.11.2.ebuild,v 1.20 2012/07/16 10:25:26 kensington Exp $

EAPI=4
inherit autotools eutils fdo-mime multilib

MY_PN=${PN}-for-linux
MY_P=${MY_PN}-${PV}

DESCRIPTION="Cool gadgets from Google for your Desktop"
HOMEPAGE="http://code.google.com/p/google-gadgets-for-linux/"
SRC_URI="http://${MY_PN}.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 x86"
IUSE="+dbus debug +gtk +qt4 +gstreamer networkmanager soup startup-notification"
REQUIRED_USE="|| ( gtk qt4 )"

# Weird things happen when we start mix-n-matching, so for the time being
# I've just locked the deps to the versions I had as of Summer 2008. With any
# luck, they'll be stable when we get to stabling this package.

RDEPEND="
	>=dev-libs/libxml2-2.6.32:2
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	dbus? ( sys-apps/dbus )
	gstreamer? (
		>=media-libs/gstreamer-0.10.19:0.10
		>=media-libs/gst-plugins-base-0.10.19:0.10
	)
	gtk? (
		>=dev-libs/atk-1.22.0
		gnome-base/librsvg:2
		>=net-misc/curl-7.18.2
		>=x11-libs/cairo-1.6.4
		>=x11-libs/gtk+-2.12.10:2
		>=x11-libs/pango-1.20.3
		dbus? ( >=dev-libs/dbus-glib-0.74 )
	)
	networkmanager? ( net-misc/networkmanager )
	qt4? (
		>=x11-libs/qt-core-4.4.0:4
		>=x11-libs/qt-opengl-4.4.0:4
		>=x11-libs/qt-script-4.4.0:4
		>=x11-libs/qt-webkit-4.4.0:4
		>=x11-libs/qt-xmlpatterns-4.4.0:4
		dbus? ( >=x11-libs/qt-dbus-4.4.0:4 )
	)
	soup? ( >=net-libs/libsoup-2.26:2.4 )
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

RESTRICT="test"

DOCS="ChangeLog README"

pkg_setup() {
	if ! use gstreamer; then
		ewarn "Disabling gstreamer disables the multimedia functions of ${PN}."
		ewarn "This is not recommended. To enable gstreamer, do:"
		ewarn "echo \"${CATEGORY}/${PN} gstreamer\" >> /etc/portage/package.use"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-configure_ggl_nm.patch
	epatch "${FILESDIR}"/${P}-glib-2.31.patch
	epatch "${FILESDIR}"/${P}-gcc-4.7.patch
	epatch "${FILESDIR}"/${P}-networkmanager-0.9.patch

	# zlib-1.2.5.1-r1 renames the OF macro in zconf.h, bug 385477.
	has_version '>=sys-libs/zlib-1.2.5.1-r1' && sed -i -e \
		'1i#define OF(x) x' third_party/unzip/ioapi.h

	eautoreconf
}

src_configure() {
	econf \
		--disable-update-desktop-database \
		--disable-update-mime-database \
		--disable-werror \
		--enable-libxml2-xml-parser \
		--with-browser-plugins-dir=/usr/$(get_libdir)/nsbrowser/plugins \
		--with-ssl-ca-file=/etc/ssl/certs/ca-certificates.crt \
		--with-oem-brand=Gentoo \
		$(use_enable debug) \
		$(use_enable dbus libggadget-dbus) \
		$(use_enable gstreamer gst-audio-framework) \
		$(use_enable gstreamer gst-video-element) \
		$(use_with networkmanager) \
		$(use_enable soup soup-xml-http-request) \
		$(use_enable gtk gtk-host) \
		$(use_enable gtk libggadget-gtk ) \
		$(use_enable gtk gtk-edit-element) \
		$(use_enable gtk gtk-flash-element) \
		$(use_enable gtk gtk-system-framework) \
		$(use_enable gtk curl_xml_http_request) \
		$(use_enable qt4 qt-host) \
		$(use_enable qt4 libggadget-qt) \
		$(use_enable qt4 qt-edit-framework) \
		$(use_enable qt4 qt-system-framework) \
		$(use_enable qt4 qtwebkit-browser-element) \
		$(use_enable qt4 qt-xml-http-request) \
		$(use_enable qt4 qt-script-runtime) \
		--disable-gtkmoz-browser-element \
		--disable-smjs-script-runtime \
		--disable-gtkwebkit-browser-element \
		--disable-webkit-script-runtime
}

src_test() {
	#If someone wants to guarantee that emake will not make
	#tests fail promiscuosly, please do, otherwise we're using make.
	make check &> "${WORKDIR}"/check
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
