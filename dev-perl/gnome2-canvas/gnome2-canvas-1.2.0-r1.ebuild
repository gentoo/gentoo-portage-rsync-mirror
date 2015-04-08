# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-canvas/gnome2-canvas-1.2.0-r1.ebuild,v 1.1 2014/08/24 13:04:22 axs Exp $

EAPI=5

MY_PN=Gnome2-Canvas
MODULE_AUTHOR=TSCH
MODULE_VERSION=1.002
inherit perl-module

DESCRIPTION="Perl interface to the Gnome Canvas"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=gnome-base/libgnomecanvas-2
	>=dev-perl/glib-perl-1.040
	>=dev-perl/gtk2-perl-1.040"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-pkgconfig-1.03
	>=dev-perl/extutils-depends-0.202
	virtual/pkgconfig"
