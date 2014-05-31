# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-power-manager/gnome-power-manager-2.32.0-r3.ebuild,v 1.8 2014/05/31 22:24:48 ssuominen Exp $

EAPI="4"
GNOME_TARBALL_SUFFIX="bz2"
GCONF_DEBUG="no"

inherit autotools eutils gnome2 virtualx

DESCRIPTION="A session daemon for GNOME that makes it easy to manage your laptop or desktop system"
HOMEPAGE="http://projects.gnome.org/gnome-power-manager/"
SRC_URI="${SRC_URI} http://dev.gentoo.org/~pacho/gnome/${PN}-2.32.0-keyboard-backlight.patch.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="+applet doc policykit test"

# FIXME: Interactive testsuite (upstream ? I'm so...pessimistic)
RESTRICT="test"

COMMON_DEPEND=">=dev-libs/glib-2.13.0:2
	>=x11-libs/gtk+-2.17.7:2
	>=gnome-base/gnome-keyring-0.6.0
	>=dev-libs/dbus-glib-0.71
	>=x11-libs/libnotify-0.4.3
	>=x11-libs/libwnck-2.10.0:1
	>=x11-libs/cairo-1
	>=gnome-base/gconf-2.10:2[policykit?]
	>=media-libs/libcanberra-0.10[gtk]
	|| ( <sys-power/upower-0.99 sys-power/upower-pm-utils )
	>=dev-libs/libunique-1.1:1
	>=x11-apps/xrandr-1.3
	>=x11-proto/xproto-7.0.15
	x11-libs/libX11
	x11-libs/libXext
	applet? (
		|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	)
"
RDEPEND="${COMMON_DEPEND}
	>=sys-auth/consolekit-0.4[policykit?]
	policykit? ( gnome-extra/polkit-gnome )"
DEPEND="${COMMON_DEPEND}
	x11-proto/randrproto

	sys-devel/gettext
	app-text/scrollkeeper
	app-text/docbook-xml-dtd:4.3
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	>=app-text/gnome-doc-utils-0.3.2
	doc? (
		app-text/xmlto
		app-text/docbook-sgml-utils
		app-text/docbook-xml-dtd:4.4
		app-text/docbook-sgml-dtd:4.1
		app-text/docbook-xml-dtd:4.1.2 )"

# docbook-sgml-utils and docbook-sgml-dtd-4.1 used for creating man pages
# (files under ${S}/man).
# docbook-xml-dtd-4.4 and -4.1.2 are used by the xml files under ${S}/docs.

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable applet applets)
		$(use_enable doc docbook-docs)
		$(use_enable policykit gconf-defaults)
		$(use_enable test tests)
		--enable-compile-warnings=minimum"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed libtoolize failed"

	# Drop debugger CFLAGS from configure
	sed -e 's:^CPPFLAGS="$CPPFLAGS -g"$::g' \
		-i configure.ac configure || die "debugger sed failed"

	# glibc splits this out, whereas other libc's do not tend to
	if use elibc_glibc; then
		sed -e 's/-lresolv//' \
			-i configure.ac configure || die "resolv sed failed"
	fi

	# Fixed bgo#644143, how to convert from percentage to discrete and vice-versa.
	epatch "${FILESDIR}/${P}-convert-percentage.patch"

	# Don't try to close a non-opened fd
	epatch "${FILESDIR}/${P}-close-fd.patch"

	# Do not use g-p-m in XFCE
	epatch "${FILESDIR}/${PN}-2.32.0-no-xfce.patch"

	# Don't crash on systems which don't have XBACKLIGHT
	epatch "${FILESDIR}/${PN}-2.32.0-xbacklight-crash.patch"

	# Add keyboard backlight support including dimming on idle and keyboard control
	epatch "${WORKDIR}/${PN}-2.32.0-keyboard-backlight.patch"

	# Fix duplicated battery, upstream bug #636915
	epatch "${FILESDIR}/${PN}-2.32.0-duplicated-battery.patch"

	# FIXME: This is required to prevent maintainer mode after "debugger sed"
	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf

	gnome2_src_prepare

	# This needs to be after eautoreconf to prevent problems like bug #356277
	if ! use doc; then
		# Remove the docbook2man rules here since it's not handled by a proper
		# parameter in configure.in.
		sed -e 's:@HAVE_DOCBOOK2MAN_TRUE@.*::' -i man/Makefile.in \
			|| die "docbook sed failed"
	fi
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	dbus-launch Xemake check || die "Test phase failed"
}
