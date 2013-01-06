# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-dwerg/gtk-engines-dwerg-0.8.ebuild,v 1.14 2012/05/05 04:10:05 jdhore Exp $

EAPI=3

inherit autotools

DESCRIPTION="GTK+2 Dwerg Theme Engine"
SRC_URI="http://download.freshmeat.net/themes/dwerg/dwerg-default-${PV}.tar.gz"
HOMEPAGE="http://themes.freshmeat.net/projects/dwerg/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	eautoreconf # required for interix
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
