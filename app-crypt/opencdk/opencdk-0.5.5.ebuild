# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/opencdk/opencdk-0.5.5.ebuild,v 1.21 2014/03/01 22:52:29 mgorny Exp $

EAPI=1

DESCRIPTION="Open Crypto Development Kit for basic OpenPGP message manipulation"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/opencdk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="doc"

RDEPEND=">=dev-libs/libgcrypt-1.1.94:0"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.6"

src_install() {
	einstall || die "installed failed"

	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO
	use doc && dohtml doc/opencdk-api.html
}
