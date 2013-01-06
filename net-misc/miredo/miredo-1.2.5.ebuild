# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/miredo/miredo-1.2.5.ebuild,v 1.4 2012/06/13 07:35:21 jdhore Exp $

EAPI=4

inherit eutils linux-info

DESCRIPTION="Miredo is an open-source Teredo IPv6 tunneling software."
HOMEPAGE="http://www.remlab.net/miredo/"
SRC_URI="http://www.remlab.net/files/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+caps"

RDEPEND="sys-apps/iproute2
	dev-libs/judy
	caps? ( sys-libs/libcap )"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

CONFIG_CHECK="~IPV6" #318777

#tries to connect to external networks (#339180)
RESTRICT="test"

src_configure() {
	econf --disable-static \
		--enable-miredo-user \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--docdir="/usr/share/doc/${P}"
	use caps || \
		echo "#undef HAVE_SYS_CAPABILITY_H" >> config.h
}

src_install() {
	emake DESTDIR="${D}" install
	find "${D}" -name '*.la' -exec rm -f {} + || die "la file removal failed"

	newinitd "${FILESDIR}"/miredo-server.rc miredo-server
	newconfd "${FILESDIR}"/miredo-server.conf miredo-server
	newinitd "${FILESDIR}"/miredo.rc miredo
	newconfd "${FILESDIR}"/miredo.conf miredo

	insinto /etc/miredo
	doins misc/miredo-server.conf

	dodoc README NEWS ChangeLog AUTHORS THANKS TODO
}

pkg_preinst() {
	enewgroup miredo
	enewuser miredo -1 -1 /var/empty miredo
}
