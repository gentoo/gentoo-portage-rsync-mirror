# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-core/shorewall-core-4.5.19.ebuild,v 1.1 2013/08/28 16:19:04 constanze Exp $

EAPI="5"

inherit eutils prefix versionator

MY_URL_PREFIX=
case ${P} in
	*_beta* | \
	*_rc*)
		MY_URL_PREFIX='development/'
		;;
esac

MY_PV=${PV/_rc/-RC}
MY_PV=${MY_PV/_beta/-Beta}
MY_P=${PN}-${MY_PV}

MY_MAJORMINOR=$(get_version_component_range 1-2)

DESCRIPTION="Core libraries of shorewall / shorewall(6)-lite"
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www.shorewall.net/pub/shorewall/${MY_URL_PREFIX}${MY_MAJORMINOR}/shorewall-${MY_PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="selinux"

DEPEND="
	>=dev-lang/perl-5.10
	virtual/perl-Digest-SHA
	!<net-firewall/shorewall-4.5.0.1
	selinux? ( sec-policy/selinux-shorewall )
"
RDEPEND="
	${DEPEND}
	>=net-firewall/iptables-1.4.20
	sys-apps/iproute2[-minimal]
	sys-devel/bc
	sys-apps/coreutils
"

DOCS=( changelog.txt releasenotes.txt )

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	cp "${FILESDIR}"/${PV}/shorewallrc "${S}"/shorewallrc.gentoo || die "Copying shorewallrc_new failed"
	eprefixify "${S}"/shorewallrc.gentoo

	epatch_user
}

src_configure() {
	:;
}

src_install() {
	DESTDIR="${D}" ./install.sh shorewallrc.gentoo || die "install.sh failed"
	default
}
