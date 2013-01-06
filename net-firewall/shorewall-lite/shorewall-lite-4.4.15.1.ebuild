# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-lite/shorewall-lite-4.4.15.1.ebuild,v 1.7 2011/03/21 17:05:29 xarthisius Exp $

inherit versionator

# Select version (stable, RC, Beta):
MY_PV_TREE=$(get_version_component_range 1-2)   # for devel versions use "development/$(get_version_component_range 1-2)"
MY_P_BETA=""                                    # stable or experimental (eg. "-RC1" or "-Beta4")
MY_PV_BASE=$(get_version_component_range 1-3)

MY_PN="${PN/-lite/}"
MY_P="${MY_PN}-${MY_PV_BASE}${MY_P_BETA}"
MY_P_DOCS="${MY_PN}-docs-html-${PV}${MY_P_BETA}"

DESCRIPTION="An iptables-based firewall whose config is handled by a normal Shorewall."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/${P}${MY_P_BETA}.tar.bz2
	doc? ( http://www1.shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/${MY_P_DOCS}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE="doc"

DEPEND="net-firewall/iptables
	sys-apps/iproute2"
RDEPEND="${DEPEND}"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	keepdir /var/lib/shorewall-lite

	cd "${WORKDIR}/${P}${MY_P_BETA}"
	PREFIX="${D}" ./install.sh || die "install.sh failed"
	newinitd "${FILESDIR}/shorewall-lite" shorewall-lite

	dodoc changelog.txt releasenotes.txt
}

pkg_postinst() {
	einfo
	einfo "Documentation is available at http://www.shorewall.net"
	einfo "There are man pages for shorewall-lite(8) and for each"
	einfo "configuration file."
	einfo
	einfo "You should have already generated a firewall script with"
	einfo "'shorewall compile' on the administrative Shorewall."
	einfo "Please refer to"
	einfo "http://www.shorewall.net/CompiledPrograms.html"
	einfo
	einfo "If you intend to use the 2.6 IPSEC Support, you must retrieve the"
	einfo "kernel patches from http://shorewall.net/pub/shorewall/contrib/IPSEC/"
	einfo "or install kernel 2.6.16+ as well as a recent Netfilter iptables"
	einfo "and compile it with support for policy match."
	einfo
	einfo "Note that /etc/shorewall-lite/shorewall.conf has been renamed"
	einfo "to /etc/shorewall-lite/shorewall-lite.conf"
	einfo
	einfo "Known problems:"
	einfo "http://shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/known_problems.txt"
}
