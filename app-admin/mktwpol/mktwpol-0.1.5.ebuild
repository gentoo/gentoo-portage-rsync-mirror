# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mktwpol/mktwpol-0.1.5.ebuild,v 1.1 2013/09/16 22:23:41 nimiux Exp $

EAPI=5

DESCRIPTION="Bash scripts to create and maintain tripwire database"
HOMEPAGE="https://sourceforge.net/projects/mktwpol"
SRC_URI="mirror://sourceforge/mktwpol/${P}.tar.gz"

LICENSE="CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="app-admin/tripwire"

src_install() {

	dosbin mktwpol.sh twsetup.sh
	fperms 750 /usr/sbin/mktwpol.sh /usr/sbin/twsetup.sh

	local d
	for d in README* ChangeLog AUTHORS NEWS TODO CHANGES THANKS BUGS \
		 FAQ CREDITS CHANGELOG ; do
		[[ -s "${d}" ]] && dodoc "${d}"
	done
}

pkg_postinst() {
	elog
	elog "Installation and setup of tripwire ..."
	elog " - Run: \`twsetup.sh\`"
	elog
	elog "Maintenance of tripwire as packages are added and/or deleted ..."
	elog " - Run: \`mktwpol.sh -u\` to update tripwire policy"
	elog
}
