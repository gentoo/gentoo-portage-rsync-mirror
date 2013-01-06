# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/barcode/barcode-1.3.5.0.ebuild,v 1.2 2012/05/23 08:54:32 scarabeus Exp $

EAPI=4

OO_EXTENSIONS=(
	"${PN}_${PV}.oxt"
)
inherit office-ext

DESCRIPTION="Extension for reading barcodes"
HOMEPAGE="http://extensions.libreoffice.org/extension-center/barcode"
SRC_URI="http://extensions.libreoffice.org/extension-center/${PN}/releases/${PV}/${PN}_${PV}.oxt"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/ooo"
DEPEND="${RDEPEND}"
