# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mlton/mlton-20100608.ebuild,v 1.3 2013/04/25 07:27:21 gienah Exp $

inherit base eutils

DESCRIPTION="Standard ML optimizing compiler and libraries"
BASE_URI="mirror://sourceforge/${PN}"
SRC_URI="!binary? ( ${BASE_URI}/${P}.src.tgz )
		  binary? ( amd64? ( ${BASE_URI}/${P}-1.amd64-linux.static.tgz )
					x86?   ( ${BASE_URI}/${P}-1.x86-linux.static.tgz ) )"

HOMEPAGE="http://www.mlton.org"

LICENSE="HPND MIT"
SLOT="0"
# there is support for ppc64 and ia64, but no
# binaries are provided and there is no native
# code generation for these platforms
KEYWORDS="-* ~amd64 ~x86"
IUSE="binary doc"

DEPEND="dev-libs/gmp
		doc? ( virtual/latex-base )"
RDEPEND="dev-libs/gmp"

QA_PRESTRIPPED="binary? (
	usr/bin/mlnlffigen
	usr/bin/mllex
	usr/bin/mlprof
	usr/bin/mlyacc
	usr/lib/mlton/mlton-compile
)"

# Fix Bug 452558 - dev-lang/mlton-20100608 fails to build, unknown type name '__gmp_const'
# Fixed by upstream: https://github.com/MLton/mlton/commit/a658a1f4a76a01f568116598800f49b80cf8ee1a
PATCHES=("${FILESDIR}/${P}-gmp-const.patch")

src_compile() {
	if use !binary; then
		has_version dev-lang/mlton || die "emerge with binary use flag first"

		# Fix location in which to install man pages
		sed -i 's@^MAN_PREFIX_EXTRA :=.*@MAN_PREFIX_EXTRA := /share@' \
			Makefile || die 'sed Makefile failed'

		# Does not support parallel make
		emake -j1 all-no-docs || die
		if use doc; then
			export VARTEXFONTS="${T}/fonts"
			emake docs || die "failed to create documentation"
		fi
	fi
}

src_install() {
	if use binary; then
		# Fix location in which to install man pages
		mv "${WORKDIR}/usr/man" "${WORKDIR}/usr/share" || die "mv man failed"

		mv "${WORKDIR}/usr" "${D}" || die "mv failed"
	else
		emake DESTDIR="${D}" install-no-docs || die
		if use doc; then emake DESTDIR="${D}" TDOC="${D}"/usr/share/doc/${P} install-docs || die; fi
	fi
}
