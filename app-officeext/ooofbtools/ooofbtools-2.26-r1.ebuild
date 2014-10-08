# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/ooofbtools/ooofbtools-2.26-r1.ebuild,v 1.3 2014/10/08 09:51:48 pinkbyte Exp $

EAPI=5

MY_PN="OOoFBTools"

inherit versionator

FETCHDIR=${PN}-$(delete_all_version_separators)

OFFICE_EXTENSIONS=(
	"${MY_PN}.oxt"
)

inherit office-ext-r1

DESCRIPTION="Extension for converting and processing eBooks in FictionBook2 format with validator"
HOMEPAGE="http://www.fbtools.org/ http://ru.fbtools.org/"
SRC_URI="http://ru.fbtools.org/project-updates/${FETCHDIR}/${MY_PN}-${PV}.7z"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="app-arch/p7zip"

S="${WORKDIR}/${MY_PN}-${PV}"

OFFICE_EXTENSIONS_LOCATION="${S}"

src_install() {
	office-ext-r1_src_install
	dodoc ChangeLog*
}
