# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-chooser/im-chooser-1.5.2.ebuild,v 1.4 2012/07/18 06:58:05 naota Exp $

EAPI=3
inherit gnome2 eutils

DESCRIPTION="Desktop Input Method configuration tool"
HOMEPAGE="https://fedorahosted.org/im-chooser/"
SRC_URI="https://fedorahosted.org/releases/i/m/im-chooser/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND=">=app-i18n/imsettings-1
	>=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.16:2
	gnome? ( >=gnome-base/gnome-control-center-2.29:2 )"
#	|| (
#		(
#			>=dev-libs/glib:3
#			>=x11-libs/gtk+:3
#			gnome? ( gnome-base/gnome-control-center:3 )
#		)
#		(
#			>=dev-libs/glib-2.16:2
#			>=x11-libs/gtk+-2.16:2
#			gnome? ( >=gnome-base/gnome-control-center-2.29:2 )
#		)
#	)
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.5.1-imchooserui.patch
	gnome2_src_prepare
}
