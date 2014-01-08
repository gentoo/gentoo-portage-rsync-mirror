# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/dante/dante-1.3.2.ebuild,v 1.7 2014/01/08 06:24:08 vapier Exp $

EAPI="4"

inherit autotools eutils user

DESCRIPTION="A free socks4,5 and msproxy implementation"
HOMEPAGE="http://www.inet.no/dante/"
SRC_URI="ftp://ftp.inet.no/pub/socks/${P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="debug kerberos pam selinux static-libs tcpd"

RDEPEND="pam? ( virtual/pam )
	kerberos? ( virtual/krb5 )
	selinux? ( sec-policy/selinux-dante )
	tcpd? ( sys-apps/tcp-wrappers )
	userland_GNU? ( virtual/shadow )"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

DOCS="BUGS CREDITS NEWS README SUPPORT doc/README* doc/*.txt doc/SOCKS4.protocol"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.3.0-socksify.patch \
		"${FILESDIR}"/${PN}-1.3.1-flags.patch

	sed -i \
		-e 's:/etc/socks\.conf:"${EPREFIX}"/etc/socks/socks.conf:' \
		-e 's:/etc/sockd\.conf:"${EPREFIX}"/etc/socks/sockd.conf:' \
		doc/{socksify.1,socks.conf.5,sockd.conf.5,sockd.8} \
		|| die

	sed -i -e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.ac || die

	eautoreconf
}

src_configure() {
	econf \
		--with-socks-conf="${EPREFIX}"/etc/socks/socks.conf \
		--with-sockd-conf="${EPREFIX}"/etc/socks/sockd.conf \
		--without-upnp \
		$(use_enable debug) \
		$(use_with kerberos gssapi) \
		$(use_with pam) \
		$(use_enable static-libs static) \
		$(use_enable tcpd libwrap)
}

src_install() {
	default

	# default configuration files
	insinto /etc/socks
	doins "${FILESDIR}"/sock?.conf
	pushd "${ED}/etc/socks" > /dev/null
	use pam && epatch "${FILESDIR}/sockd.conf-with-pam.patch"
	use tcpd && epatch "${FILESDIR}/sockd.conf-with-libwrap.patch"
	popd > /dev/null

	# init script
	newinitd "${FILESDIR}/dante-sockd-init" dante-sockd
	newconfd "${FILESDIR}/dante-sockd-conf" dante-sockd

	# example configuration files
	docinto examples
	dodoc example/*.conf

	use static-libs || find "${ED}" -name '*.la' -exec rm '{}' +
}

pkg_postinst() {
	enewuser sockd -1 -1 /etc/socks daemon
}
