# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/dxcc/dxcc-20080225.ebuild,v 1.3 2010/10/22 14:41:07 fauli Exp $

inherit eutils

DESCRIPTION="A ham radio callsign DXCC lookup utility"
HOMEPAGE="http://fkurz.net/ham/dxcc.html"
SRC_URI="http://fkurz.net/ham/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="tk"

RDEPEND="dev-lang/perl
	tk? ( dev-perl/perl-tk )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/Makefile.patch"
}

src_install() {
	emake DESTDIR="${D}/usr" install || die "emake failed"
	dodoc README ChangeLog || die "dodoc failed"
}
