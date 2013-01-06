# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stunnel/stunnel-4.44-r1.ebuild,v 1.2 2012/10/19 08:47:01 ottxor Exp $

EAPI="4"

inherit autotools ssl-cert eutils user

DESCRIPTION="TLS/SSL - Port Wrapper"
HOMEPAGE="http://stunnel.mirt.net/"
SRC_URI="ftp://ftp.stunnel.org/stunnel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="ipv6 selinux tcpd xforward listen-queue"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )
	>=dev-libs/openssl-0.9.8k"
RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-stunnel )"

pkg_setup() {
	enewgroup stunnel
	enewuser stunnel -1 -1 -1 stunnel
}

src_prepare() {
	use xforward && epatch "${FILESDIR}/stunnel-4.44-xforwarded-for.diff"
	use listen-queue && epatch "${FILESDIR}/stunnel-4.44-listen-queue.diff"
	eautoreconf

	# Hack away generation of certificate
	sed -i -e "s/^install-data-local:/do-not-run-this:/" \
		tools/Makefile.in || die "sed failed"
}

src_configure() {
	econf $(use_enable ipv6) \
		--with-ssl="${EPREFIX}"/usr \
		$(use_enable tcpd libwrap)
}

src_install() {
	emake DESTDIR="${D}" install
	rm -rf "${ED}"/usr/share/doc/${PN}
	rm -f "${ED}"/etc/stunnel/stunnel.conf-sample "${ED}"/usr/bin/stunnel3 \
		"${ED}"/usr/share/man/man8/stunnel.{fr,pl}.8

	# The binary was moved to /usr/bin with 4.21,
	# symlink for backwards compatibility
	dosym ../bin/stunnel /usr/sbin/stunnel

	dodoc AUTHORS BUGS CREDITS PORTS README TODO ChangeLog
	dohtml doc/stunnel.html doc/en/VNC_StunnelHOWTO.html tools/ca.html \
		tools/importCA.html

	insinto /etc/stunnel
	doins "${FILESDIR}"/stunnel.conf
	newinitd "${FILESDIR}"/stunnel.initd-start-stop-daemon stunnel

	keepdir /var/run/stunnel
	fowners stunnel:stunnel /var/run/stunnel
}

pkg_postinst() {
	if [ ! -f "${EROOT}"/etc/stunnel/stunnel.key ]; then
		install_cert /etc/stunnel/stunnel
		chown stunnel:stunnel "${EROOT}"/etc/stunnel/stunnel.{crt,csr,key,pem}
		chmod 0640 "${EROOT}"/etc/stunnel/stunnel.{crt,csr,key,pem}
	fi

	einfo "If you want to run multiple instances of stunnel, create a new config"
	einfo "file ending with .conf in /etc/stunnel/. **Make sure** you change "
	einfo "\'pid= \' with a unique filename."
}
