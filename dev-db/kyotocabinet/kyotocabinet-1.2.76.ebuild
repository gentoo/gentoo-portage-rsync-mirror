# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kyotocabinet/kyotocabinet-1.2.76.ebuild,v 1.1 2012/05/30 03:42:10 patrick Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A straightforward implementation of DBM"
HOMEPAGE="http://fallabs.com/kyotocabinet/"
SRC_URI="${HOMEPAGE}pkg/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris"
IUSE="debug doc examples static-libs"

DEPEND="sys-libs/zlib
	app-arch/xz-utils"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/fix_configure-1.2.62.patch"
	sed -ie "/ldconfig/d" Makefile.in
	sed -ie "/DOCDIR/d" Makefile.in
}

src_configure() {
	econf $(use_enable debug) \
		$(use_enable static-libs static) \
		$(use_enable !static-libs shared) \
		--enable-lzma --docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	use static-libs || find "${D}" \( -name '*.a' -or -name '*.la' \) -delete

	if use examples; then
		insinto /usr/share/${PF}/example
		doins example/* || die "Install failed"
	fi

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/* || die "Install failed"
	fi
}

src_test() {
	emake -j1 check || die "Tests failed"
}
