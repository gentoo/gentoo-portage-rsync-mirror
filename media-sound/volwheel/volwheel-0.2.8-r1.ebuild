# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/volwheel/volwheel-0.2.8-r1.ebuild,v 1.3 2012/12/16 13:52:23 ago Exp $

EAPI=4
inherit eutils gnome2-utils

DESCRIPTION="A volume control trayicon with mouse wheel support"
HOMEPAGE="http://oliwer.net/b/volwheel.html"
SRC_URI="http://olwtools.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	dev-perl/gtk2-perl
	alsa? ( media-sound/alsa-utils )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-perl516.patch
	sed -i -e '/^Encoding/d' ${PN}.desktop || die
}

src_install() {
	./install.pl prefix=/usr destdir="${D}" || die
	dodoc ChangeLog README TODO
}

pkg_preinst() {	gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
