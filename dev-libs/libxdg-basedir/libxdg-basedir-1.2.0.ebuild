# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxdg-basedir/libxdg-basedir-1.2.0.ebuild,v 1.1 2014/04/15 19:20:07 idl0r Exp $

EAPI=5
inherit autotools

TREE="9642bf6c996ea1a4b20537db592e96d1c65affe5"

DESCRIPTION="Small library to access XDG Base Directories Specification paths"
HOMEPAGE="http://repo.or.cz/w/libxdg-basedir.git"
SRC_URI="http://repo.or.cz/w/libxdg-basedir.git/snapshot/${TREE}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x64-macos ~x86-solaris"
IUSE="doc static-libs"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

S="${WORKDIR}/${PN}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable doc doxygen-html)
}

src_compile() {
	emake

	if use doc; then
		emake doxygen-doc
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	if use doc; then
		dohtml -r doc/html/*
	fi

	find "${D}" -type f -name '*.la' -delete
}
