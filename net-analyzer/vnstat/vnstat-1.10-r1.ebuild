# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/vnstat/vnstat-1.10-r1.ebuild,v 1.2 2012/06/12 03:36:17 zmedico Exp $

EAPI="2"

inherit toolchain-funcs user

DESCRIPTION="Console-based network traffic monitor that keeps statistics of network usage"
HOMEPAGE="http://humdi.net/vnstat/"
SRC_URI="http://humdi.net/vnstat/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ppc64 sparc x86"
IUSE="gd"

DEPEND="
	gd? ( media-libs/gd[png] )"
RDEPEND="${DEPEND}
	virtual/cron"

pkg_setup() {
	enewgroup vnstat
	enewuser vnstat -1 -1 /dev/null vnstat
}

src_compile() {
	sed -i 's:vnstat[.]log:vnstatd.log:' cfg/vnstat.conf || die
	sed -i 's:vnstat[.]pid:vnstatd/vnstatd.pid:' cfg/vnstat.conf || die

	if use gd; then
		emake all CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake all failed"
	else
		emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
	fi
}

src_install() {
	if use gd; then
		dobin src/vnstati || die "vnstati dobin failed"
	fi
	dobin src/vnstat src/vnstatd || die "dobin failed"
	exeinto /etc/cron.hourly
	newexe "${FILESDIR}"/vnstat.cron vnstat || die

	insinto /etc
	doins cfg/vnstat.conf || die
	fowners root:vnstat /etc/vnstat.conf

	newconfd "${FILESDIR}/vnstatd.confd" vnstatd || die
	newinitd "${FILESDIR}/vnstatd.initd" vnstatd || die

	keepdir /var/lib/vnstat
	keepdir /var/run/vnstatd
	fowners vnstat:vnstat /var/lib/vnstat
	fowners vnstat:vnstat /var/run/vnstatd

	use gd && { doman man/vnstati.1 || die; }
	doman man/vnstat.1 man/vnstatd.1 || die

	newdoc examples/vnstat_ip-up ip-up.example || die
	newdoc examples/vnstat_ip-down ip-down.example || die
	newdoc INSTALL README.setup || die
	dodoc CHANGES README UPGRADE FAQ examples/vnstat.cgi || die
}

pkg_postinst() {
	# compatibility for 1.1 ebuild
	if [[ -d ${ROOT}/var/spool/vnstat ]]; then
		mv -f "${ROOT}"/var/spool/vnstat/* "${ROOT}"/var/lib/vnstat/ \
			&& rmdir "${ROOT}"/var/spool/vnstat
		ewarn "vnStat db files have been moved from /var/spool/vnstat to /var/lib/vnstat"
		ewarn
	fi

	# Workaround feature/bug #141619
	chown -R vnstat:vnstat "${ROOT}/var/lib/vnstat"
	chown vnstat:vnstat "${ROOT}/var/run/vnstatd"
	ewarn "vnStat db files owning user and group has been changed to \"vnstat\"."

	elog
	elog "Repeat the following command for every interface you"
	elog "wish to monitor (replace eth0):"
	elog "   vnstat -u -i eth0"
	elog "and set correct permissions after that, e.g."
	elog "   chown -R vnstat:vnstat /var/lib/vnstat"
	elog
	elog "Note: if an interface transfers more than ~4GB in"
	elog "the time between cron runs, you may miss traffic"
	elog

	if [[ -e ${ROOT}/etc/cron.d/vnstat ]] ; then
		elog "vnstat's cron script is now installed as /etc/cron.hourly/vnstat."
		elog "Please remove /etc/cron.d/vnstat."
		elog
	fi
	elog "To update the interfaces database automatically with cron, uncomment"
	elog "lines in /etc/cron.hourly/vnstat and set cron job to run it as"
	elog "frequently as required. Alternatively you can use vnstatd. Init script"
	elog "was installed into /etc/init.d/vnstatd for your convenience."
	elog
	elog "Starting with version 1.5 --dbdir option is droped. You can do the same"
	elog "with DatabaseDir directive in configuration file (/etc/vnstat.conf)."
}
