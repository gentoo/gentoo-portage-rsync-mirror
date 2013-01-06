# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/vlgothic/vlgothic-20110414.ebuild,v 1.1 2011/04/18 23:53:31 matsuu Exp $

inherit font

DESCRIPTION="Japanese TrueType font from Vine Linux"
HOMEPAGE="http://dicey.org/vlgothic/"
SRC_URI="mirror://sourceforge.jp/vlgothic/51670/VLGothic-${PV}.tar.bz2"

# M+ FONTS -> mplus-fonts
# sazanami -> BSD-2
LICENSE="vlgothic mplus-fonts BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/VLGothic"

FONT_SUFFIX="ttf"
FONT_S="${S}"
DOCS="Changelog README*"
