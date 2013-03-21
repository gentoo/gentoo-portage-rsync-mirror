# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-lite/shorewall-lite-4.5.11.2.ebuild,v 1.4 2013/03/21 15:10:11 jer Exp $

EAPI="4"

inherit versionator

# Select version (stable, RC, Beta):
MY_PV_TREE=$(get_version_component_range 1-2)   # for devel versions use "development/$(get_version_component_range 1-2)"
MY_PV_BASE=$(get_version_component_range 1-3)

MY_PN="${PN/-lite/}"
MY_P="${MY_PN}-${MY_PV_BASE}"
MY_P_DOCS="${MY_PN}-docs-html-${PV}"

DESCRIPTION="An iptables-based firewall whose config is handled by a normal Shorewall."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/${P}.tar.bz2
	doc? ( http://www1.shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/${MY_P_DOCS}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ppc ~ppc64 ~sparc x86"
IUSE="doc"

RDEPEND="net-firewall/iptables
	sys-apps/iproute2
	=net-firewall/shorewall-core-${PV}"

src_configure() {
	:;
}

src_compile() {
	:;
}

src_install() {
	keepdir /var/lib/shorewall-lite

	cd "${WORKDIR}/${P}"
	DESTDIR="${D}" ./install.sh "${FILESDIR}"/shorewallrc_new || die "install.sh failed"
	newinitd "${FILESDIR}/shorewall-lite" shorewall-lite

	dodoc changelog.txt releasenotes.txt
	if use doc; then
		cd "${WORKDIR}/${MY_P_DOCS}"
		dohtml -r *
	fi
}
