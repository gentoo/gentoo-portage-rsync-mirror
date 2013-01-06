# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall6/shorewall6-4.4.15.1.ebuild,v 1.7 2011/03/21 17:08:41 xarthisius Exp $

inherit versionator linux-info

# Select version (stable, RC, Beta, upstream patched):
MY_PV_TREE=$(get_version_component_range 1-2)	# for devel versions use "development/$(get_version_component_range 1-2)"
MY_P_BETA=""      				# stable or experimental (eg. "-RC1" or "-Beta4")
MY_PV_BASE=$(get_version_component_range 1-3)	# which shorewall-common to use

MY_PN="${PN/6/}"
MY_P="${MY_PN}-${MY_PV_BASE}${MY_P_BETA}"

DESCRIPTION="Shoreline Firewall with IPv6 support."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/${P}${MY_P_BETA}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 ~sparc x86"

IUSE="doc"

DEPEND=">=net-firewall/iptables-1.4.0
	sys-apps/iproute2
	>=net-firewall/shorewall-${MY_PV_BASE}
	dev-perl/Socket6"
RDEPEND="${DEPEND}"

pkg_setup() {
	if kernel_is lt 2 6 25 ; then
		die "${PN} requires at least kernel 2.6.25."
	fi
}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	keepdir /var/lib/${PN}

	cd "${WORKDIR}/${P}${MY_P_BETA}"
	PREFIX="${D}" ./install.sh || die "install.sh failed"

	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die "doinitd failed"

	dodoc releasenotes.txt
	if use doc; then
		cp -pR Samples6 "${D}/usr/share/doc/${PF}"
	fi
}

pkg_postinst() {
	einfo
	einfo "Documentation is available at http://www.shorewall.net"
	einfo "There are man pages for ${PN}(8)."
	use doc && einfo "Sample configuration files are in /usr/share/doc/${PF}."
	einfo
	elog "If you wish to include DNS names in your IPv6 configuration files,"
	elog "you must have Perl 5.10 and must emerge dev-perl/Socket6."
	einfo
	einfo "Please read the included release notes for more information."
	einfo
	einfo "Known problems:"
	einfo "http://www.shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/known_problems.txt"
	einfo
}
