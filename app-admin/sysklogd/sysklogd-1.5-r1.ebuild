# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysklogd/sysklogd-1.5-r1.ebuild,v 1.2 2011/04/07 07:51:22 ultrabug Exp $

inherit eutils flag-o-matic toolchain-funcs

DEB_VER="6"
DESCRIPTION="Standard log daemons"
HOMEPAGE="http://www.infodrom.org/projects/sysklogd/"
SRC_URI="http://www.infodrom.org/projects/sysklogd/download/${P}.tar.gz
	mirror://debian/pool/main/s/sysklogd/${PN}_${PV}-${DEB_VER}.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
RESTRICT="test"

DEPEND=""
RDEPEND="dev-lang/perl
	sys-apps/debianutils"

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/${PN}_${PV}-${DEB_VER}.diff
	cd "${S}"
	epatch "${FILESDIR}"/${P}-debian-cron.patch
	epatch "${FILESDIR}"/${P}-build.patch

	# CAEN/OWL security patches
	epatch "${FILESDIR}"/${PN}-1.4.2-caen-owl-syslogd-bind.diff
	epatch "${FILESDIR}"/${PN}-1.4.2-caen-owl-syslogd-drop-root.diff
	epatch "${FILESDIR}"/${PN}-1.4.2-caen-owl-klogd-drop-root.diff

	epatch "${FILESDIR}"/${P}-syslog-func-collision.patch #342601

	append-lfs-flags
}

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	dosbin syslogd klogd debian/syslog-facility debian/syslogd-listfiles || die "dosbin"
	doman *.[1-9] debian/syslogd-listfiles.8
	insinto /etc
	doins debian/syslog.conf || die
	exeinto /etc/cron.daily
	newexe debian/cron.daily syslog || die
	exeinto /etc/cron.weekly
	newexe debian/cron.weekly syslog || die
	dodoc ANNOUNCE CHANGES NEWS README.1st README.linux
	newinitd "${FILESDIR}"/sysklogd.rc6 sysklogd
	newconfd "${FILESDIR}"/sysklogd.confd sysklogd
}
