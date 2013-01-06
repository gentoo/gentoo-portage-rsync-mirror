# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprintui/libgnomeprintui-2.18.6.ebuild,v 1.10 2012/05/29 14:25:37 aballier Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="User interface libraries for gnome print"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2.2"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=gnome-base/libgnomeprint-2.12.1
	>=gnome-base/libgnomecanvas-1.117
	>=x11-themes/gnome-icon-theme-1.1.92"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} --disable-static"
}

src_prepare() {
	gnome2_src_prepare

	# Drop DEPRECATED flags, bug #384815
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		libgnomeprintui/gpaui/Makefile.am libgnomeprintui/gpaui/Makefile.in \
		libgnomeprintui/Makefile.am libgnomeprintui/Makefile.in \
		tests/Makefile.am tests/Makefile.in || die
}
