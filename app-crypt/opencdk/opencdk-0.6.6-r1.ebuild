# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/opencdk/opencdk-0.6.6-r1.ebuild,v 1.2 2014/03/01 22:52:29 mgorny Exp $

EAPI=5

inherit autotools

DESCRIPTION="Open Crypto Development Kit for basic OpenPGP message manipulation"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/opencdk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="doc test"

RDEPEND=">=dev-libs/libgcrypt-1.2.0:0"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.6"

src_prepare() {
	use test || sed -e "/SUBDIRS/s/ tests//" -i Makefile.am

	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' configure.ac || die
	eautoreconf
}

src_install() {
	default
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	use doc && dohtml doc/opencdk-api.html
}
