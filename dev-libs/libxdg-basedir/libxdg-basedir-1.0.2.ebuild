# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxdg-basedir/libxdg-basedir-1.0.2.ebuild,v 1.5 2009/10/31 14:32:55 ranger Exp $

EAPI=2
inherit libtool

DESCRIPTION="Small library to access XDG Base Directories Specification paths"
HOMEPAGE="http://n.ethz.ch/student/nevillm/download/libxdg-basedir/"
SRC_URI="http://n.ethz.ch/student/nevillm/download/libxdg-basedir/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

src_prepare() {
	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable doc doxygen-html)
}

src_compile() {
	emake || die

	if use doc; then
		emake doxygen-doc || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use doc; then
		dohtml -r doc/html/*
	fi

	find "${D}" -name '*.la' -delete
}
