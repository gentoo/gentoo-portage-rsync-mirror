# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-boxes/gnome-boxes-3.10.2.ebuild,v 1.4 2014/03/09 10:49:40 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
VALA_USE_DEPEND="vapigen"
VALA_MIN_API_VERSION="0.22"

inherit linux-info gnome2 vala

DESCRIPTION="Simple GNOME 3 application to access remote or virtual systems"
HOMEPAGE="https://wiki.gnome.org/Design/Apps/Boxes"

LICENSE="LGPL-2"
SLOT="0"

# We force 'bindist' due licenses from gnome-boxes-nonfree
IUSE="smartcard usbredir" #bindist
KEYWORDS="amd64" # qemu-kvm[spice] is 64bit-only

# NOTE: sys-fs/* stuff is called via exec()
# FIXME: ovirt is not available in tree
RDEPEND="
	>=dev-libs/glib-2.32:2
	>=dev-libs/gobject-introspection-0.9.6
	>=dev-libs/libxml2-2.7.8:2
	>=sys-libs/libosinfo-0.2.7
	>=app-emulation/qemu-1.3.1[spice,smartcard?,usbredir?]
	>=app-emulation/libvirt-0.9.3[libvirtd,qemu]
	>=app-emulation/libvirt-glib-0.1.7
	>=x11-libs/gtk+-3.9:3
	>=net-libs/gtk-vnc-0.4.4[gtk3]
	>=net-misc/spice-gtk-0.16[gtk3,smartcard?,usbredir?]

	>=app-misc/tracker-0.16:0=[iso]

	>=media-libs/clutter-gtk-1.3.2:1.0
	>=media-libs/clutter-1.11.14:1.0
	>=sys-apps/util-linux-2.20
	>=net-libs/libsoup-2.38:2.4

	sys-fs/fuse
	sys-fs/fuseiso
	sys-fs/mtools
	>=virtual/udev-165[gudev]
"
#	!bindist? ( gnome-extra/gnome-boxes-nonfree )

DEPEND="${RDEPEND}
	app-text/yelp-tools
	dev-util/desktop-file-utils
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"

pkg_pretend() {
	linux_config_exists

	if ! { linux_chkconfig_present KVM_AMD || \
		linux_chkconfig_present KVM_INTEL; }; then
		ewarn "You need KVM support in your kernel to use GNOME Boxes!"
	fi
}

src_prepare() {
	# Do not change CFLAGS, wondering about VALA ones but appears to be
	# needed as noted in configure comments below
	sed 's/CFLAGS="$CFLAGS -O0 -ggdb3"//' -i configure{.ac,} || die

	vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	DOCS="AUTHORS README NEWS THANKS TODO"
	# debug needed for splitdebug proper behavior (cardoe)
	gnome2_src_configure \
		--enable-debug \
		--disable-strict-cc \
		$(use_enable usbredir) \
		$(use_enable smartcard) \
		--enable-ovirt=no
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "Before running gnome-boxes, you will need to load the KVM modules"
	elog "If you have an Intel Processor, run:"
	elog "	modprobe kvm-intel"
	einfo
	elog "If you have an AMD Processor, run:"
	elog "	modprobe kvm-amd"
}
