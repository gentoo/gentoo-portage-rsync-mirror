# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-base/mate-keyring/mate-keyring-1.6.1.ebuild,v 1.3 2014/05/04 14:53:55 ago Exp $

EAPI="5"

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit autotools gnome2 pam virtualx versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Password and keyring managing daemon for MATE"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64"

IUSE="debug +gpg-agent pam +ssh-agent test"

RDEPEND=">=dev-libs/glib-2.25:2
	>=x11-libs/gtk+-2.20:2
	>=sys-apps/dbus-1:0
	>=dev-libs/libgcrypt-1.2.2:0=
	>=dev-libs/libtasn1-0.3.4:0=
	sys-libs/libcap:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/pango:0
	virtual/libintl:0
	pam? ( virtual/pam:0 )"

DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.35:*
	sys-devel/gettext:*
	virtual/pkgconfig:*"

PDEPEND=">=mate-base/libmatekeyring-1.6:0"

# Fails in several ways, should work in next cycle (bug #340283), revisit then.
RESTRICT="test"

src_prepare() {
	sed -e 's/DOC_MODULE=gck/DOC_MODULE=mate-gck/' \
		-i docs/reference/gck/Makefile.am || die

	eautoreconf

	gnome2_src_prepare

	# Remove error related CFLAGS.
	sed 's:CFLAGS="$CFLAGS -Werror:CFLAGS="$CFLAGS:' \
		-i configure.ac configure || die "sed CFLAGS failed"

	# Remove DISABLE_DEPRECATED flags.
	sed -e '/-D[A-Z_]*DISABLE_DEPRECATED/d' \
		-i configure.ac configure || die "sed DISABLE_DEPRECATED failed"
}

src_configure() {
	gnome2_src_configure \
		$(use_enable debug) \
		$(use_enable test tests) \
		$(use_enable gpg-agent) \
		$(use_enable pam) \
		$(use_enable ssh-agent) \
		$(use_with pam pam-dir $(getpam_mod_dir)) \
		--with-root-certs="${EPREFIX}"/usr/share/ca-certificates/ \
		--with-gtk=2.0
}

src_compile() {
	# Temporary parallel build fix.
	emake -j1
}

DOCS="AUTHORS ChangeLog NEWS README"

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check || die "emake check failed!"
}
