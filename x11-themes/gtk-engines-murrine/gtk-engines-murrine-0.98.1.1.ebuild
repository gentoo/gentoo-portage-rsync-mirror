# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-murrine/gtk-engines-murrine-0.98.1.1.ebuild,v 1.6 2012/06/03 03:11:11 xmw Exp $

EAPI="4"
GNOME_ORG_MODULE="murrine"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome.org

DESCRIPTION="Murrine GTK+2 Cairo Engine"

HOMEPAGE="http://www.cimitan.com/murrine/"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE="+themes animation-rtl"

RDEPEND=">=x11-libs/gtk+-2.18:2
	x11-libs/cairo
	x11-libs/pixman"
PDEPEND="themes? ( x11-themes/murrine-themes )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.37.1
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS TODO"

src_configure() {
	econf --enable-animation \
		--enable-rgba \
		$(use_enable animation-rtl animationrtl)
}

src_install() {
	default
	# Remove useless .la files
	find "${D}" -name '*.la' -exec rm -f {} + || die
}
