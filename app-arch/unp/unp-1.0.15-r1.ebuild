# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unp/unp-1.0.15-r1.ebuild,v 1.4 2009/08/27 12:46:37 fauli Exp $

inherit eutils

DESCRIPTION="Script for unpacking various file formats"
HOMEPAGE="http://packages.qa.debian.org/u/unp.html"
SRC_URI="mirror://debian/pool/main/u/unp/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-lzma-7z.patch
}

src_install() {
	dobin ucat unp || die "dobin failed"
	doman debian/unp.1 || die "doman failed"
}
