# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/volwheel/volwheel-0.2.8.ebuild,v 1.3 2011/04/25 13:58:41 tomka Exp $

EAPI=2

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
	dev-perl/gtk2-trayicon
	alsa? ( media-sound/alsa-utils )"

src_install() {
	./install.pl prefix=/usr destdir="${D}" || die
	dodoc ChangeLog README TODO
}
