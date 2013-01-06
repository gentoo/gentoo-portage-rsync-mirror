# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/varnish/varnish-2.0.4-r1.ebuild,v 1.7 2012/07/11 23:27:45 blueness Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Varnish is a state-of-the-art, high-performance HTTP accelerator."
HOMEPAGE="http://varnish.projects.linpro.no/"
SRC_URI="mirror://sourceforge/varnish/${P}.tar.gz"

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
#varnish compiles stuff at run time
RDEPEND="sys-devel/gcc"

RESTRICT="test" #315725
HTTP_HDR_MAX_VAL=${HTTP_HDR_MAX_VAL:-32}

src_prepare() {
	epatch "${FILESDIR}"/${P}-link-order.patch
	epatch "${FILESDIR}"/${P}-virtual-ncsa.patch
	sed -e "s/#define HTTP_HDR_MAX_VAL .*/#define HTTP_HDR_MAX_VAL ${HTTP_HDR_MAX_VAL}/" \
		-i bin/varnishd/cache.h
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newinitd "${FILESDIR}"/varnishd.initd varnishd || die
	newconfd "${FILESDIR}"/varnishd.confd varnishd || die

	insinto /etc/logrotate.d
	newins "${FILESDIR}/varnishd.logrotate" varnishd

	dodir /var/log/varnish
}

pkg_postinst () {
	elog "No demo-/sample-configfile is included in the distribution -"
	elog "please read the man-page for more info."
	elog "A sample (localhost:8080 -> localhost:80) for gentoo is given in"
	elog "   /etc/conf.d/varnishd"
	echo
}
