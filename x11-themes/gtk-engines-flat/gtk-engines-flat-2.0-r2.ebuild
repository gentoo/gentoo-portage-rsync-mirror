# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-flat/gtk-engines-flat-2.0-r2.ebuild,v 1.16 2012/05/05 04:10:07 jdhore Exp $

EAPI=3
inherit autotools

MY_P=gtk-flat-theme-${PV}

DESCRIPTION="GTK+ Flat Theme Engine"
HOMEPAGE="http://themes.freshmeat.net/projects/gtk2flat"
SRC_URI="http://download.freshmeat.net/themes/gtk2flat/gtk2flat-default.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	eautoreconf # need new libtool for interix
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README
	rm -f "${ED}"/usr/share/themes/Flat/{ICON.png,README.html}
}
