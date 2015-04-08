# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/icoutils/icoutils-0.30.0.ebuild,v 1.5 2012/12/16 13:47:11 ago Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A set of programs for extracting and converting images in icon and cursor files (.ico, .cur)"
HOMEPAGE="http://www.nongnu.org/icoutils/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND=">=dev-lang/perl-5.6
	>=dev-perl/libwww-perl-5.64
	media-libs/libpng:0
	sys-libs/zlib
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.29.1-{locale,gettext}.patch
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" mkinstalldirs="mkdir -p" install
	dodoc AUTHORS ChangeLog NEWS README TODO
}
