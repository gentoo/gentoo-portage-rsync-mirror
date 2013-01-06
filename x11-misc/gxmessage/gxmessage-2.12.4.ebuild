# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gxmessage/gxmessage-2.12.4.ebuild,v 1.9 2012/07/29 16:43:57 armin76 Exp $

EAPI=4
inherit gnome2-utils

DESCRIPTION="A GTK+ based xmessage clone"
HOMEPAGE="http://homepages.ihug.co.nz/~trmusson/programs.html#gxmessage"
SRC_URI="http://homepages.ihug.co.nz/~trmusson/stuff/${P}.tar.gz"

LICENSE="GPL-3 public-domain"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

src_install() {
	default

	docinto examples
	dodoc examples/*
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
