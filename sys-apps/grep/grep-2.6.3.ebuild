# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.6.3.ebuild,v 1.1 2010/04/02 20:06:36 vapier Exp $

EAPI="2"

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="nls pcre"

RDEPEND="nls? ( virtual/libintl )
	pcre? ( >=dev-libs/libpcre-7.8-r1 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i '1i#include "../lib/progname.h"' tests/get-mb-cur-max.c
}

src_configure() {
	econf \
		--bindir=/bin \
		$(use_enable nls) \
		$(use_enable pcre perl-regexp) \
		$(use elibc_FreeBSD || echo --without-included-regex) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
