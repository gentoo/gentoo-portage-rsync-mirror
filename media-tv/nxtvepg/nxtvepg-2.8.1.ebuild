# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nxtvepg/nxtvepg-2.8.1.ebuild,v 1.3 2010/06/24 18:54:54 fauli Exp $

inherit eutils toolchain-funcs

DESCRIPTION="receive and browse free TV programme listings via bttv for tv networks in Europe"
HOMEPAGE="http://nxtvepg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="X unicode"

RDEPEND="X? ( >=dev-lang/tcl-8.5
	>=dev-lang/tk-8.5
	x11-libs/libX11
	x11-libs/libXmu )"
DEPEND="${RDEPEND}
	sys-apps/sed
	sys-kernel/linux-headers
	X? ( x11-proto/xproto )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/nxtvepg-db.patch" || die "db patch failed"
	epatch "${FILESDIR}/nxtvepg-daemon-install.patch" || die "daemon patch failed"
	epatch "${FILESDIR}/nxtvepg-tcl8.5.patch" || die "tcl-8.5 patch failed"
	use unicode && epatch "${FILESDIR}/nxtvepg-unicode.patch"
}

src_compile() {
	if use X; then
		emake -j1 CC=$(tc-getCC) prefix="/usr" mandir="/usr/share/man/man1"|| die "emake failed"
	else
		emake -j1 CC=$(tc-getCC) prefix="/usr" mandir="/usr/share/man/man1" daemon || die "emake failed"
	fi
}

src_install() {
	if use X; then
		emake ROOT="${D}" prefix="/usr" mandir="${D}/usr/share/man/man1" install || die "emake install failed"
	else
		emake ROOT="${D}" prefix="/usr" mandir="${D}/usr/share/man/man1" install-daemon || die "emake install failed"
	fi
	dodoc README CHANGES TODO
	dohtml manual*.html
}
