# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arphicfonts/arphicfonts-0.1.20060928.ebuild,v 1.12 2007/10/02 01:29:30 dirtyepic Exp $

inherit font

DESCRIPTION="Chinese TrueType Arphic Fonts"
HOMEPAGE="http://www.arphic.com.tw/ http://www.freedesktop.org/wiki/Software_2fCJKUnifonts"
SRC_URI="mirror://gnu/non-gnu/chinese-fonts-truetype/gkai00mp.ttf.gz
	mirror://gnu/non-gnu/chinese-fonts-truetype/bkai00mp.ttf.gz
	mirror://gnu/non-gnu/chinese-fonts-truetype/bsmi00lp.ttf.gz
	mirror://gnu/non-gnu/chinese-fonts-truetype/gbsn00lp.ttf.gz
	mirror://debian/pool/main/t/ttf-arphic-uming/ttf-arphic-uming_${PV}.orig.tar.gz
	mirror://debian/pool/main/t/ttf-arphic-ukai/ttf-arphic-ukai_${PV}.orig.tar.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="X"

S="${WORKDIR}"

FONT_S="${S}"
FONT_SUFFIX="ttf"

# Only installs fonts
RESTRICT="strip binchecks"

src_unpack() {
	unpack ${A}
	cd "${S}/ttf-arphic-ukai-${PV}"
	mv ukai.ttf "${S}"
	cd "${S}/ttf-arphic-uming-${PV}"
	mv uming.ttf "${S}"
}
