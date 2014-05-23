# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ahem/ahem-1.0.ebuild,v 1.1 2014/05/23 02:05:16 idella4 Exp $

EAPI=5

inherit font

DESCRIPTION="A font developed to help test writers develop predictable tests"
HOMEPAGE="https://github.com/Kozea/Ahem"
SRC_URI="https://github.com/Kozea/Ahem/archive/1.0.tar.gz -> {$P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

S="${WORKDIR}/${P/a/A}"
FONT_S=${S}
FONT_SUFFIX="ttf"
