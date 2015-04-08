# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gbdfed/gbdfed-1.5.ebuild,v 1.2 2010/02/11 15:38:55 ulm Exp $

EAPI=2
inherit eutils

DESCRIPTION="gbdfed Bitmap Font Editor"
HOMEPAGE="http://www.math.nmsu.edu/~mleisher/Software/gbdfed/"
SRC_URI="http://www.math.nmsu.edu/~mleisher/Software/gbdfed/${P}.tbz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=media-libs/freetype-2
	x11-libs/libX11
	x11-libs/pango"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4-glibc-2.10.patch
	sed "s:-D.*_DISABLE_DEPRECATED::" -i Makefile.in #248562
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS || die
}
