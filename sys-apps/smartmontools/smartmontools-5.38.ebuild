# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/smartmontools/smartmontools-5.38.ebuild,v 1.9 2010/12/17 15:33:07 flameeyes Exp $

inherit flag-o-matic

DESCRIPTION="Self-Monitoring, Analysis and Reporting Technology System (S.M.A.R.T.) monitoring tools"
HOMEPAGE="http://smartmontools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc sparc x86 ~x86-fbsd"
IUSE="static minimal"

RDEPEND=""
DEPEND=""

src_compile() {
	use minimal && einfo "Skipping the monitoring daemon for minimal build."
	use static && append-ldflags -static
	econf || die
	emake || die
}

src_install() {
	dosbin smartctl || die "dosbin smartctl"
	dodoc AUTHORS CHANGELOG NEWS README TODO WARNINGS
	doman smartctl.8
	if ! use minimal; then
	dosbin smartd || die "dosbin smartd"
		doman smartd*.[58]
		newdoc smartd.conf smartd.conf.example
		docinto examplescripts
		dodoc examplescripts/*
		rm -f "${D}"/usr/share/doc/${PF}/examplescripts/Makefile*

		insinto /etc
		doins smartd.conf

		newinitd "${FILESDIR}"/smartd.rc smartd
		newconfd "${FILESDIR}"/smartd.confd smartd
	fi
}

pkg_postinst() {
	if ! use minimal; then
		elog "You need the 'mail' command if you configured smartd to send reports"
		elog "via email, 'emerge virtual/mailx' to get a mailer"
	fi
}
