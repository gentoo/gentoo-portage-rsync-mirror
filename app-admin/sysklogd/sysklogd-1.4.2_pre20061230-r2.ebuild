# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysklogd/sysklogd-1.4.2_pre20061230-r2.ebuild,v 1.6 2011/04/07 07:51:22 ultrabug Exp $

inherit eutils flag-o-matic toolchain-funcs

CVS_DATE=${PV#*_pre}
MY_P=${PN}-1.4.1

DESCRIPTION="Standard log daemons"
HOMEPAGE="http://www.infodrom.org/projects/sysklogd/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-cvs-${CVS_DATE}.patch.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""
RESTRICT="test"

DEPEND=""
RDEPEND="dev-lang/perl
	sys-apps/debianutils"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}"/${MY_P}-cvs-${CVS_DATE}.patch

	epatch "${FILESDIR}"/${MY_P}-accept.patch
	epatch "${FILESDIR}"/${MY_P}-querymod.patch
	epatch "${FILESDIR}"/${MY_P}-punt-SO_BSDCOMPAT.patch
	epatch "${FILESDIR}"/${MY_P}-ksym-headers.patch

	# CAEN/OWL security patches
	epatch "${FILESDIR}"/${MY_P}-caen-owl-syslogd-bind.diff
	epatch "${FILESDIR}"/${MY_P}-caen-owl-syslogd-drop-root.diff
	epatch "${FILESDIR}"/${MY_P}-caen-owl-klogd-drop-root.diff

	append-lfs-flags
	sed -i \
		-e "s:-O3:${CFLAGS} ${CPPFLAGS}:" \
		Makefile || die "sed CFLAGS"
}

src_compile() {
	tc-export CC
	emake CC="${CC}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dosbin syslogd klogd "${FILESDIR}"/syslogd-listfiles || die "dosbin"
	doman *.[1-9] "${FILESDIR}"/syslogd-listfiles.8
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/syslog-cron syslog.cron
	dodoc ANNOUNCE CHANGES MANIFEST NEWS README.1st README.linux
	dodoc "${FILESDIR}"/syslog.conf
	insinto /etc
	doins "${FILESDIR}"/syslog.conf
	newinitd "${FILESDIR}"/sysklogd.rc6 sysklogd
	newconfd "${FILESDIR}"/sysklogd.confd sysklogd
}
