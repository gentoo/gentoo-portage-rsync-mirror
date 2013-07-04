# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qpdf/qpdf-4.1.0.ebuild,v 1.5 2013/07/04 14:14:30 ago Exp $

EAPI="5"

inherit eutils

DESCRIPTION="A command-line program that does structural, content-preserving transformations on PDF files"
HOMEPAGE="http://qpdf.sourceforge.net/"
SRC_URI="mirror://sourceforge/qpdf/${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0/10" # subslot = libqpdf soname version
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 x86 ~amd64-fbsd ~x86-fbsd ~m68k-mint"
IUSE="doc examples static-libs test"

RDEPEND="dev-libs/libpcre
	sys-libs/zlib
	>=dev-lang/perl-5.8"
DEPEND="${RDEPEND}
	test? (
		sys-apps/diffutils
		media-libs/tiff
		app-text/ghostscript-gpl
	)"

DOCS=( ChangeLog README TODO )

src_prepare() {
	# Manually install docs
	sed -i -e "/docdir/d" make/libtool.mk || die
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable test test-compare-images)
}

src_install() {
	default

	if use doc ; then
		dodoc doc/qpdf-manual.pdf
		dohtml doc/*
	fi

	if use examples ; then
		dobin examples/build/.libs/*
	fi

	prune_libtool_files
}
