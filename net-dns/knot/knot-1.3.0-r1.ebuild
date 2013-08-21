# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/knot/knot-1.3.0-r1.ebuild,v 1.1 2013/08/21 09:23:59 scarabeus Exp $

EAPI=5

inherit eutils autotools user

DESCRIPTION="High-performance authoritative-only DNS server"
HOMEPAGE="http://www.knot-dns.cz/"
SRC_URI="http://public.nic.cz/files/knot-dns/${P/_/-}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug caps +fastparser"

RDEPEND="
	dev-libs/openssl
	dev-libs/userspace-rcu
	caps? ( sys-libs/libcap-ng )
"
#	sys-libs/glibc
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/flex
	virtual/yacc
	fastparser? ( dev-util/ragel )
"

S="${WORKDIR}/${P/_/-}"

src_prepare() {
	sed -i \
		-e 's:-Werror::g' \
		configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--with-storage="${EPREFIX}/var/lib/${PN}" \
		--with-rundir="${EPREFIX}/var/run/${PN}" \
		--disable-lto \
		--enable-recvmmsg \
		$(use_enable fastparser) \
		$(use_enable debug debug server,zones,xfr,packet,dname,rr,ns,hash,compiler) \
		$(use_enable debug debuglevel details)
}

src_install() {
	default
	newinitd "${FILESDIR}/knot.init" knot
}

pkg_postinst() {
	enewgroup knot 53
	enewuser knot 53 -1 /var/lib/knot knot
}
