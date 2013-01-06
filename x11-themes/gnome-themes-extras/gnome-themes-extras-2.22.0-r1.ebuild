# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes-extras/gnome-themes-extras-2.22.0-r1.ebuild,v 1.9 2012/05/05 04:10:07 jdhore Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit autotools eutils gnome2

DESCRIPTION="Additional themes for GNOME"
HOMEPAGE="http://librsvg.sourceforge.net/theme.php"

LICENSE="LGPL-2.1 GPL-2 DSL"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=x11-themes/gtk-engines-2.14:2
	>=x11-misc/icon-naming-utils-0.8.1
	gnome-base/librsvg"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.23"

DOCS="AUTHORS ChangeLog MAINTAINERS"

src_prepare() {
	# Fix tooltips references, bug #238138
	epatch "${FILESDIR}/${P}-darklooks.patch"

	# Respect LINGUAS, bug #182086
	intltoolize --force || die "intloolize failed"
	eautoreconf
	gnome2_src_prepare
}
