# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/havp/havp-0.92a.ebuild,v 1.5 2013/01/10 15:19:06 ago Exp $

EAPI=4
inherit eutils user

DESCRIPTION="HTTP AntiVirus Proxy"
HOMEPAGE="http://www.server-side.de/"
SRC_URI="http://www.server-side.de/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="clamav ssl"

DEPEND="clamav? ( app-antivirus/clamav )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /etc/${PN} ${PN}
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.92a-run.patch
}

src_configure() {
	econf \
		$(use_enable clamav) \
		$(use_enable ssl ssl-tunnel) \
		--localstatedir=/var
}

src_install() {
	exeinto /usr/sbin
	doexe ${PN}/${PN}

	newinitd "${FILESDIR}/${PN}.initd" ${PN}

	insinto /etc
	rm -r etc/${PN}/${PN}.config.in
	doins -r etc/${PN}

	dodoc ChangeLog
}

pkg_postinst() {
	ewarn "/var/tmp/${PN} must be on a filesystem with mandatory locks!"
	ewarn "You should add  \"mand\" to the mount options on the relevant line in /etc/fstab."

	if use ssl; then
		echo
		ewarn "Note: ssl USE flag only enable SSL pass-through, which means that"
		ewarn "      HTTPS pages will not be scanned for viruses!"
		ewarn "      It is impossible to decrypt data sent through SSL connections without knowing"
		ewarn "      the private key of the used certificate."
	fi

	if use clamav; then
		echo
		ewarn "If you plan to use clamav daemon, you should make sure clamav user can read"
		ewarn "/var/tmp/${PN} content. This can be accomplished by enabling AllowSupplementaryGroups"
		ewarn "in /etc/clamd.conf and adding clamav user to the ${PN} group."
	fi
}
