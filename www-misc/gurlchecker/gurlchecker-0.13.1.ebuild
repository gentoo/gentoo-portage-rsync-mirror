# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/gurlchecker/gurlchecker-0.13.1.ebuild,v 1.4 2012/08/20 22:57:24 johu Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="Gnome tool that checks links on web pages/sites"
HOMEPAGE="http://gurlchecker.labs.libre-entreprise.org/"
SRC_URI="http://labs.libre-entreprise.org/frs/download.php/857/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
SLOT="0"
IUSE="clamav doc gnutls tidy"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2:2.0
	>=dev-libs/libxml2-2.6:2
	>=net-libs/gnet-2
	>=dev-libs/libcroco-0.6
	tidy? ( app-text/htmltidy )
	clamav? ( app-antivirus/clamav )
	gnutls? ( >=net-libs/gnutls-1 )"

# docbook-sgml-utils used to build the man page
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.30
	app-text/docbook-sgml-utils
	dev-util/gtk-doc-am
	doc? ( >dev-util/gtk-doc-1.1 )"

DOCS="AUTHORS CONTRIBUTORS ChangeLog FAQ NEWS README THANKS TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-croco
		$(use_with tidy)
		$(use_with clamav)
		$(use_with gnutls)"
}

src_prepare() {
	gnome2_src_prepare

	# The file index.sgml should be distributed with the sources, but
	# it is not, causing problems. See bug #92784.
	touch "${S}"/doc/html/index.sgml

	# Fix bad yes/no detection
	#epatch "${FILESDIR}/${PN}-0.10.2-configure.in.patch"

	# Fix tidy.h include dir for Gentoo:
	epatch "${FILESDIR}/${PN}-0.10.5-autoconf-tidy.patch"

	# Fix gnutls detection, bug #273980
	#epatch "${FILESDIR}/${PN}-0.10.5-gnutls28.patch"

	# Fix intltool test failure
	echo "src/cookies.c" >> po/POTFILES.in

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}
