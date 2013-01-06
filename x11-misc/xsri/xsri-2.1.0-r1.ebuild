# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsri/xsri-2.1.0-r1.ebuild,v 1.11 2012/05/05 04:53:50 jdhore Exp $

EAPI=2
inherit autotools rpm

DESCRIPTION="The xsri wallpaper setter from RedHat"
HOMEPAGE="http://fedora.redhat.com/"
SRC_URI="mirror://fedora/5/source/SRPMS/${P}-9.2.1.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i -e '/-DG.*_DISABLE_DEPRECATED/d' Makefile.am || die
	sed -e 's/PKG_CHECK_MODULES(GTK,/& x11 /' \
		-i configure.in || die #367663
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README || die
}
