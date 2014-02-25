# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/ooofbtools/ooofbtools-2.25.ebuild,v 1.2 2014/02/25 21:04:58 scarabeus Exp $

EAPI=5

MY_PN="OOoFBTools"

OFFICE_EXTENSIONS=(
	"${MY_PN}.oxt"
)

inherit office-ext-r1

DESCRIPTION="Extension for converting and processing eBooks in FictionBook2 format with validator extension"
HOMEPAGE="http://www.fbtools.org/"
SRC_URI="http://www.fbtools.org/project-updates/${PN}-225/${MY_PN}-${PV}.7z"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS=( ChangeLog* )

OFFICE_EXTENSIONS_LOCATION="${S}"

src_install() {
	default

	einstalldocs
}
