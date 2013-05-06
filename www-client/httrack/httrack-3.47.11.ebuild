# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/httrack/httrack-3.47.11.ebuild,v 1.1 2013/05/06 15:23:46 sping Exp $

EAPI="4"

AT_M4DIR='m4'
inherit autotools eutils

DESCRIPTION="HTTrack Website Copier, Open Source Offline Browser"
HOMEPAGE="http://www.httrack.com/"
SRC_URI="http://download.httrack.com/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="static-libs"

RDEPEND=">=sys-libs/zlib-1.2.5.1-r1"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS README greetings.txt history.txt )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.44.1+zlib-1.2.5.1.patch
	epatch "${FILESDIR}"/${PN}-3.45.4-htmldir.patch
	epatch "${FILESDIR}"/${PN}-3.47.7-cflags.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static) \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html
}

src_install() {
	default
	find "${ED}" -type f -name '*.la' -delete || die
}
