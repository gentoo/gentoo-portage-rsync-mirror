# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libglademm/libglademm-2.6.7.ebuild,v 1.11 2012/05/04 03:44:58 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="C++ bindings for libglade"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="2.4"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc examples"

RDEPEND=">=gnome-base/libglade-2.6.1:2.0
	>=dev-cpp/gtkmm-2.6:2.4
	>=dev-cpp/glibmm-2.4:2"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	gnome2_src_prepare

	# we will control install manually in install
	sed -i 's/^\(SUBDIRS =.*\)docs\(.*\)$/\1\2/' Makefile.am Makefile.in || \
		die "sed Makefile.{am,in} failed (1)"

	# don't waste time building the examples
	sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' \
		Makefile.am Makefile.in || die "sed Makefile.{am,in} failed (2)"
}

src_compile() {
	gnome2_src_compile

	if use doc; then
		emake -C "${S}/docs/reference" all || die "emake doc failed"
	fi
}

src_install() {
	gnome2_src_install

	if use doc ; then
		dohtml -r docs/reference/html/* || die "dohtml failed"
	fi

	if use examples; then
		emake -C "${S}/examples" distclean || die "examples clean up failed"
		find "${S}/examples" -name "Makefile*" -delete \
			|| die "examples cleanup failed"
		insinto "/usr/share/doc/${PF}"
		doins -r examples || die "doins failed"
	fi

	# Does not install static library
	find "${D}" -name "*.la" -delete || die "failed *.la removal"
}
