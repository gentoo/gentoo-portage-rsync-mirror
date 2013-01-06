# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cln/cln-1.3.1.ebuild,v 1.12 2012/10/10 13:29:45 jlec Exp $

EAPI=2

inherit eutils flag-o-matic multilib

DESCRIPTION="Class library (C++) for numbers"
HOMEPAGE="http://www.ginac.de/CLN/"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gnu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="doc examples"

DEPEND="dev-libs/gmp
	doc? ( virtual/latex-base )"
RDEPEND="${DEPEND}"

pkg_setup() {
	use sparc && append-cppflags "-DNO_ASM"
	use hppa && append-cppflags "-DNO_ASM"
	use arm && append-cppflags "-DNO_ASM"
}

src_prepare() {
	# avoid building examples
	# do it in Makefile.in to avoid time consuming eautoreconf
	sed -i -e '/^SUBDIRS.*=/s/examples doc benchmarks/doc/' Makefile.in || die
	# fix compilation under gcc 4.4
	epatch "${FILESDIR}"/${PN}-1.2.2-gcc-4.4.patch
}

src_configure () {
	use prefix || EPREFIX=

	econf  \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--datadir="${EPREFIX}"/usr/share/doc/${PF}
}
src_compile() {
	emake || die "emake failed"
	if use doc; then
		emake html pdf || die "emake doc failed"
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog TODO* NEWS
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins  doc/cln.pdf || die
		dohtml doc/* || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.cc || die
	fi
}
