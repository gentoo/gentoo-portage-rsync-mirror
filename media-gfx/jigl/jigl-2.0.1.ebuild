# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jigl/jigl-2.0.1.ebuild,v 1.2 2014/02/24 01:35:40 phajdan.jr Exp $

DESCRIPTION="Jason's Image Gallery"
HOMEPAGE="http://xome.net/projects/jigl/"
SRC_URI="http://xome.net/projects/jigl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-lang/perl
	media-gfx/jhead
	media-gfx/imagemagick"
DEPEND=""

src_install() {
	newbin jigl.pl jigl || die
	dodoc ChangeLog Themes Todo
}
