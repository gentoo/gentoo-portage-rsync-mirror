# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/proggy-fonts/proggy-fonts-1.ebuild,v 1.10 2008/08/25 12:02:12 armin76 Exp $

inherit font

DESCRIPTION="A set of monospaced bitmap programming fonts"
HOMEPAGE="http://www.proggyfonts.com/"
SRC_URI="http://dl.liveforge.org/fonts/${P}.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
S="${WORKDIR}/${PN}"
FONT_S=${S}
FONT_SUFFIX="pcf.gz"
