# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libecap/libecap-0.0.2.ebuild,v 1.14 2013/04/13 18:01:47 tomwij Exp $

EAPI="2"

inherit eutils toolchain-funcs

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

	# Respect AR. (bug #457734)
	tc-export AR
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc CREDITS NOTICE README change.log || die "dodoc failed"
}
