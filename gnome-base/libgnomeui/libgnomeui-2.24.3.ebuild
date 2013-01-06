# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeui/libgnomeui-2.24.3.ebuild,v 1.11 2012/05/05 05:38:12 jdhore Exp $

EAPI="2"

GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="User Interface routines for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="doc"

# gtk+-2.14 dep instead of 2.12 ensures system doesn't loose VFS capabilities in GtkFilechooser
COMMON_DEPEND=">=dev-libs/libxml2-2.4.20:2
	>=gnome-base/libgnome-2.13.7
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libbonoboui-2.13.1
	>=gnome-base/gconf-2:2
	>=x11-libs/pango-1.1.2
	>=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.14:2
	>=gnome-base/gnome-vfs-2.7.3:2
	>=gnome-base/libglade-2:2.0
	>=gnome-base/gnome-keyring-0.4
	>=dev-libs/popt-1.5"
RDEPEND="${COMMON_DEPEND}
	x11-themes/gnome-icon-theme"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"
