# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/djbdns/djbdns-1.05-r27.ebuild,v 1.1 2013/06/23 18:53:24 pinkbyte Exp $

EAPI="2"
inherit eutils flag-o-matic toolchain-funcs user

DESCRIPTION="Excellent high-performance DNS services"
HOMEPAGE="http://cr.yp.to/djbdns.html"
IPV6_PATCH="test23"

SRC_URI="http://cr.yp.to/djbdns/${P}.tar.gz
	ipv6? ( http://www.fefe.de/dns/${P}-${IPV6_PATCH}.diff.bz2 )"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc ipv6 selinux static"

DEPEND=""
RDEPEND="${DEPEND}
	virtual/daemontools
	sys-apps/ucspi-tcp
	doc? ( app-doc/djbdns-man )
	selinux? ( sec-policy/selinux-djbdns )
"

src_prepare() {
	epatch \
		"${FILESDIR}/headtail.patch" \
		"${FILESDIR}/dnsroots.patch" \
		"${FILESDIR}/dnstracesort.patch" \
		"${FILESDIR}/string_length_255.patch"

	# Fix CVE2009-0858
	epatch "${FILESDIR}/CVE2009-0858_0001-check-response-domain-name-length.patch"

	if use ipv6; then
		elog "At present dnstrace does NOT support IPv6. It will"\
		     "be compiled without IPv6 support."
		cp -pR "${S}" "${S}-noipv6"
		# Careful -- >=test21 of the IPv6 patch includes the errno patch
		epatch "${DISTDIR}/${P}-${IPV6_PATCH}.diff.bz2"

		# Fix CVE2008-4392
		epatch \
			"${FILESDIR}/CVE2008-4392_0001-dnscache-merge-similar-outgoing-queries-ipv6.patch" \
			"${FILESDIR}/CVE2008-4392_0002-dnscache-cache-soa-records-ipv6.patch" \
			"${FILESDIR}/makefile-parallel.patch"

		cd "${S}-noipv6"
	fi

	# Fix CVE2008-4392
	epatch \
		"${FILESDIR}/CVE2008-4392_0001-dnscache-merge-similar-outgoing-queries.patch" \
		"${FILESDIR}/CVE2008-4392_0002-dnscache-cache-soa-records.patch"

	epatch "${FILESDIR}/${PV}-errno.patch"

	epatch_user
}

src_compile() {
	use static && append-ldflags -static
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo "/usr" > conf-home
	emake || die "emake failed"

	# If djbdns is compiled with IPv6 support, it breaks dnstrace.
	# Therefore we must compile dnstrace separately without IPv6
	# support.
	if use ipv6; then
		elog "Compiling dnstrace without ipv6 support"
		cd "${S}-noipv6"
		echo "$(tc-getCC) ${CFLAGS}" > conf-cc
		echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
		echo "/usr" > conf-home
		emake dnstrace || die "emake failed"
	fi
}

src_install() {
	insinto /etc
	doins dnsroots.global || die

	into /usr
	dobin *-conf dnscache tinydns walldns rbldns pickdns axfrdns \
		*-get *-data *-edit dnsip dnsipq dnsname dnstxt dnsmx \
		dnsfilter random-ip dnsqr dnsq dnstrace dnstracesort || die

	if use ipv6; then
		dobin dnsip6 dnsip6q "${S}-noipv6/dnstrace" || die
	fi

	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION || die

	dobin "${FILESDIR}/dnscache-setup" || die
	dobin "${FILESDIR}/tinydns-setup" || die
	dobin "${FILESDIR}/djbdns-setup" || die
}

pkg_preinst() {
	# The nofiles group is no longer provided by baselayout.
	# Share it with qmail if possible.
	enewgroup nofiles 200

	enewuser dnscache -1 -1 -1 nofiles
	enewuser dnslog -1 -1 -1 nofiles
	enewuser tinydns -1 -1 -1 nofiles
}

pkg_postinst() {
	elog "Use dnscache-setup & tinydns-setup or djbdns-setup to configure djbdns."
}
