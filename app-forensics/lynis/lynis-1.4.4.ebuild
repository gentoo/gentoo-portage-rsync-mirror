# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/lynis/lynis-1.4.4.ebuild,v 1.1 2014/03/07 23:09:02 idl0r Exp $

EAPI="5"

DESCRIPTION="Security and system auditing tool"
HOMEPAGE="http://www.rootkit.nl/projects/lynis.html"
SRC_URI="http://cisofy.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash"

src_install() {
	insinto /usr/share/${PN}
	doins -r db/ include/ plugins/ || die "failed to install lynis base files"

	insopts -m0640
	doins -r include/
	insopts -m0644

	dosbin lynis

	insinto /etc/${PN}
	doins default.prf

	doman lynis.8
	dodoc CHANGELOG FAQ README dev/TODO

	# Remove the old one during the next stabilize progress
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/lynis.cron-new lynis
}

pkg_postinst() {
	einfo
	einfo "A cron script has been installed to ${ROOT}etc/cron.daily/lynis."
	einfo
}
