# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/maradns/maradns-2.0.06.ebuild,v 1.4 2013/02/14 14:47:43 mgorny Exp $

EAPI="4"
inherit eutils toolchain-funcs flag-o-matic systemd user

DEADWOOD_VER="3.2.02"

DESCRIPTION="A security-aware DNS server"
HOMEPAGE="http://www.maradns.org/"
SRC_URI="http://www.maradns.org/download/${PV%.*}/${PV}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~mips"
IUSE="authonly ipv6"

DEPEND=""
RDEPEND=""

src_prepare() {
	local myflags

	# Apply some minor patches from Debian.
	epatch "${FILESDIR}"/${P}-askmara-tcp.patch
	epatch "${FILESDIR}"/${P}-duende-man.patch

	# And one from Gentoo
	epatch "${FILESDIR}"/${P}-build.patch
}

src_configure() {
	local myconf

	# Use duende-ng.c.
	cp  "${S}/tools/duende-ng.c" "${S}/tools/duende.c"

	tc-export CC

	use ipv6 && myconf="${myconf} --ipv6"
	./configure ${myconf} || die "Failed to configure ${PN}."
}

src_install() {
	# Install the MaraDNS binaries.
	dosbin server/maradns
	dosbin tcp/zoneserver
	dobin tcp/getzone tcp/fetchzone
	dobin tools/askmara tools/askmara-tcp tools/duende
	dobin tools/bind2csv2.py tools/csv1tocsv2.pl

	# MaraDNS docs, manpages, misc.
	dodoc doc/en/{QuickStart,README,*.txt}
	dodoc doc/en/text/*.txt
	doman doc/en/man/*.[1-9]
	dodoc maradns.gpg.key
	dohtml doc/en/*.html
	dohtml -r doc/en/webpage
	dohtml -r doc/en/tutorial
	docinto examples
	dodoc doc/en/examples/example_*

	# Deadwood binary, docs, manpages, etc.
	if ! use authonly; then
		dosbin deadwood-${DEADWOOD_VER}/src/Deadwood
		doman deadwood-${DEADWOOD_VER}/doc/{Deadwood,Duende}.1
		docinto deadwood
		dodoc deadwood-${DEADWOOD_VER}/doc/{Deadwood,Duende,FAQ}.txt
		dohtml deadwood-${DEADWOOD_VER}/doc/{Deadwood,FAQ}.html
		docinto deadwood/internals
		dodoc deadwood-${DEADWOOD_VER}/doc/internals/*
		insinto /etc/maradns
		newins deadwood-${DEADWOOD_VER}/doc/dwood3rc-all dwood3rc_all.dist
	fi

	# Example configurations.
	insinto /etc/maradns
	newins doc/en/examples/example_full_mararc mararc_full.dist
	newins doc/en/examples/example_csv2 example_csv2.dist
	keepdir /etc/maradns/logger

	# Init scripts.
	newinitd "${FILESDIR}"/maradns2 maradns
	newinitd "${FILESDIR}"/zoneserver2 zoneserver
	if ! use authonly; then
		newinitd "${FILESDIR}"/deadwood deadwood
	fi

	# systemd unit
	# please keep paths in sync!
	sed -e "s^@bindir@^${EPREFIX}/usr/sbin^" \
		-e "s^@sysconfdir@^${EPREFIX}/etc/maradns^" \
		"${FILESDIR}"/maradns.service.in > "${T}"/maradns.service
	systemd_dounit "${T}"/maradns.service
}

pkg_postinst() {
	enewgroup maradns 99
	enewuser duende 66 -1 -1 maradns
	enewuser maradns 99 -1 -1 maradns
}
