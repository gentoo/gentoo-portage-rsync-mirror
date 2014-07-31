# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libguess/libguess-1.2.ebuild,v 1.1 2014/07/31 20:10:01 chainsaw Exp $

EAPI=5

DESCRIPTION="A high-speed character set detection library."
HOMEPAGE="http://www.atheme.org/project/libguess"
SRC_URI="http://rabbit.dereferenced.org/~nenolod/distfiles/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="examples"

RDEPEND="
	>=dev-libs/libmowgli-0.7.0:0"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf $(use_enable examples) \
		|| die "econf failed"
}

src_test() {
	cd src/tests
	make || die "test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}
