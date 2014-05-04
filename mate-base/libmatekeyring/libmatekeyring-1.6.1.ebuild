# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-base/libmatekeyring/libmatekeyring-1.6.1.ebuild,v 1.2 2014/05/04 14:53:26 ago Exp $

EAPI="5"

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Compatibility library for accessing secrets for MATE"
HOMEPAGE="http://mate-desktop.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"

IUSE="debug test"

RDEPEND=">=dev-libs/glib-2.31:2
	>=dev-libs/libgcrypt-1.2.2:0=
	>=mate-base/mate-keyring-1.6:0[test?]
	>=sys-apps/dbus-1:0
	virtual/libintl:0"

DEPEND="${RDEPEND}
	sys-devel/gettext:*
	>=dev-util/intltool-0.35:*
	virtual/pkgconfig:*"

src_prepare() {
	# Remove silly CFLAGS
	sed 's:CFLAGS="$CFLAGS -Werror:CFLAGS="$CFLAGS:' \
		-i configure.ac || die "sed CFLAGS failed"

	# Remove DISABLE_DEPRECATED flags
	sed -e '/-D[A-Z_]*DISABLE_DEPRECATED/d' \
		-i configure.ac || die "sed DISABLE_DEPRECATED failed"

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		$(use_enable debug) \
		$(use_enable test tests)
}

DOCS="AUTHORS ChangeLog NEWS README"

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check
}
