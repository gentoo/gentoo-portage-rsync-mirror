# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/heuristica/heuristica-0.2.1.ebuild,v 1.1 2010/03/06 20:02:59 spatz Exp $

EAPI="3"

inherit font

DESCRIPTION="A font based on Adobe Utopia"
HOMEPAGE="http://code.google.com/p/evristika/"
SRC_URI="http://evristika.googlecode.com/files/${PN}-ttf-${PV}.tar.xz
	http://evristika.googlecode.com/files/${PN}-otf-${PV}.tar.xz
	http://evristika.googlecode.com/files/${PN}-pfb-${PV}.tar.xz"

LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

FONT_SUFFIX="otf pfb ttf"
FONT_S="${S}"
DOCS="FontLog.txt"
