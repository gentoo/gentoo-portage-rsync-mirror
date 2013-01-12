# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/spice-gtk/spice-gtk-0.14.ebuild,v 1.9 2013/01/12 21:23:16 cardoe Exp $

EAPI="4"
GCONF_DEBUG="no"
WANT_AUTOMAKE="1.11"

inherit autotools eutils python

PYTHON_DEPEND="2"

DESCRIPTION="Set of GObject and Gtk objects for connecting to Spice servers and a client GUI."
HOMEPAGE="http://spice-space.org http://gitorious.org/spice-gtk"

LICENSE="LGPL-2.1"
SLOT="0"
SRC_URI="http://spice-space.org/download/gtk/${P}.tar.bz2"
KEYWORDS="amd64 x86"
IUSE="doc gstreamer gtk3 +introspection policykit pulseaudio
python sasl smartcard static-libs usbredir vala"

# TODO:
# * check if sys-freebsd/freebsd-lib (from virtual/acl) provides acl/libacl.h
# * use external pnp.ids as soon as that means not pulling in gnome-desktop
RDEPEND="pulseaudio? ( media-sound/pulseaudio[glib] )
	gstreamer? ( !pulseaudio? (
		media-libs/gstreamer:0.10
		media-libs/gst-plugins-base:0.10 ) )
	>=app-emulation/spice-protocol-0.10.1
	>=x11-libs/pixman-0.17.7
	>=media-libs/celt-0.5.1.1:0.5.1
	dev-libs/openssl
	gtk3? ( x11-libs/gtk+:3[introspection?] )
	!gtk3? ( x11-libs/gtk+:2[introspection?] )
	>=dev-libs/glib-2.26:2
	>=x11-libs/cairo-1.2
	virtual/jpeg
	sys-libs/zlib
	introspection? ( dev-libs/gobject-introspection )
	python? ( dev-python/pygtk:2 )
	sasl? ( dev-libs/cyrus-sasl )
	smartcard? ( app-emulation/libcacard )
	usbredir? (
		sys-apps/hwids
		policykit? (
			sys-apps/acl
			>=sys-auth/polkit-0.101 )
		virtual/libusb:1
		>=sys-apps/usbredir-0.4.2
		virtual/udev[gudev] )"
DEPEND="${RDEPEND}
	vala? ( dev-lang/vala:0.14 )
	dev-lang/python
	virtual/pyparsing
	virtual/pkgconfig
	>=dev-util/intltool-0.40.0
	>=sys-devel/gettext-0.17"

# Hard-deps while building from git:
# dev-lang/vala:0.14
# dev-lang/perl
# dev-perl/Text-CSV

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	if use gstreamer && use pulseaudio ; then
		ewarn "spice-gtk can use only one audio backend: pulseaudio will be used since you enabled both."
	fi
}

src_prepare() {
	epatch \
		"${FILESDIR}/0.12-parallel-install.patch" \
		"${FILESDIR}/${PV}-Deal-with-libusbredirparser.pc-rename-to-libusbredir.patch"
	eautoreconf
}

src_configure() {
	local audio="no"
	local gtk="2.0"

	use gstreamer && audio="gstreamer"
	use pulseaudio && audio="pulse"
	# TODO: do a double build like gtk-vnc does to install both gtk2 & gtk3 libs
	use gtk3 && gtk="3.0"
	if use vala ; then
		# force vala regen for MinGW, etc
		rm -fv gtk/controller/controller.{c,vala.stamp} gtk/controller/menu.c
	fi

	econf --disable-maintainer-mode \
		VALAC=$(type -P valac-0.14) \
		VAPIGEN=$(type -P vapigen-0.14) \
		$(use_enable static-libs static) \
		$(use_enable introspection) \
		--with-audio="${audio}" \
		$(use_with python) \
		$(use_with sasl) \
		$(use_enable smartcard) \
		$(use_enable usbredir) \
		$(use_with usbredir usb-ids-path /usr/share/misc/usb.ids) \
		$(use_with usbredir usb-acl-helper-dir /usr/libexec) \
		$(use_enable policykit polkit) \
		$(use_enable vala) \
		--with-gtk="${gtk}" \
		--disable-werror
}

src_install() {
	default

	use static-libs || rm -rf "${D}"/usr/lib*/*.la
	use python && rm -rf "${D}"/usr/lib*/python*/site-packages/*.la
	use doc || rm -rf "${D}/usr/share/gtk-doc"

	make_desktop_entry spicy Spicy "utilities-terminal" "Network;RemoteAccess;"
}
