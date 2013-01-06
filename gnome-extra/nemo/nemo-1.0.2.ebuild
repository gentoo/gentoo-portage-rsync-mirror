# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nemo/nemo-1.0.2.ebuild,v 1.1 2012/09/28 06:37:30 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 virtualx

DESCRIPTION="A file manager for Cinnamon, forked from Nautilus"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/nemo/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2+ LGPL-2+ FDL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="exif +introspection packagekit sendto tracker xmp"

COMMON_DEPEND=">=dev-libs/glib-2.31.9:2
	>=x11-libs/pango-1.28.3
	>=x11-libs/gtk+-3.3.17:3[introspection?]
	>=dev-libs/libxml2-2.7.8:2
	>=gnome-base/gnome-desktop-3.0.0:3

	gnome-base/dconf
	gnome-base/gsettings-desktop-schemas
	>=x11-libs/libnotify-0.7
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender

	exif? ( >=media-libs/libexif-0.6.20 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	tracker? ( >=app-misc/tracker-0.12 )
	xmp? ( >=media-libs/exempi-2.1.0 )"
DEPEND="${COMMON_DEPEND}
	>=dev-lang/perl-5
	>=dev-util/gdbus-codegen-2.31.0
	>=dev-util/intltool-0.40.1
	sys-devel/gettext
	virtual/pkgconfig
	x11-proto/xproto"
RDEPEND="${COMMON_DEPEND}
	packagekit? ( app-admin/packagekit-base )"
# For eautoreconf
#	gnome-base/gnome-common
#	dev-util/gtk-doc-am"
PDEPEND=">=gnome-base/gvfs-0.1.2"

S="${WORKDIR}/linuxmint-nemo-efd5a01"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-update-mimedb
		$(use_enable exif libexif)
		$(use_enable introspection)
		$(use_enable packagekit)
		$(use_enable sendto nst-extension)
		$(use_enable tracker)
		$(use_enable xmp)"
	DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README THANKS TODO"
}

src_prepare() {
	gnome2_src_prepare

	# Remove crazy CFLAGS
	sed 's:-DG.*DISABLE_DEPRECATED::g' -i configure.in configure \
		|| die "sed 1 failed"
}

src_test() {
	if ! [[ -f "${EROOTDIR}usr/share/glib-2.0/schemas/org.nemo.gschema.xml" ]]; then
		ewarn "Skipping tests because Nemo gsettings schema are not installed."
		ewarn "To run the tests, a version of ${CATEGORY}/${PN} needs to be"
		ewarn "already installed."
		return
	fi
	gnome2_environment_reset
	unset DBUS_SESSION_BUS_ADDRESS
	export GSETTINGS_BACKEND="memory"
	Xemake check
	unset GSETTINGS_BACKEND
}
