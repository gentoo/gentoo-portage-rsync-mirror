# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/sshuttle/sshuttle-0.61-r1.ebuild,v 1.1 2014/01/22 07:09:26 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit python linux-info

DESCRIPTION="Transparent proxy server that works as a poor man's VPN using ssh"
HOMEPAGE="https://github.com/apenwarr/sshuttle/"
SRC_URI="http://dev.gentoo.org/~radhermit/dist/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/xz-utils"
RDEPEND="net-firewall/iptables"

CONFIG_CHECK="~NETFILTER_XT_TARGET_HL ~IP_NF_TARGET_REDIRECT ~NF_NAT"

pkg_setup() {
	linux-info_pkg_setup
	python_pkg_setup
}

src_compile() { :; }

src_install() {
	rm stresstest.py || die
	insinto "$(python_get_sitedir)"/${PN}
	doins -r *.py compat

	exeinto "$(python_get_sitedir)"/${PN}
	doexe ${PN}
	dosym "$(python_get_sitedir)"/${PN}/${PN} /usr/bin/${PN}

	dodoc README.md
	doman Documentation/${PN}.8
}
