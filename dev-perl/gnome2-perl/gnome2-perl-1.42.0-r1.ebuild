# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-perl/gnome2-perl-1.42.0-r1.ebuild,v 1.2 2014/12/07 13:07:05 zlogene Exp $

EAPI=5

MY_PN=Gnome2
MODULE_AUTHOR=TSCH
MODULE_VERSION=1.042
inherit perl-module

DESCRIPTION="Perl interface to the 2.x series of the Gnome libraries"
HOMEPAGE="http://gtk2-perl.sourceforge.net/ ${HOMEPAGE}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=dev-perl/gtk2-perl-1.0.0
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	>=dev-perl/gnome2-canvas-1.0.0
	>=dev-perl/glib-perl-1.40.0
	>=dev-perl/gnome2-vfs-perl-1.0.0"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig"

SRC_TEST=do
