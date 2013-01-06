# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gxmessage/gxmessage-2.20.0.ebuild,v 1.1 2012/05/17 14:08:01 ssuominen Exp $

EAPI=4
inherit gnome2-utils

DESCRIPTION="A GTK+ based xmessage clone"
HOMEPAGE="http://savannah.gnu.org/projects/gxmessage/ http://homepages.ihug.co.nz/~trmusson/programs.html#gxmessage"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	http://homepages.ihug.co.nz/~trmusson/stuff/${P}.tar.gz"

LICENSE="GPL-3 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.20:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40.1
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
