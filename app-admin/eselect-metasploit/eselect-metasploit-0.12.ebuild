# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-metasploit/eselect-metasploit-0.12.ebuild,v 1.1 2014/04/25 05:17:48 zerochaos Exp $

EAPI=5

DESCRIPTION="eselect module for metasploit"
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="app-admin/eselect
	!<net-analyzer/metasploit-4.6"
RDEPEND="${DEPEND}"

S=${WORKDIR}

pkg_setup() {
	#please forgive me for what I have done, this is the only way to avoid
	#portage crying about collision with the symlink from the older version
	if [ -L "${EROOT}"/usr/bin/msfconsole ]; then
		unlink /usr/bin/msfconsole
	fi
}

src_install() {
	#force to use the outdated bundled version of metasm
	doenvd "${FILESDIR}"/91metasploit

	newinitd "${FILESDIR}"/msfrpcd.initd msfrpcd
	newconfd "${FILESDIR}"/msfrpcd.confd msfrpcd

	insinto /usr/share/eselect/modules
	newins "${FILESDIR}/metasploit.eselect-${PV}" metasploit.eselect

	newbin "${FILESDIR}"/msfconsole-${PV} msfconsole
}

pkg_postinst() {
	elog "To switch between installed slots, execute as root:"
	elog " # eselect metasploit set [slot number]"
}
