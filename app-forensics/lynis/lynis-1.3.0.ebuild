# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/lynis/lynis-1.3.0.ebuild,v 1.4 2012/07/29 16:42:40 armin76 Exp $

EAPI="4"

DESCRIPTION="Security and system auditing tool"
HOMEPAGE="http://www.rootkit.nl/projects/lynis.html"
SRC_URI="http://www.rootkit.nl/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash"

src_install() {
	insinto /usr/share/${PN}
	doins -r db/ include/ plugins/ || die "failed to install lynis base files"

	dosbin lynis || die "dosbin failed"

	insinto /etc/${PN}
	doins default.prf || die "failed to install default.prf"

	doman lynis.8 || die "doman failed"
	dodoc CHANGELOG FAQ README dev/TODO

	# Remove the old one during the next stabilize progress
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/lynis.cron-new lynis || die "failed to install cron script"
}

pkg_postinst() {
	einfo
	einfo "A cron script has been installed to ${ROOT}etc/cron.daily/lynis."
	einfo
}
