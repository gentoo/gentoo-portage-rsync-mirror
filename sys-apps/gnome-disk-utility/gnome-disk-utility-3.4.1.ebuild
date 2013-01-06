# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gnome-disk-utility/gnome-disk-utility-3.4.1.ebuild,v 1.4 2012/06/15 06:40:33 mr_bones_ Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Disk Utility for GNOME using udisks"
HOMEPAGE="http://git.gnome.org/browse/gnome-disk-utility"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sh ~x86"
IUSE="fat"

CDEPEND="
	>=dev-libs/glib-2.31:2
	>=sys-fs/udisks-1.90:2
	>=x11-libs/gtk+-3.3.11:3
"
RDEPEND="${CDEPEND}
	>=x11-themes/gnome-icon-theme-symbolic-2.91
	fat? ( sys-fs/dosfstools )"
DEPEND="${CDEPEND}
	>=dev-util/intltool-0.50
	virtual/pkgconfig
"
