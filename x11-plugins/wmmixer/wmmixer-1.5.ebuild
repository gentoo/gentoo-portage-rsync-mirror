# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmixer/wmmixer-1.5.ebuild,v 1.1 2008/12/22 22:51:03 ssuominen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A mixer designed for WindowMaker"
HOMEPAGE="http://packages.qa.debian.org/w/wmmixer.html"
SRC_URI="mirror://debian/pool/main/w/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~mips ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-restore_pristine_code.patch \
		"${FILESDIR}"/${P}-respect_flags.patch
}

src_compile() {
	tc-export CXX
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc CHANGES home.wmmixer README
}
