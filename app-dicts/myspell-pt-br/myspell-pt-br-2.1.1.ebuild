# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-pt-br/myspell-pt-br-2.1.1.ebuild,v 1.2 2012/07/25 15:43:18 mr_bones_ Exp $

EAPI=4

MYSPELL_DICT=(
	"pt_BR.aff"
	"pt_BR.dic"
)

MYSPELL_HYPH=(
	"hyph_pt_BR.dic"
)

MYSPELL_THES=(
	"th_pt_BR.dat"
	"th_pt_BR.idx"
)

inherit myspell-r2

DESCRIPTION="Brazilian dictionaries for myspell/hunspell"
HOMEPAGE="http://www.broffice.org/verortografico/"
# dicsin.com.br is dead; so no upstream for thesarus :-/
SRC_URI="
	http://www.broffice.org/files/Vero_pt_BR_V${PV//./}AOC.oxt
	http://wiki.documentfoundation.org/images/f/ff/DicSin-BR.oxt -> ${P}-thes.oxt
"

LICENSE="LGPL-3 MPL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
