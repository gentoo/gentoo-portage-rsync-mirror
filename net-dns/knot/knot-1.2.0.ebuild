# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/knot/knot-1.2.0.ebuild,v 1.1 2013/04/03 17:34:46 scarabeus Exp $

EAPI=5

inherit eutils autotools

DESCRIPTION="High-performance authoritative-only DNS server"
HOMEPAGE="http://www.knot-dns.cz/"
SRC_URI="http://public.nic.cz/files/knot-dns/${P/_/-}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	dev-libs/openssl
	dev-libs/userspace-rcu
"
#	sys-libs/glibc
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/flex
	virtual/yacc
"

S="${WORKDIR}/${P/_/-}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-move-pidfile-to-var.patch
	sed -i \
		-e 's:-Werror::g' \
		configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}/etc/${PN}" \
		--libexecdir="${EPREFIX}/usr/libexec/${PN}" \
		--disable-lto \
		--enable-recvmmsg \
		$(use_enable debug debug server,zones,xfr,packet,dname,rr,ns,hash,compiler) \
		$(use_enable debug debuglevel details)
}

src_install() {
	default

	newinitd "${FILESDIR}/knot.init" knot-dns
}

pkg_postinst() {
	if [[ -n ${REPLACING_VERSIONS} ]] ; then
		elog "Remember to recompile all zones after update. Run:"
		elog "    # knotc stop"
		elog "    # knotc compile"
		elog "    # knotc start"
	fi
}
