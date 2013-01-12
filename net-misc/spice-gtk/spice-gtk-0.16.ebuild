# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/spice-gtk/spice-gtk-0.16.ebuild,v 1.2 2013/01/12 21:35:44 cardoe Exp $

EAPI=5
GCONF_DEBUG="no"
WANT_AUTOMAKE="1.11"

inherit autotools eutils python

PYTHON_DEPEND="2"

DESCRIPTION="Set of GObject and Gtk objects for connecting to Spice servers and a client GUI."
HOMEPAGE="http://spice-space.org http://gitorious.org/spice-gtk"

LICENSE="LGPL-2.1"
SLOT="0"
SRC_URI="http://spice-space.org/download/gtk/${P}.tar.bz2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dbus doc gstreamer gtk3 +introspection policykit pulseaudio
python sasl smartcard static-libs usbredir vala"

REQUIRED_USE="?? ( pulseaudio gstreamer )"

# TODO:
# * check if sys-freebsd/freebsd-lib (from virtual/acl) provides acl/libacl.h
# * use external pnp.ids as soon as that means not pulling in gnome-desktop
RDEPEND="pulseaudio? ( media-sound/pulseaudio[glib] )
	gstreamer? (
		media-libs/gstreamer:0.10
		media-libs/gst-plugins-base:0.10 )
	>=x11-libs/pixman-0.17.7
	>=media-libs/celt-0.5.1.1:0.5.1
	dev-libs/openssl
	gtk3? ( x11-libs/gtk+:3[introspection?] )
	x11-libs/gtk+:2[introspection?]
	>=dev-libs/glib-2.26:2
	>=x11-libs/cairo-1.2
	virtual/jpeg
	sys-libs/zlib
	dbus? ( dev-libs/dbus-glib )
	introspection? ( dev-libs/gobject-introspection )
	python? ( dev-python/pygtk:2 )
	sasl? ( dev-libs/cyrus-sasl )
	smartcard? ( app-emulation/libcacard )
	usbredir? (
		sys-apps/hwids
		>=sys-apps/usbredir-0.4.2
		virtual/libusb:1
		virtual/udev[gudev]
		policykit? (
			sys-apps/acl
			>=sys-auth/polkit-0.101 )
		)"
DEPEND="${RDEPEND}
	>=app-emulation/spice-protocol-0.10.1
	dev-lang/python
	virtual/pyparsing
	dev-perl/Text-CSV
	>=dev-util/intltool-0.40.0
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	vala? ( dev-lang/vala:0.14 )"

# Hard-deps while building from git:
# dev-lang/vala:0.14
# dev-lang/perl

GTK2_BUILDDIR="${WORKDIR}/${P}_gtk2"
GTK3_BUILDDIR="${WORKDIR}/${P}_gtk3"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	mkdir ${GTK2_BUILDDIR} || die
	mkdir ${GTK3_BUILDDIR} || die

	epatch \
		"${FILESDIR}/0.12-parallel-install.patch"
	eautoreconf
}

src_configure() {
	local myconf
	local audio="no"

	use gstreamer && audio="gstreamer"
	use pulseaudio && audio="pulse"

	if use vala ; then
		# force vala regen for MinGW, etc
		rm -fv gtk/controller/controller.{c,vala.stamp} gtk/controller/menu.c
	fi

	myconf="
		$(use_enable static-libs static) \
		$(use_enable introspection) \
		--with-audio=${audio} \
		$(use_with python) \
		$(use_with sasl) \
		$(use_enable smartcard) \
		$(use_enable usbredir) \
		$(use_with usbredir usb-ids-path /usr/share/misc/usb.ids) \
		$(use_with usbredir usb-acl-helper-dir /usr/libexec) \
		$(use_enable policykit polkit) \
		$(use_enable vala) \
		$(use_enable dbus) \
		--disable-werror \
		--enable-pie"

	cd ${GTK2_BUILDDIR}
	echo "Running configure in ${GTK2_BUILDDIR}"
	ECONF_SOURCE="${S}" econf --disable-maintainer-mode \
		VALAC=$(type -P valac-0.14) \
		VAPIGEN=$(type -P vapigen-0.14) \
		--with-gtk=2.0 \
		${myconf}

	if use gtk3; then
		cd ${GTK3_BUILDDIR}
		echo "Running configure in ${GTK3_BUILDDIR}"
		ECONF_SOURCE="${S}" econf --disable-maintainer-mode \
			VALAC=$(type -P valac-0.14) \
			VAPIGEN=$(type -P vapigen-0.14) \
			--with-gtk=3.0 \
			${myconf}
	fi
}

src_compile() {
	cd ${GTK2_BUILDDIR}
	einfo "Running make in ${GTK2_BUILDDIR}"
	default

	if use gtk3; then
		cd ${GTK3_BUILDDIR}
		einfo "Running make in ${GTK3_BUILDDIR}"
		default
	fi
}

src_test() {
	cd ${GTK2_BUILDDIR}
	einfo "Running make check in ${GTK2_BUILDDIR}"
	default

	if use gtk3; then
		cd ${GTK3_BUILDDIR}
		einfo "Running make check in ${GTK3_BUILDDIR}"
		default
	fi
}

src_install() {
	cd ${GTK2_BUILDDIR}
	einfo "Running make check in ${GTK2_BUILDDIR}"
	default

	if use gtk3; then
		cd ${GTK3_BUILDDIR}
		einfo "Running make install in ${GTK3_BUILDDIR}"
		default
	fi

	# Remove .la files if they're not needed
	if ! use static-libs; then
		find "${ED}" -name '*.la' -exec rm -f '{}' + || die
	fi

	use python && rm -rf "${ED}"/usr/lib*/python*/site-packages/*.la
	use doc || rm -rf "${ED}/usr/share/gtk-doc"

	make_desktop_entry spicy Spicy "utilities-terminal" "Network;RemoteAccess;"
}
