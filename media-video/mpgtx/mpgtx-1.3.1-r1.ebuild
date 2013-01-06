# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpgtx/mpgtx-1.3.1-r1.ebuild,v 1.6 2010/01/14 21:08:10 maekke Exp $

inherit eutils toolchain-funcs

DESCRIPTION="mpgtx a command line MPEG audio/video/system file toolbox"
SRC_URI="mirror://sourceforge/mpgtx/${P}.tar.gz"
HOMEPAGE="http://mpgtx.sourceforge.net/"

KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND=""
RDEPEND=""

src_unpack () {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-configure.patch"
	epatch "${FILESDIR}/${P}-dont-ignore-cxx-flags.patch"
}

src_compile() {
	tc-export CXX
	./configure --parachute --prefix=/usr

	emake || die "emake failed"
}

src_install() {
	dobin mpgtx

	dosym mpgtx /usr/bin/mpgjoin
	dosym mpgtx /usr/bin/mpgsplit
	dosym mpgtx /usr/bin/mpgcat
	dosym mpgtx /usr/bin/mpginfo
	dosym mpgtx /usr/bin/mpgdemux
	dosym mpgtx /usr/bin/tagmp3

	doman man/mpgtx.1 man/tagmp3.1

	dosym /usr/share/man/man1/mpgtx.1 /usr/share/man/man1/mpgcat.1
	dosym /usr/share/man/man1/mpgtx.1 /usr/share/man/man1/mpgjoin.1
	dosym /usr/share/man/man1/mpgtx.1 /usr/share/man/man1/mpginfo.1
	dosym /usr/share/man/man1/mpgtx.1 /usr/share/man/man1/mpgsplit.1
	dosym /usr/share/man/man1/mpgtx.1 /usr/share/man/man1/mpgdemux.1

	dodoc AUTHORS ChangeLog README TODO
}
