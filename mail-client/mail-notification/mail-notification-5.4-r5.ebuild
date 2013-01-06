# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mail-notification/mail-notification-5.4-r5.ebuild,v 1.4 2012/05/21 23:35:20 vapier Exp $

EAPI="3"

inherit gnome2 multilib flag-o-matic toolchain-funcs eutils

DESCRIPTION="A GNOME trayicon which checks for email, with support for many online and offline mailbox formats."
HOMEPAGE="http://www.nongnu.org/mailnotify/"
SRC_URI="http://savannah.nongnu.org/download/mailnotify/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-linux"
SLOT="0"
LICENSE="GPL-3"
IUSE="evo gmail imap ipv6 maildir mbox mh mozilla pop sasl ssl sylpheed"

# gmime is actually optional, but it's used by so much of the package
# it's pointless making it optional. gnome-keyring is required for
# several specific access methods, and thus linked to those USE flags
# instead of adding a keyring USE flag.
RDEPEND=">=x11-libs/gtk+-2.12:2
	>=dev-libs/glib-2.14
	>=gnome-base/gconf-2.4.0
	>=gnome-base/gconf-2.6
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/libglade-2.0
	dev-libs/dbus-glib
	dev-libs/gmime:2.4
	>=x11-libs/libnotify-0.4.1
	pop? ( gnome-base/gnome-keyring )
	imap? ( gnome-base/gnome-keyring )
	gmail? ( gnome-base/gnome-keyring )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )
	evo? ( >=mail-client/evolution-2.24 )
	sylpheed? ( mail-client/sylpheed )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	virtual/pkgconfig
	>=dev-util/intltool-0.35.0"

# this now uses JB (the Jean-Yves Lefort's Build System) as a build system
# instead of autotools, this is a little helper function that basically does
# the same thing as use_enable
use_var() {
	echo "${2:-$1}=$(usex $1)"
}

src_prepare() {
	epatch "${FILESDIR}/${P}-dont-update-cache.patch"

	# We are not Ubuntu, and I suspect that this is the cause of #215281
	epatch "${FILESDIR}/${P}-remove-ubuntu-special-case.patch"

	# Make it work ok with eds-2.24 and 2.29
	epatch "${FILESDIR}/${P}-e-d-s.patch"

	# Fix gtkhtml depend to solve building against evo-2.28, see bug #293374
	epatch "${FILESDIR}/${P}-evolution-gtkhtml.patch"

	# Add patch for new cyrus-sasl's ABI, see:
	# https://bugzilla.redhat.com/501456
	epatch "${FILESDIR}/${P}-sasl_encode64.patch"

	# Fedora patch to build against dev-libs/gmime:2.4
	epatch "${FILESDIR}/${P}-gmime.patch"

	# Fix forced --as-needed, bug 317905
	epatch "${FILESDIR}/${P}-asneeded.patch"

	# Fix icons for gnome 2.30+
	epatch "${FILESDIR}/${P}-icons.patch"

	epatch "${FILESDIR}/${P}-fix-markup.patch"
}

src_configure() {
	set -- \
	./jb configure destdir="${D}" prefix="${EPREFIX}/usr" libdir="${EPREFIX}/usr/$(get_libdir)" \
		sysconfdir="${EPREFIX}/etc" localstatedir="${EPREFIX}/var" cc="$(tc-getCC)" \
		cflags="${CFLAGS}" cppflags="${CXXFLAGS}" ldflags="${LDFLAGS}" \
		scrollkeeper-dir="${EPREFIX}/var/lib/scrollkeeper" \
		$(use_var evo evolution) \
		$(use_var gmail) \
		$(use_var imap) \
		$(use_var ipv6) \
		$(use_var maildir) \
		$(use_var mbox) \
		$(use_var mh) \
		$(use_var mozilla) \
		$(use_var pop pop3) \
		$(use_var sasl) \
		$(use_var ssl) \
		$(use_var sylpheed)
	echo "$@"
	"$@" || die
}

src_compile() {
	./jb build || die
}

src_install() {
	GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1" ./jb install || die

	dodoc NEWS README AUTHORS TODO TRANSLATING

	rm -rf "${ED}/var/lib/scrollkeeper"
}
