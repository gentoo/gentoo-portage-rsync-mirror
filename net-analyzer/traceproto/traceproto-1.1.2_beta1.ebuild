# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceproto/traceproto-1.1.2_beta1.ebuild,v 1.3 2008/10/09 20:40:58 flameeyes Exp $

inherit eutils autotools

MY_PV=${PV/_/}

DESCRIPTION="A traceroute-like utility that sends packets based on protocol"
HOMEPAGE="http://traceproto.sourceforge.net/"
SRC_URI="mirror://gentoo/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug ncurses"

RDEPEND=">=net-libs/libnet-1.1.0
	net-libs/libpcap
	ncurses? ( sys-libs/ncurses )
	debug? ( dev-libs/dmalloc )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}.patch
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable debug dmalloc) \
		$(use_enable ncurses) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
