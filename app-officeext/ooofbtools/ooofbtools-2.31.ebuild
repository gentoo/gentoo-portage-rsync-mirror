# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/ooofbtools/ooofbtools-2.31.ebuild,v 1.2 2015/02/19 10:40:37 ago Exp $

EAPI=5

MY_PN="OOoFBTools"

OFFICE_EXTENSIONS=(
	"${MY_PN}.oxt"
)

inherit office-ext-r1

DESCRIPTION="Extension for converting and processing eBooks in FictionBook2 format with validator"
HOMEPAGE="https://sourceforge.net/projects/fbtools/"
SRC_URI="mirror://sourceforge/fbtools/files/release/${MY_PN}-${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND="dev-libs/libxml2"

S="${WORKDIR}/${MY_PN}-${PV}"

OFFICE_EXTENSIONS_LOCATION="${S}"

src_prepare() {
	# Remove Windows cruft
	pushd "${WORKDIR}/${MY_PN}.oxt" 2>/dev/null
	rm -r win32 || die
	popd 2>/dev/null
}

src_install() {
	office-ext-r1_src_install
	dodoc ChangeLog*
}
