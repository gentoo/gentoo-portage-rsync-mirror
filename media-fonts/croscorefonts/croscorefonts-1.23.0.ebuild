# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/croscorefonts/croscorefonts-1.23.0.ebuild,v 1.1 2015/03/07 12:01:12 yngwin Exp $

EAPI=5
inherit font

DESCRIPTION="Open licensed fonts metrically compatible with MS corefonts"
HOMEPAGE="http://www.google.com/webfonts/specimen/Arimo
	http://www.google.com/webfonts/specimen/Cousine
	http://www.google.com/webfonts/specimen/Tinos"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

RESTRICT="binchecks strip test"

FONT_SUFFIX="ttf"
FONT_CONF=(
	"${FILESDIR}/62-croscore-arimo.conf"
	"${FILESDIR}/62-croscore-cousine.conf"
	"${FILESDIR}/62-croscore-symbolneu.conf"
	"${FILESDIR}/62-croscore-tinos.conf" )
