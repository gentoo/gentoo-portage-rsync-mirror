# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-3.6.1.ebuild,v 1.3 2013/01/06 11:14:04 ago Exp $

EAPI="5"
GCONF_DEBUG="yes"

inherit autotools eutils gnome2 pax-utils versionator virtualx

DESCRIPTION="GNOME webbrowser based on Webkit"
HOMEPAGE="http://projects.gnome.org/epiphany/"

# TODO: coverage
LICENSE="GPL-2"
SLOT="0"
IUSE="+introspection +jit +nss test"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="
	>=app-crypt/gcr-3.5.5
	>=app-text/iso-codes-0.35
	>=dev-libs/glib-2.31.2:2
	>=dev-libs/libxml2-2.6.12:2
	>=dev-libs/libxslt-1.1.7
	>=gnome-base/gnome-keyring-2.26.0
	>=gnome-base/gsettings-desktop-schemas-0.0.1
	>=net-dns/avahi-0.6.22
	>=net-libs/webkit-gtk-1.9.6:3[jit?,introspection?]
	>=net-libs/libsoup-gnome-2.39.6:2.4
	>=x11-libs/gtk+-3.5.2:3[introspection?]
	>=x11-libs/libnotify-0.5.1:=
	gnome-base/gnome-desktop:3=

	dev-db/sqlite:3
	x11-libs/libX11

	x11-themes/gnome-icon-theme
	x11-themes/gnome-icon-theme-symbolic

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	nss? ( dev-libs/nss )
"
# paxctl needed for bug #407085
# eautoreconf requires gnome-common-3.5.5
DEPEND="${RDEPEND}
	introspection? ( jit? ( >=gnome-base/gnome-common-3.5.5 ) )
	>=dev-util/gtk-doc-am-1
	>=dev-util/intltool-0.50
	sys-apps/paxctl
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	# Build-time segfaults under PaX with USE=introspection when building
	# against webkit-gtk[introspection,jit]
	if use introspection && use jit; then
		epatch "${FILESDIR}/${PN}-3.3.90-paxctl-introspection.patch"
		cp "${FILESDIR}/paxctl.sh" "${S}/" || die
		eautoreconf
	fi
	gnome2_src_prepare
}

src_configure() {
	DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README TODO"
	G2CONF="${G2CONF}
		--enable-shared
		--disable-static
		--with-distributor-name=Gentoo
		$(use_enable introspection)
		$(use_enable nss)
		$(use_enable test tests)"
	gnome2_src_configure
}

src_compile() {
	# needed to avoid "Command line `dbus-launch ...' exited with non-zero exit status 1"
	unset DISPLAY
	gnome2_src_compile
}

src_test() {
	# FIXME: this should be handled at eclass level
	"${EROOT}${GLIB_COMPILE_SCHEMAS}" --allow-any-name "${S}/data" || die

	use jit && pax-mark m $(list-paxables tests/test*) #415801
	GSETTINGS_SCHEMA_DIR="${S}/data" Xemake check
}

src_install() {
	gnome2_src_install
	use jit && pax-mark m "${ED}usr/bin/epiphany"
}
