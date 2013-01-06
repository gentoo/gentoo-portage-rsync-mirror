# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/swfdec-gnome/swfdec-gnome-2.30.1.ebuild,v 1.8 2011/03/23 08:31:08 nirbheek Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Flash player and thumbnailer for GNOME"
HOMEPAGE="http://swfdec.freedesktop.org/wiki/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.14:2
	>=gnome-base/gconf-2:2
	>=media-libs/swfdec-0.8[gtk]"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	sys-devel/gettext"

DOCS="NEWS README"
