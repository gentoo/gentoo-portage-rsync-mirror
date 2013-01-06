# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnome-keyring/libgnome-keyring-2.32.0.ebuild,v 1.17 2012/12/17 04:46:05 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome2 eutils autotools

DESCRIPTION="Compatibility library for accessing secrets"
HOMEPAGE="http://live.gnome.org/GnomeKeyring"

LICENSE="LGPL-2+ GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~sparc-solaris"
IUSE="debug test"

RDEPEND=">=sys-apps/dbus-1.0
	>=gnome-base/gnome-keyring-2.29[test?]
	!<gnome-base/gnome-keyring-2.29"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable debug)
		$(use_enable test tests)"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	# Remove unneeded test file.
	epatch "${FILESDIR}/${P}-drop-test.patch"

	# Don't run tests if a testing enabled gnome-keyring-daemon is not enabled.
	epatch "${FILESDIR}/${P}-run-test.patch"

	# Don't let tests to hang, bug #356141
	epatch "${FILESDIR}/${PN}-2.32.0-hang-tests.patch"

	# Remove silly CFLAGS
	sed 's:CFLAGS="$CFLAGS -Werror:CFLAGS="$CFLAGS:' \
		-i configure.in configure || die "sed failed"

	# Remove DISABLE_DEPRECATED flags
	sed -e '/-D[A-Z_]*DISABLE_DEPRECATED/d' \
		-i configure.in configure || die "sed 2 failed"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
	gnome2_src_prepare
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check
}
