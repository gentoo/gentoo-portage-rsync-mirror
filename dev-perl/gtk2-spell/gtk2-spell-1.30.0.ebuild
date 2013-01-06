# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-spell/gtk2-spell-1.30.0.ebuild,v 1.4 2012/09/02 18:50:20 armin76 Exp $

EAPI=3

MY_PN=Gtk2-Spell
MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Bindings for GtkSpell with Gtk2.x"
HOMEPAGE="http://gtk2-perl.sf.net/ ${HOMEPAGE}"
SRC_URI+=" mirror://gentoo/gtk2-spell-1.03-caa0ef46.patch.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 hppa ~ppc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=app-text/gtkspell-2:2
	>=dev-perl/glib-perl-1.012
	>=dev-perl/gtk2-perl-1.012"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	virtual/pkgconfig"

PATCHES=( "${DISTDIR}"/gtk2-spell-1.03-caa0ef46.patch.gz )

src_unpack() {
	unpack ${MY_PN}-${MODULE_VERSION}.tar.gz
}

src_prepare() {
	# Without this it cannot find gtkspell <rigo@home.nl>
	sed -ie "s:\#my:my:g" "${S}"/Makefile.PL || die "sed failed"
	perl-module_src_prepare
}
