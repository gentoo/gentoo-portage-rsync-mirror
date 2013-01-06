# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-2.32.0-r2.ebuild,v 1.9 2012/05/05 02:22:38 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome2 eutils autotools

DESCRIPTION="Utilities for the Gnome desktop"
HOMEPAGE="https://live.gnome.org/GnomeUtils"
SRC_URI="${SRC_URI} http://dev.gentoo.org/~pacho/gnome/${P}-icons.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="bonobo doc ipv6 test"

RDEPEND=">=dev-libs/glib-2.20:2
	>=x11-libs/gtk+-2.20:2
	>=gnome-base/libgtop-2.12
	>=gnome-base/gconf-2:2
	>=media-libs/libcanberra-0.4[gtk]
	x11-libs/libXext
	x11-libs/libX11
	bonobo? ( || ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 ) )"

DEPEND="${RDEPEND}
	x11-proto/xextproto
	app-text/gnome-doc-utils
	app-text/scrollkeeper
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.10 )
	dev-util/gtk-doc-am
	gnome-base/gnome-common"

pkg_setup() {
	if ! use debug; then
		G2CONF="${G2CONF} --enable-debug=minimum"
	fi

	G2CONF="${G2CONF}
		$(use_enable ipv6)
		$(use_enable bonobo gdict-applet)
		--disable-maintainer-flags
		--enable-zlib
		--disable-static
		--disable-schemas-install
		--disable-scrollkeeper"
	DOCS="AUTHORS ChangeLog NEWS README THANKS"
}

src_prepare() {
	# Fix uninitialized variable preventing crashes (already fixed in master)
	epatch "${FILESDIR}/${P}-fix-uninitialized.patch"

	# Provide updated icons
	epatch "${FILESDIR}/${P}-new-icons.patch"
	epatch "${FILESDIR}/${P}-new-icons2.patch"

	# Remove idiotic -D.*DISABLE_DEPRECATED cflags
	# This method is kinda prone to breakage. Recheck carefully with next bump.
	# bug 339074
	LC_ALL=C find . -iname 'Makefile.am' -exec \
		sed -e '/-D[A-Z_]*DISABLE_DEPRECATED/d' -i {} + || die "sed 1 failed"
	# Do Makefile.in after Makefile.am to avoid automake maintainer-mode
	LC_ALL=C find . -iname 'Makefile.in' -exec \
		sed -e '/-D[A-Z_]*DISABLE_DEPRECATED/d' -i {} + || die "sed 2 failed"

	if ! use test ; then
		sed -e 's/ tests//' -i logview/Makefile.{am,in} || die "sed 3 failed"
	fi

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed failed"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf

	gnome2_src_prepare
}
