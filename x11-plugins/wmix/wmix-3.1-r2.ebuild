# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmix/wmix-3.1-r2.ebuild,v 1.1 2010/02/23 11:01:31 s4t4n Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Dockapp mixer for OSS or ALSA"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
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
	epatch "${FILESDIR}"/fix-wmix-3.1-version-number.patch
	epatch "${FILESDIR}"/wmix-fix-free.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" || die "emake failed."
}

src_install() {
	dobin ${PN}
	doman "${FILESDIR}"/${PN}.1
	dodoc AUTHORS BUGS NEWS README sample.wmixrc
}
