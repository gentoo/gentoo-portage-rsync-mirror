# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-server/silc-server-1.1.14.ebuild,v 1.3 2014/01/08 06:41:24 vapier Exp $

inherit eutils flag-o-matic user

DESCRIPTION="Server for Secure Internet Live Conferencing"
SRC_URI="http://www.silcnet.org/download/server/sources/${P}.tar.bz2"
HOMEPAGE="http://silcnet.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ipv6 debug"

RDEPEND="!<=net-im/silc-toolkit-0.9.12-r1
	!<=net-im/silc-client-1.0.1"

src_compile() {
	econf \
		--datadir=/usr/share/${PN} \
		--datarootdir=/usr/share/${PN} \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/silc \
		--with-helpdir=/usr/share/${PN}/help \
		--libdir=/usr/$(get_libdir)/${PN} \
		--docdir=/usr/share/doc/${PF} \
		--disable-optimizations \
		--with-logsdir=/var/log/${PN} \
		--with-silcd-pid-file=/var/run/silcd.pid \
		$(use_enable ipv6) \
		$(use_enable debug) \
		|| die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	insinto /usr/share/doc/${PF}/examples
	doins doc/examples/*.conf

	fperms 600 /etc/silc
	keepdir /var/log/${PN}

	rm -rf \
		"${D}"/usr/libsilc* \
		"${D}"/usr/include \
		"${D}"/etc/silc/silcd.{pub,prv}

	newinitd "${FILESDIR}/silcd.initd" silcd

	sed -i \
		-e 's:10.2.1.6:0.0.0.0:' \
		-e 's:User = "nobody";:User = "silcd";:' \
		"${D}"/etc/silc/silcd.conf
}

pkg_postinst() {
	enewuser silcd

	if [ ! -f "${ROOT}"/etc/silc/silcd.prv ] ; then
		einfo "Creating key pair in /etc/silc"
		silcd -C "${ROOT}"/etc/silc
		chmod 600 "${ROOT}"/etc/silc/silcd.{prv,pub}
	fi
}
