# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-keyring/gnome-keyring-2.32.1-r1.ebuild,v 1.10 2012/12/17 04:45:41 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit autotools eutils gnome2 multilib pam virtualx

DESCRIPTION="Password and keyring managing daemon"
HOMEPAGE="http://live.gnome.org/GnomeKeyring"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="debug pam test"
# USE=valgrind is probably not a good idea for the tree

RDEPEND=">=dev-libs/glib-2.25:2
	>=x11-libs/gtk+-2.20:2
	gnome-base/gconf:2
	>=sys-apps/dbus-1.0
	pam? ( virtual/pam )
	>=dev-libs/libgcrypt-1.2.2
	>=dev-libs/libtasn1-1"
#	valgrind? ( dev-util/valgrind )"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig"
PDEPEND="gnome-base/libgnome-keyring"

# tests fail in several ways, they should be fixed in the next cycle (bug #340283),
# revisit then.
RESTRICT="test"

src_prepare() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		$(use_enable debug)
		$(use_enable test tests)
		$(use_enable pam)
		$(use_with pam pam-dir $(getpam_mod_dir))
		--with-root-certs=${EPREFIX}/usr/share/ca-certificates/
		--enable-acl-prompts
		--enable-ssh-agent
		--enable-gpg-agent
		--with-gtk=2.0"
#		$(use_enable valgrind)

	epatch "${FILESDIR}/${P}-glib-2.32.patch"
	eautoreconf

	gnome2_src_prepare

	# Remove silly CFLAGS
	sed 's:CFLAGS="$CFLAGS -Werror:CFLAGS="$CFLAGS:' \
		-i configure.in configure || die "sed failed"

	# Remove DISABLE_DEPRECATED flags
	sed -e '/-D[A-Z_]*DISABLE_DEPRECATED/d' \
		-i configure.in configure || die "sed 2 failed"

	# Fix undefined type in egg-asn1x.c
	epatch "${FILESDIR}/${PN}-2.32.1-fix-undefined.patch"
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check || die "emake check failed!"
}
