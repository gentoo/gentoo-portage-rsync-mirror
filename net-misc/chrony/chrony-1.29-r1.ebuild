# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/chrony/chrony-1.29-r1.ebuild,v 1.8 2013/12/23 16:00:02 ago Exp $

EAPI=5
inherit eutils systemd toolchain-funcs

DESCRIPTION="NTP client and server programs"
HOMEPAGE="http://chrony.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/${PN}/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ~mips ppc sparc x86"
IUSE="caps ipv6 +readline +rtc selinux"

RDEPEND="
	caps? ( sys-libs/libcap )
	readline? ( >=sys-libs/readline-4.1-r4 )
	selinux? ( sec-policy/selinux-chronyd )
"
DEPEND="
	${RDEPEND}
	sys-apps/texinfo
"

S="${WORKDIR}/${P/_/-}"
DOCS=( examples/chrony.{conf,keys}.example )

src_prepare() {
	sed -i \
		-e 's:/etc/chrony\.:/etc/chrony/chrony.:g' \
		-e 's:/var/run:/run:g' \
		conf.c chrony.texi.in chrony.txt examples/* faq.txt || die
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

	keepdir /var/{lib,log}/chrony /etc/chrony

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/chrony.logrotate chrony

	systemd_newunit "${FILESDIR}"/chronyd.service-r1 chronyd.service
	systemd_enable_ntpunit 50-chrony chronyd.service
}
