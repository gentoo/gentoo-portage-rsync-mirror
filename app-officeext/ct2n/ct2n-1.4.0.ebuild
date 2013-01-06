# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/ct2n/ct2n-1.4.0.ebuild,v 1.2 2012/05/23 08:54:32 scarabeus Exp $

EAPI=4

MY_P="converttexttonumber-${PV}"
OO_EXTENSIONS=(
	"${MY_P}.oxt"
)
inherit office-ext

DESCRIPTION="Extension for converting text to numbers"
HOMEPAGE="http://extensions.libreoffice.org/extension-center/ct2n-convert-text-to-number-and-dates"
SRC_URI="http://extensions.libreoffice.org/extension-center/${PN}-convert-text-to-number-and-dates/releases/${PV}/${MY_P}.oxt"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/ooo"
DEPEND="${RDEPEND}"
