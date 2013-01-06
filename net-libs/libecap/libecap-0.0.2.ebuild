# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libecap/libecap-0.0.2.ebuild,v 1.13 2012/09/04 15:43:17 eras Exp $

EAPI="2"

inherit eutils

DESCRIPTION="API for implementing ICAP content analysis and adaptation"
HOMEPAGE="http://www.e-cap.org/"
SRC_URI="http://www.measurement-factory.com/tmp/ecap/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=""
RDEPEND="!net-libs/libecap:2"

src_prepare() {
	epatch "${FILESDIR}/${PN}-limits.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc CREDITS NOTICE README change.log || die "dodoc failed"
}
