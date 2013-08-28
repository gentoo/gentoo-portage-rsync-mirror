# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall6-lite/shorewall6-lite-4.5.19.ebuild,v 1.1 2013/08/28 17:02:21 constanze Exp $

EAPI="5"

inherit eutils linux-info prefix systemd versionator

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
MY_P_DOCS=shorewall-docs-html-${MY_PV}

MY_MAJORMINOR=$(get_version_component_range 1-2)

DESCRIPTION="An iptables-based firewall whose config is handled by a normal Shorewall6."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="
	http://www.shorewall.net/pub/shorewall/${MY_URL_PREFIX}${MY_MAJORMINOR}/shorewall-${MY_PV}/${MY_P}.tar.bz2
	doc? ( http://www.shorewall.net/pub/shorewall/${MY_URL_PREFIX}${MY_MAJORMINOR}/shorewall-${MY_PV}/${MY_P_DOCS}.tar.bz2 )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND="=net-firewall/shorewall-core-${PV}"
RDEPEND="
	${DEPEND}
	>=net-firewall/iptables-1.4.20[ipv6]
	sys-apps/iproute2[-minimal]
	dev-perl/Socket6
"

S=${WORKDIR}/${MY_P}

pkg_pretend() {
	local CONFIG_CHECK="~NF_CONNTRACK ~NF_CONNTRACK_IPV6"

	local ERROR_CONNTRACK="${PN} requires NF_CONNTRACK support."

	local ERROR_CONNTRACK_IPV6="${PN} requires NF_CONNTRACK_IPV6 support."

	check_extra_config
}

src_prepare() {
	cp "${FILESDIR}"/${PV}/shorewallrc "${S}"/shorewallrc.gentoo || die "Copying shorewallrc_new failed"
	eprefixify "${S}"/shorewallrc.gentoo

	cp "${FILESDIR}"/${PV}/${PN}.confd "${S}"/default.gentoo || die "Copying shorewall.confd failed"
	cp "${FILESDIR}"/${PV}/${PN}.initd "${S}"/init.gentoo.sh || die "Copying shorewall.initd failed"

	epatch_user
}

src_configure() {
	:;
}

src_compile() {
	:;
}

src_install() {
	keepdir /var/lib/${PN}

	DESTDIR="${D}" ./install.sh shorewallrc.gentoo || die "install.sh failed"
	systemd_newunit "${FILESDIR}"/${PV}/shorewall6-lite.systemd ${PN}.service

	# Currently, install.sh from upstream is broken and will always
	# default.debian so have to do it on our own:
	newconfd "${FILESDIR}"/${PV}/${PN}.confd ${PN}

	dodoc changelog.txt releasenotes.txt
	if use doc; then
		cd "${WORKDIR}/${MY_P_DOCS}"
		dohtml -r *
	fi
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		# This is a new installation
		elog "Before you can use ${PN}, you need to provide a configuration, which you can"
		elog "create using ${CATEGORY}/shorewall6 (the full version, including the compiler)."
		elog ""
		elog "To activate ${PN} on system start, please add ${PN} to your default runlevel:"
		elog ""
		elog "  # rc-update add ${PN} default"
	fi
}
