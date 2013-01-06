# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnome-vfsmm/gnome-vfsmm-2.26.0.ebuild,v 1.8 2012/05/04 03:44:56 jdhore Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gnome-vfs"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc examples"

# glibmm dep is because build fails with older versions...
RDEPEND=">=gnome-base/gnome-vfs-2.8.1
	>=dev-cpp/glibmm-2.12"
DEPEND="virtual/pkgconfig
	doc? ( app-doc/doxygen )
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README INSTALL"

src_unpack() {
	gnome2_src_unpack

	if ! use doc; then
		# documentation requires Doxygen and takes time
		sed -i 's/^\(SUBDIRS =.*\)docs\(.*\)$/\1\2/' Makefile.in || \
			die "sed Makefile.in failed"
	fi

	if ! use examples; then
		# don't waste time building the examples
		sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
			die "sed Makefile.in failed"
	fi
}

src_install() {
	gnome2_src_install

	if use doc ; then
		dohtml -r docs/reference/html/* docs/images/*
	fi

	if use examples; then
		find examples -type d -name '.deps' -exec rm -fr {} \; 2>/dev/null
		cp -R examples "${D}"/usr/share/doc/${PF}
	fi
}
