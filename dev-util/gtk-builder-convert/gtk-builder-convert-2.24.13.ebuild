# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-builder-convert/gtk-builder-convert-2.24.13.ebuild,v 1.2 2012/12/06 09:05:21 tetromino Exp $

EAPI="4"

GNOME_ORG_MODULE="gtk+"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"

inherit gnome.org python

DESCRIPTION="Converts Glade files to GtkBuilder XML format"
HOMEPAGE="http://www.gtk.org/"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

# gtk-builder-convert was part of gtk+ until 2.24.10-r1
RDEPEND="!<=x11-libs/gtk+-2.24.10:2"
DEPEND=""

src_configure() { :; }

src_compile() { :; }

src_install() {
	cd gtk
	python_convert_shebangs 2 gtk-builder-convert
	dobin gtk-builder-convert
}
