# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-2.0.1.ebuild,v 1.11 2012/05/05 03:52:26 jdhore Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="GL extensions for gtk+"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="examples"

RDEPEND=">=x11-libs/gtk+-2.0.3:2
	virtual/opengl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README* docs/*.txt"

pkg_setup() {
	G2CONF="${G2CONF} --disable-static"
}

src_prepare() {
	# Do not build examples
	sed "s:\(SUBDIRS.*\)examples:\1:" -i Makefile.am Makefile.in || die "sed failed"
}

src_install() {
	gnome2_src_install

	if use examples; then
		cd "${S}"/examples
		insinto /usr/share/doc/${PF}/examples
		doins *.c *.h *.lwo README || die "doins failed"
	fi
}
