# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-4.5.6.2.ebuild,v 1.1 2012/08/15 17:50:32 constanze Exp $

EAPI="4"

inherit eutils versionator

# Select version (stable, RC, Beta):
MY_PV_TREE=$(get_version_component_range 1-2)   # for devel versions use "development/$(get_version_component_range 1-2)"
MY_PV_BASE=$(get_version_component_range 1-3)

MY_P="${PN}-${MY_PV_BASE}"
MY_P_DOCS="${P/${PN}/${PN}-docs-html}"

DESCRIPTION="Shoreline Firewall is an iptables-based firewall for Linux."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/${PN}/${MY_PV_TREE}/${MY_P}/${P}.tar.bz2
	doc? ( http://www1.shorewall.net/pub/${PN}/${MY_PV_TREE}/${MY_P}/${MY_P_DOCS}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=net-firewall/iptables-1.2.4
	sys-apps/iproute2[-minimal]
	dev-lang/perl
	=net-firewall/shorewall-core-${PV}"
RDEPEND="${DEPEND}"

src_configure() {
	:;
}

src_compile() {
	:;
}

src_install() {
	keepdir /var/lib/shorewall

	cd "${WORKDIR}/${P}"
	DESTDIR="${D}" ./install.sh "${FILESDIR}"/shorewallrc || die "install.sh failed"
	newinitd "${FILESDIR}"/shorewall.initd shorewall

	dodoc changelog.txt releasenotes.txt
	if use doc; then
		dodoc -r Samples
		cd "${WORKDIR}/${MY_P_DOCS}"
		dohtml -r *
	fi
	dodir /var/lock/subsys
}

pkg_postinst() {
	elog "It is advised to copy the /usr/share/shorewall/configfiles dir to your"
	elog "own 'export directories'. However, whenever you upgrade Shorewall you"
	elog "should check for changes in configfiles and manually update your exports."
	elog "Alternatively, if you only have one Shorewall-Lite system in your network"
	elog "then you can use the configfiles dir but set CONFIG_PROTECT appropriately"
	elog "in /etc/make.conf (man make.conf)."
}
