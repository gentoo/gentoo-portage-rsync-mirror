# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-de-alt/myspell-de-alt-20061123.ebuild,v 1.1 2012/06/17 10:50:18 scarabeus Exp $

EAPI=4

MYSPELL_DICT=(
	"de_DE_1901.aff"
	"de_DE_1901.dic"
)

MYSPELL_HYPH=(
	"hyph_de_DE_1901.dic"
)

MYSPELL_THES=(
)

inherit myspell-r2

DESCRIPTION="German dictionaries for myspell/hunspell"
HOMEPAGE="http://www.j3e.de/myspell/"
# No version, determined by the date of the files on the web.
SRC_URI="
	${HOMEPAGE}/de_OLDSPELL.zip -> ${P}.zip
	${HOMEPAGE}/hyph_de_OLDSPELL.zip -> ${P}-hyphen.zip

"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

src_prepare() {
	# Nicely rename; http://www.iana.org/assignments/language-subtag-registry
	mv de_OLDSPELL.aff de_DE_1901.aff || die
	mv de_OLDSPELL.dic de_DE_1901.dic || die
	mv hyph_de_OLD.dic hyph_de_DE_1901.dic || die
}
