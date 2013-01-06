# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/miniupnpd/miniupnpd-1.7.ebuild,v 1.1 2012/06/03 16:26:12 gurligebis Exp $

EAPI=2
inherit eutils toolchain-funcs

MY_PV=1.7
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="MiniUPnP IGD Daemon"
SRC_URI="http://miniupnp.free.fr/files/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://miniupnp.free.fr/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-firewall/iptables-1.4.6"
DEPEND="${RDEPEND}
	sys-apps/util-linux
	sys-apps/lsb-release"

src_prepare() {
	mv Makefile.linux Makefile
	sed -i \
		-e "s#^CFLAGS = .*-D#CPPFLAGS += -I/usr/include -D#" \
		-e '/^CFLAGS :=/s/CFLAGS/CPPFLAGS/g' \
		-e "s/CFLAGS += -ansi/#CFLAGS += -ansi/g" \
		-e "s/LIBS = -liptc/LIBS = -lip4tc/g" \
		-e 's/genuuid||//' \
		Makefile || die
	sed -i \
		-e 's/\(strncpy(\([->a-z.]\+\), "[a-zA-Z]\+", \)IPT_FUNCTION_MAXNAMELEN);/\1sizeof(\2));/' \
		netfilter/iptcrdr.c || die

	emake config.h

	sed -i \
		-e 's/\/\*#define ENABLE_LEASEFILE\*\//#define ENABLE_LEASEFILE/g' \
		config.h || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	einstall PREFIX="${D}" STRIP="true" || die "einstall failed"

	newinitd "${FILESDIR}"/${PN}-init.d ${PN}
	newconfd "${FILESDIR}"/${PN}-conf.d ${PN}
}

pkg_postinst() {
	elog "Please correct the external interface in the top of the two"
	elog "scripts in /etc/miniupnpd and edit the config file in there too"
}
