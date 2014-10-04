# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysklogd/sysklogd-1.5-r4.ebuild,v 1.1 2014/10/04 09:21:57 polynomial-c Exp $

EAPI="4"

inherit eutils flag-o-matic toolchain-funcs

DEB_VER="6"
DESCRIPTION="Standard log daemons"
HOMEPAGE="http://www.infodrom.org/projects/sysklogd/"
SRC_URI="http://www.infodrom.org/projects/sysklogd/download/${P}.tar.gz
	mirror://debian/pool/main/s/sysklogd/${PN}_${PV}-${DEB_VER}.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="logrotate"
RESTRICT="test"

DEPEND=""
RDEPEND="dev-lang/perl
	sys-apps/debianutils"

src_prepare() {
	pushd "${WORKDIR}" >/dev/null
	epatch "${WORKDIR}"/${PN}_${PV}-${DEB_VER}.diff
	popd >/dev/null

	epatch "${FILESDIR}"/${P}-debian-cron.patch
	epatch "${FILESDIR}"/${P}-build.patch

	# CAEN/OWL security patches
	epatch "${FILESDIR}"/${PN}-1.4.2-caen-owl-syslogd-bind.diff
	epatch "${FILESDIR}"/${PN}-1.4.2-caen-owl-syslogd-drop-root.diff
	epatch "${FILESDIR}"/${PN}-1.4.2-caen-owl-klogd-drop-root.diff

	epatch "${FILESDIR}"/${P}-syslog-func-collision.patch #342601
	epatch "${FILESDIR}"/${P}_CVE-2014-3634.diff #524058
}

src_configure() {
	append-lfs-flags
	tc-export CC
}

src_install() {
	dosbin syslogd klogd debian/syslog-facility debian/syslogd-listfiles
	doman *.[1-9] debian/syslogd-listfiles.8
	insinto /etc
	doins debian/syslog.conf
	if use logrotate ; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}"/sysklogd.logrotate sysklogd
	else
		exeinto /etc/cron.daily
		newexe debian/cron.daily syslog
		exeinto /etc/cron.weekly
		newexe debian/cron.weekly syslog
	fi
	dodoc ANNOUNCE CHANGES NEWS README.1st README.linux
	newinitd "${FILESDIR}"/sysklogd.rc7 sysklogd
	newconfd "${FILESDIR}"/sysklogd.confd sysklogd
}
