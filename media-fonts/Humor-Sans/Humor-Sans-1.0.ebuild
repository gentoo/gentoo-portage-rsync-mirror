# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/Humor-Sans/Humor-Sans-1.0.ebuild,v 1.1 2013/09/01 17:04:31 tomwij Exp $

EAPI="5"

inherit font

DESCRIPTION="A sanserif typeface in the style of xkcd."
HOMEPAGE="http://antiyawn.com/uploads/humorsans.html"
SRC_URI="http://www.antiyawn.com/uploads/${P}.ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/${A//-${PV}}"
}
