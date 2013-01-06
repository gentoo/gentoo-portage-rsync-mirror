# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lablgtk/lablgtk-2.14.2.ebuild,v 1.12 2012/08/03 22:43:29 aballier Exp $

EAPI="2"

inherit multilib

IUSE="debug examples glade gnome gnomecanvas sourceview +ocamlopt opengl spell svg"

DESCRIPTION="Objective CAML interface for Gtk+2"
HOMEPAGE="http://lablgtk.forge.ocamlcore.org/"
SRC_URI="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/${P}.tar.gz"
LICENSE="LGPL-2.1-with-linking-exception examples? ( as-is )"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=dev-lang/ocaml-3.10[ocamlopt?]
	svg? ( >=gnome-base/librsvg-2.2:2 )
	glade? ( >=gnome-base/libglade-2.0.1 )
	gnomecanvas? ( >=gnome-base/libgnomecanvas-2.2 )
	gnome? (
		|| ( >=gnome-base/gnome-panel-2.32[bonobo] <gnome-base/gnome-panel-2.32 )
		>=gnome-base/gnome-panel-2.4.0
		>=gnome-base/libgnomeui-2.4.0
		)
	opengl? ( >=dev-ml/lablgl-0.98
		>=x11-libs/gtkglarea-1.9:2 )
	spell? ( app-text/gtkspell:2 )
	sourceview? ( x11-libs/gtksourceview:2.0 )
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

SLOT="2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-fbsd ~x86-linux"

src_configure() {
	econf $(use_enable debug) \
		$(use_with svg rsvg) \
		$(use_with glade) \
		$(use_with gnome gnomeui) \
		$(use_with gnome panel) \
		$(use_with opengl gl) \
		$(use_with spell gtkspell) \
		--without-gtksourceview \
		$(use_with sourceview gtksourceview2) \
		$(use_with gnomecanvas)
}

src_compile() {
	emake -j1 all || die "make failed"
	if use ocamlopt; then
		emake -j1 opt || die "Compiling native code failed"
	fi
}

install_examples() {
	insinto /usr/share/doc/${P}/examples
	doins examples/*.ml examples/*.rgb examples/*.png examples/*.xpm

	# Install examples for optional components
	use gnomecanvas && insinto /usr/share/doc/${P}/examples/canvas && doins examples/canvas/*.ml examples/canvas/*.png
	use svg && insinto /usr/share/doc/${P}/examples/rsvg && doins examples/rsvg/*.ml examples/rsvg/*.svg
	use glade && insinto /usr/share/doc/${P}/examples/glade && doins examples/glade/*.ml examples/glade/*.glade*
	use sourceview && insinto /usr/share/doc/${P}/examples/sourceview && doins examples/sourceview/*.ml examples/sourceview/*.lang
	use opengl && insinto /usr/share/doc/${P}/examples/GL && doins examples/GL/*.ml
	use gnome && insinto /usr/share/doc/${P}/examples/panel && doins examples/panel/*
}

src_install () {
	emake install DESTDIR="${D}" || die

	# ocamlfind support
	insinto /usr/$(get_libdir)/ocaml/lablgtk2
	doins META

	dodoc CHANGES README CHANGES.API
	use examples && install_examples
}

pkg_postinst () {
	use examples && elog "To run the examples you can use the lablgtk2 toplevel."
	use examples && elog "e.g: lablgtk2 /usr/share/doc/${P}/examples/testgtk.ml"
}
