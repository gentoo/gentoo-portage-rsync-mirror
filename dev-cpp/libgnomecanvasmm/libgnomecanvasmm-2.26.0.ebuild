# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomecanvasmm/libgnomecanvasmm-2.26.0.ebuild,v 1.11 2012/05/04 03:44:58 jdhore Exp $

EAPI="1"

inherit gnome2

DESCRIPTION="C++ bindings for libgnomecanvas"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc examples"

RDEPEND=">=gnome-base/libgnomecanvas-2.6
	>=dev-cpp/gtkmm-2.4:2.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS ChangeLog NEWS README TODO INSTALL"

src_unpack() {
	gnome2_src_unpack

	if ! use examples; then
		# don't waste time building the examples
		sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
			die "sed Makefile.in failed"
	fi
}

src_compile() {
	gnome2_src_compile

	if use doc; then
		cd "${S}/docs/reference"
		make all || die "failed to build API docs"
	fi
}

src_install() {
	gnome2_src_install

	find "${D}" -name '*.la' -exec rm -f {} +

	if use doc ; then
		dohtml -r docs/reference/html/*
	fi

	if use examples; then
		cp -R examples "${D}/usr/share/doc/${PF}"
	fi
}
