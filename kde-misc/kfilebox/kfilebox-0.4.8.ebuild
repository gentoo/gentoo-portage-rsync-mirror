# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kfilebox/kfilebox-0.4.8.ebuild,v 1.1 2012/01/09 16:31:07 johu Exp $

EAPI=4

LANGS="ar br cs de el es fr gl it lt nl pl pt ru si tr zh zh_CN"
inherit qt4-r2

DESCRIPTION="KDE dropbox client"
HOMEPAGE="http://kdropbox.deuteros.es/"
SRC_URI="mirror://sourceforge/kdropbox/${P}.tar.gz"
LICENSE="GPL-3"

SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

for name in ${LANGS} ; do IUSE+="linguas_$name " ; done
unset name

DEPEND="kde-base/kdelibs"
RDEPEND="${DEPEND}"

src_install() {
	qt4-r2_src_install

	for lang in ${LANGS}; do
		if ! has ${lang} ${LINGUAS}; then
			rm -rf "${D}"/usr/share/locale/${lang} || die
		fi
	done
}
