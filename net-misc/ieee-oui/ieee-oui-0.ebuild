# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ieee-oui/ieee-oui-0.ebuild,v 1.2 2013/04/12 02:37:55 zerochaos Exp $

EAPI=4

DESCRIPTION="Getter via cron for oui.txt from standards.ieee.org"
HOMEPAGE="http://standards.ieee.org/regauth/oui/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="sys-apps/util-linux
	 net-misc/wget
	 virtual/cron"

S="${WORKDIR}"

src_install() {
	keepdir /var/lib/misc
	exeinto /etc/cron.weekly
	newexe "${FILESDIR}"/${P}.sh ${PN}
	touch "${ED}"/var/lib/misc/oui.txt
}

pkg_postinst() {
	einfo "Launching cron.weekly/${PN} to get initial update ..."
	/etc/cron.weekly/${PN}
	if [ ! -e /var/lib/misc/oui.txt ]; then
		eerror "Could not download current copy of oui.txt from standards.ieee.org ;"
		eerror "Please re-emerge or manually run /etc/cron.weekly/${P} to update."
	fi
}
