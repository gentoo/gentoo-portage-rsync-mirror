# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nemo/nemo-2.2.1.ebuild,v 1.3 2014/06/24 12:16:12 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools eutils gnome2 python-any-r1 virtualx

DESCRIPTION="A file manager for Cinnamon, forked from Nautilus"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/nemo/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ LGPL-2+ FDL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="exif +introspection +l10n packagekit tracker xmp"

COMMON_DEPEND="
	>=dev-libs/glib-2.34:2
	>=gnome-extra/cinnamon-desktop-1.0:0=
	>=x11-libs/pango-1.28.3
	>=x11-libs/gtk+-3.3.17:3[introspection?]
	>=dev-libs/libxml2-2.7.8:2

	gnome-base/dconf:0=
	gnome-base/gsettings-desktop-schemas
	>=x11-libs/libnotify-0.7:=
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender

	exif? ( >=media-libs/libexif-0.6.20:= )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	tracker? ( >=app-misc/tracker-0.12:= )
	xmp? ( >=media-libs/exempi-2.1.0:= )
"
RDEPEND="${COMMON_DEPEND}
	x11-themes/gnome-icon-theme-symbolic
	l10n? ( >=gnome-extra/cinnamon-translations-2.2 )
"
DEPEND="${COMMON_DEPEND}
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		dev-python/polib[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	>=dev-lang/perl-5
	>=dev-util/gdbus-codegen-2.31.0
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40.1
	sys-devel/gettext
	virtual/pkgconfig
	x11-proto/xproto

	dev-util/gtk-doc
	gnome-base/gnome-common
"
# For eautoreconf
#	gnome-base/gnome-common, dev-util/gtk-doc (not only -am!)
PDEPEND=">=gnome-base/gvfs-0.1.2"

src_prepare() {
	epatch_user
	eautoreconf # no configure in tarball
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-update-mimedb \
		--disable-more-warnings \
		$(use_enable exif libexif) \
		$(use_enable introspection) \
		$(use_enable tracker) \
		$(use_enable xmp)
}

src_test() {
	if ! [[ -f "${EROOT}usr/share/glib-2.0/schemas/org.nemo.gschema.xml" ]]; then
		ewarn "Skipping tests because Nemo gsettings schema are not installed."
		ewarn "To run the tests, a version of ${CATEGORY}/${PN} needs to be"
		ewarn "already installed."
		return
	fi
	gnome2_environment_reset
	unset DBUS_SESSION_BUS_ADDRESS
	export GSETTINGS_BACKEND="memory"
	cd src # we don't care about translation tests
	Xemake check
	unset GSETTINGS_BACKEND
}
