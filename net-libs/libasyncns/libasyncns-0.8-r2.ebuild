# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libasyncns/libasyncns-0.8-r2.ebuild,v 1.11 2012/12/20 17:40:53 hasufell Exp $

EAPI=3
inherit eutils libtool flag-o-matic

DESCRIPTION="C library for executing name service queries asynchronously."
HOMEPAGE="http://0pointer.de/lennart/projects/libasyncns/"
SRC_URI="http://0pointer.de/lennart/projects/libasyncns/${P}.tar.gz"

SLOT="0"

LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-linux ~x86-linux"

IUSE="doc debug"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

src_prepare() {
	# fix libdir in pkgconfig file
	epatch "${FILESDIR}/${P}-libdir.patch"
	elibtoolize
}

src_configure() {
	# libasyncns uses assert()
	use debug || append-cppflags -DNDEBUG

	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--disable-dependency-tracking \
		--disable-lynx \
		--disable-static
}

src_compile() {
	emake || die "emake failed"

	if use doc; then
		doxygen doxygen/doxygen.conf || die "doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	find "${D}" -name '*.la' -delete

	if use doc; then
		docinto apidocs
		dohtml html/*
	fi

	prepalldocs
}
