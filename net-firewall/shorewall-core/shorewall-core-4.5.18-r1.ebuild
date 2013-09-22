# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-core/shorewall-core-4.5.18-r1.ebuild,v 1.1 2013/09/22 13:14:41 constanze Exp $

EAPI="5"

inherit eutils prefix versionator

# Select version (stable, RC, Beta):
MY_PV_TREE=$(get_version_component_range 1-2)   # for devel versions use "development/$(get_version_component_range 1-2)"
MY_PV_BASE=$(get_version_component_range 1-3)

MY_P="shorewall-${MY_PV_BASE}"

DESCRIPTION="Core libraries of shorewall / shorewall(6)-lite"
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/shorewall/${MY_PV_TREE}/${MY_P}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="selinux"

DEPEND=">=net-firewall/iptables-1.2.4
	sys-apps/iproute2[-minimal]
	dev-lang/perl
	dev-perl/Digest-SHA1
	!<net-firewall/shorewall-4.5.0.1
	selinux? ( sec-policy/selinux-shorewall )"
RDEPEND="${DEPEND}"

DOCS=( changelog.txt releasenotes.txt )

src_prepare() {
	cp "${FILESDIR}"/${PVR}/shorewallrc_new "${S}"/shorewallrc.gentoo || die "Copying shorewallrc_new failed"
	eprefixify "${S}"/shorewallrc.gentoo
}

src_configure() {
	:;
}

src_install() {
	DESTDIR="${D}" ./install.sh shorewallrc.gentoo || die "install.sh failed"
	default
}
