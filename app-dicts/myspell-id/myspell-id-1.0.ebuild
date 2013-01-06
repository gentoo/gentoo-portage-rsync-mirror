# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-id/myspell-id-1.0.ebuild,v 1.1 2012/07/23 13:58:45 scarabeus Exp $

EAPI=4

MYSPELL_DICT=(
	"id.aff"
	"id.dic"
)

MYSPELL_HYPH=(
	"hyph_id.dic"
)

MYSPELL_THES=(
)

inherit myspell-r2

DESCRIPTION="Indonesian dictionaries for myspell/hunspell"
HOMEPAGE="http://extensions.libreoffice.org/extension-center/indonesian-dictionary-kamus-indonesia-by-benitius"
SRC_URI="http://extensions.libreoffice.org/extension-center/indonesian-dictionary-kamus-indonesia-by-benitius/releases/${PV}/id.oxt -> ${P}.oxt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""
