# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/djbdns/djbdns-1.05-r28.ebuild,v 1.2 2013/08/14 11:30:23 patrick Exp $

EAPI=5
inherit eutils flag-o-matic readme.gentoo toolchain-funcs user

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
RDEPEND="
	virtual/daemontools
	sys-apps/ucspi-tcp
	doc? ( app-doc/djbdns-man )
	selinux? ( sec-policy/selinux-djbdns )"

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
	emake

	# If djbdns is compiled with IPv6 support, it breaks dnstrace.
	# Therefore we must compile dnstrace separately without IPv6
	# support.
	if use ipv6; then
		elog "Compiling dnstrace without ipv6 support"
		cd "${S}-noipv6"
		echo "$(tc-getCC) ${CFLAGS}" > conf-cc
		echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
		echo "/usr" > conf-home
		emake dnstrace
	fi
}

src_install() {
	insinto /etc
	doins dnsroots.global

	into /usr
	dobin *-conf dnscache tinydns walldns rbldns pickdns axfrdns \
		*-get *-data *-edit dnsip dnsipq dnsname dnstxt dnsmx \
		dnsfilter random-ip dnsqr dnsq dnstrace dnstracesort

	if use ipv6; then
		dobin dnsip6 dnsip6q "${S}-noipv6/dnstrace"
	fi

	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
	readme.gentoo_create_doc
}

pkg_preinst() {
	# The nofiles group is no longer provided by baselayout.
	# Share it with qmail if possible.
	enewgroup nofiles 200

	enewuser dnscache -1 -1 -1 nofiles
	enewuser dnslog -1 -1 -1 nofiles
	enewuser tinydns -1 -1 -1 nofiles
}

DISABLE_AUTOFORMATTING=1
FORCE_PRINT_ELOG=1 #remove next bump
DOC_CONTENTS='
The dnscache-setup, tinydns-setup, and djbdns-setup programs have
been removed to follow upstream more closely. To configure djbdns,
please follow the instructions at,

	http://cr.yp.to/djbdns.html

Of particular interest are,

	axfrdns : http://cr.yp.to/djbdns/axfrdns-conf.html
	dnscache: http://cr.yp.to/djbdns/run-cache-x-home.html
	tinydns : http://cr.yp.to/djbdns/run-server.html

Portage has created users for axfrdns, dnscache, and tinydns; the
commands to configure these programs are,

	1. axfrdns-conf tinydns dnslog /var/axfrdns /var/tinydns $ip
	2. dnscache-conf dnscache dnslog /var/dnscache $ip
	3. tinydns-conf tinydns dnslog /var/tinydns $ip

(replace \$ip with the ip address on which the server will run).

If you wish to configure rbldns or walldns, you will need to create
those users yourself (although you should still use the "dnslog"
user for the logs):

	4. rbldns-conf $username dnslog /var/rbldns $ip $base
	5. walldns-conf $username dnslog /var/walldns $ip
'
