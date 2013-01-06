# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lldpd/lldpd-0.5.6.ebuild,v 1.3 2012/10/08 00:59:54 flameeyes Exp $

EAPI=4

inherit eutils user

DESCRIPTION="Implementation of IEEE 802.1ab (LLDP)"
HOMEPAGE="http://github.com/vincentbernat/lldpd/wiki"
SRC_URI="http://media.luffy.cx/files/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="snmp xml"

DEPEND="snmp? ( net-analyzer/net-snmp[extensible(+)] )
		xml? ( dev-libs/libxml2 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	ebegin "Creating lldpd user and group"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
	eend $?
}

src_prepare() {
	epatch_user
}

src_configure() {
	econf \
		--with-privsep-user=${PN} \
		--with-privsep-group=${PN} \
		--with-privsep-chroot=/var/lib/${PN} \
		$(use_with snmp) \
		$(use_with xml)
}

src_install() {
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}"/${PN}-initd-1 ${PN}
	newconfd "${FILESDIR}"/${PN}-confd-1 ${PN}

	keepdir /var/lib/${PN}
}
