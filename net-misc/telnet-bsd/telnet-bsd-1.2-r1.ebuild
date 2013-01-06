# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/telnet-bsd/telnet-bsd-1.2-r1.ebuild,v 1.20 2012/07/26 20:18:01 ryao Exp $

inherit eutils autotools

DESCRIPTION="Telnet and telnetd ported from OpenBSD with IPv6 support"
HOMEPAGE="ftp://ftp.suse.com/pub/people/kukuk/ipv6/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/ipv6/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos"
IUSE="nls xinetd"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	!net-misc/netkit-telnetd
	xinetd? ( sys-apps/xinetd )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fbsd.patch

	eautoreconf
}

src_compile() {
	# FreeBSD doesn't seem to support PIE neither does hppa
	if use kernel_FreeBSD || use hppa; then
		export libc_cv_fpie="no"
	fi

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}"/telnetd.xinetd telnetd
	fi

	dodoc README THANKS NEWS AUTHORS ChangeLog INSTALL
}
