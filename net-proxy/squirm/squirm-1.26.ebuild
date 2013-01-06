# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/squirm/squirm-1.26.ebuild,v 1.2 2012/12/16 13:48:17 ago Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A redirector for Squid"
HOMEPAGE="http://squirm.foote.com.au"
SRC_URI="http://squirm.foote.com.au/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_install() {
	emake PREFIX="${D}/opt/squirm" install || die "emake install failed"
}

pkg_postinst() {
	einfo "To enable squirm, add the following lines to /etc/squid/squid.conf:"
	einfo "    url_rewrite_program /opt/squirm/bin/squirm"
	einfo "    url_rewrite_children 10"
}
