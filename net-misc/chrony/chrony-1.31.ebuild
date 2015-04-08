# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/chrony/chrony-1.31.ebuild,v 1.8 2014/11/02 09:06:02 swift Exp $

EAPI=5
inherit eutils systemd toolchain-funcs

DESCRIPTION="NTP client and server programs"
HOMEPAGE="http://chrony.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/${PN}/${P/_/-}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~arm hppa ~mips ppc sparc x86"
IUSE="caps ipv6 +readline +rtc selinux"

CDEPEND="
	caps? ( sys-libs/libcap )
	readline? ( >=sys-libs/readline-4.1-r4 )
"
DEPEND="
	${CDEPEND}
	sys-apps/texinfo
"
RDEPEND="
	${CDEPEND}
	selinux? ( sec-policy/selinux-chronyd )
"

RESTRICT=test

S="${WORKDIR}/${P/_/-}"

src_prepare() {
	sed -i \
		-e 's:/etc/chrony\.:/etc/chrony/chrony.:g' \
		-e 's:/var/run:/run:g' \
		conf.c chrony.texi.in chrony.txt examples/* FAQ || die
}

src_configure() {
	tc-export CC

	# not an autotools generated script
	./configure \
		$(usex caps '' --disable-linuxcaps) \
		$(usex ipv6 '' --disable-ipv6) \
		$(usex readline '' --disable-readline) \
		$(usex rtc '' --disable-rtc) \
		--docdir=/usr/share/doc/${PF} \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--sysconfdir=/etc/chrony \
		--without-nss \
		--without-tomcrypt \
		${EXTRA_ECONF} \
		|| die
}

src_compile() {
	emake all docs
}

src_install() {
	default
	rm "${D}"/usr/share/doc/${PF}/COPYING || die
	doinfo chrony.info*

	newinitd "${FILESDIR}"/chronyd.init chronyd
	newconfd "${FILESDIR}"/chronyd.conf chronyd

	insinto /etc/${PN}
	newins examples/chrony.conf.example chrony.conf
	newins examples/chrony.keys.example chrony.keys

	keepdir /var/{lib,log}/chrony

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/chrony.logrotate chrony

	systemd_newunit "${FILESDIR}"/chronyd.service-r2 chronyd.service
	systemd_enable_ntpunit 50-chrony chronyd.service
}
