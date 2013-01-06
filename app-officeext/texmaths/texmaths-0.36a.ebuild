# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/texmaths/texmaths-0.36a.ebuild,v 1.4 2012/11/24 21:48:13 ago Exp $

EAPI=4

MY_P="TexMaths-${PV}"

OO_EXTENSIONS=(
	"${MY_P}.oxt"
)

inherit office-ext

DESCRIPTION="LaTeX Equation Editor for LibreOffice"
HOMEPAGE="http://roland65.free.fr/texmaths/"
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${MY_P}.oxt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	app-text/dvisvgm
	virtual/tex-base
"
