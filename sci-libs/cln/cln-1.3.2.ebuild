# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cln/cln-1.3.2.ebuild,v 1.1 2011/06/13 21:39:56 bicatali Exp $

EAPI=4
inherit eutils flag-o-matic

DESCRIPTION="Class library (C++) for numbers"
HOMEPAGE="http://www.ginac.de/CLN/"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gnu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs"

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
}

src_configure () {
	econf \
		--datadir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable static-libs static)
}
src_compile() {
	emake
	use doc && emake html pdf
}

src_install () {
	default
	use doc && dodoc doc/cln.pdf && dohtml doc/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.cc
	fi
}
