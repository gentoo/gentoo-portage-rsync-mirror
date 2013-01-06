# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/privoxy/privoxy-3.0.12.ebuild,v 1.10 2012/05/23 22:56:23 vapier Exp $

EAPI="2"

inherit eutils toolchain-funcs autotools user

MY_IPV6_PATCH="${P}-ipv6-1.diff"
HOMEPAGE="http://www.privoxy.org
	http://sourceforge.net/projects/ijbswa/"
DESCRIPTION="A web proxy with advanced filtering capabilities for protecting privacy against Internet junk"
SRC_URI="mirror://sourceforge/ijbswa/${P/_/-}-stable-src.tar.gz
	ipv6? ( mirror://gentoo/${MY_IPV6_PATCH}.gz )"

IUSE="ipv6 selinux threads zlib"
SLOT="0"
KEYWORDS="alpha amd64 arm ppc ppc64 sparc x86 ~x86-fbsd"
LICENSE="GPL-2"

DEPEND="dev-libs/libpcre
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-privoxy )"

S="${WORKDIR}/${P/_/-}-stable"

pkg_setup() {
	enewgroup privoxy
	enewuser privoxy -1 -1 /etc/privoxy privoxy
}

src_prepare() {
	use ipv6 && epatch "${WORKDIR}/${MY_IPV6_PATCH}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	# autoreconf needs to be called even if we don't modify any autotools source files
	# See main makefile
	eautoreconf
}

src_configure() {
	export CC=$(tc-getCC)
	econf \
		$(use_enable zlib) \
		$(use_enable threads pthread) \
		--enable-dynamic-pcre \
		--with-user=privoxy \
		--with-group=privoxy \
		--sysconfdir=/etc/privoxy \
		--docdir=/usr/share/doc/${PF}
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}/privoxy.initd" privoxy
	insinto /etc/logrotate.d
	newins "${FILESDIR}/privoxy.logrotate" privoxy

	diropts -m 0750 -g privoxy -o privoxy
	keepdir /var/log/privoxy
}
