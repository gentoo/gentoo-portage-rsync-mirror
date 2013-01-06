# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpwatch/arpwatch-2.1.15-r6.ebuild,v 1.9 2012/06/12 02:22:05 zmedico Exp $

EAPI="2"
inherit eutils user versionator

PATCH_VER="0.5"

MY_P="${PN}-$(replace_version_separator 2 'a')"
DESCRIPTION="An ethernet monitor program that keeps track of ethernet/ip address pairings"
HOMEPAGE="http://ee.lbl.gov/"
SRC_URI="ftp://ftp.ee.lbl.gov/${MY_P}.tar.gz
	mirror://gentoo/arpwatch-patchset-${PATCH_VER}.tbz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86 ~x86-fbsd"
IUSE="selinux"

DEPEND="net-libs/libpcap
	sys-libs/ncurses"

RDEPEND="${DEPEND}
		selinux? ( sec-policy/selinux-arpwatch )"

S=${WORKDIR}/${MY_P}

pkg_preinst() {
	enewuser arpwatch
}

src_prepare() {
	EPATCH_SOURCE="${WORKDIR}"/arpwatch-patchset/
	EPATCH_SUFFIX="patch"
	epatch
	cp "${WORKDIR}"/arpwatch-patchset/*.8 . || die "Failed to get man-pages from arpwatch-patchset."
}

src_install () {
	dosbin arpwatch arpsnmp arp2ethers massagevendor arpfetch bihourly.sh || die
	doman arpwatch.8 arpsnmp.8 arp2ethers.8 massagevendor.8 arpfetch.8 bihourly.8 || die

	insinto /usr/share/arpwatch
	doins ethercodes.dat || die

	insinto /usr/share/arpwatch/awk
	doins duplicates.awk euppertolower.awk p.awk e.awk d.awk || die

	keepdir /var/lib/arpwatch
	dodoc README CHANGES || die

	newinitd "${FILESDIR}"/arpwatch.initd arpwatch || die
	newconfd "${FILESDIR}"/arpwatch.confd arpwatch || die
}

pkg_postinst() {
	# Workaround bug #141619 put this in src_install when bug'll be fixed.
	chown arpwatch:0 "${ROOT}var/lib/arpwatch"

	elog "For security reasons arpwatch by default runs as an unprivileged user."
	elog
	elog "Note: some scripts require snmpwalk utility from net-analyzer/net-snmp"
}
