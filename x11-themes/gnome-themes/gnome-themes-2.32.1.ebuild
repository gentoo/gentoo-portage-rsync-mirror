# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes/gnome-themes-2.32.1.ebuild,v 1.8 2012/05/05 04:10:05 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A set of GNOME themes, with sets for users with limited or low vision"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="accessibility"

RDEPEND=">=x11-libs/gtk+-2:2
	>=x11-themes/gtk-engines-2.15.3:2"
DEPEND="${RDEPEND}
	>=x11-misc/icon-naming-utils-0.8.7
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	sys-devel/gettext"
# For problems related with dev-perl/XML-LibXML please see bug 266136

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable accessibility all-themes)
		--disable-test-themes
		--enable-icon-mapping"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	gnome2_src_prepare

	# Fix bashisms, bug #256337
	epatch "${FILESDIR}/${PN}-2.24.3-bashism.patch"

	# Do not build/install accessibility themes, bug #274515
	if ! use accessibility; then
		sed 's:HighContrast.*\\:\\:g' -i \
			desktop-themes/Makefile.am desktop-themes/Makefile.in \
			gtk-themes/Makefile.am gtk-themes/Makefile.in \
			icon-themes/Makefile.am icon-themes/Makefile.in \
			|| die "sed failed"
	fi

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "intltool rules fix failed"
}
