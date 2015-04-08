# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/polkit-gnome/polkit-gnome-0.102.ebuild,v 1.9 2012/05/05 06:25:18 jdhore Exp $

# This ebuild is only for installing obsolete libpolkit-gtk-1 wrt #387663

EAPI=4
inherit gnome.org

DESCRIPTION="Separate ebuild for obsolete libpolkit-gtk-1 library"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/PolicyKit"

LICENSE="LGPL-2"
SLOT="obsolete"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="+introspection"

RDEPEND=">=dev-libs/glib-2.28
	>=x11-libs/gtk+-2.24:2[introspection?]
	>=sys-auth/polkit-0.102[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.6.2 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
	!<gnome-extra/polkit-gnome-0.102"

src_configure() {
	econf \
		--disable-static \
		$(use_enable introspection)
}

src_compile() {
	emake -C polkitgtk libpolkit-gtk-1.la
}

src_install() {
	emake DESTDIR="${D}" install
	rm -rf \
		"${ED}"usr/lib*/polkit-gnome-authentication-agent-1 \
		"${ED}"usr/lib*/libpolkit-gtk-1.la \
		"${ED}"usr/share/locale
}
