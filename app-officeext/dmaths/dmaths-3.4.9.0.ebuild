# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/dmaths/dmaths-3.4.9.0.ebuild,v 1.1 2012/10/31 21:02:29 scarabeus Exp $

EAPI=5

OO_EXTENSIONS=(
	"${PN}addon.oxt"
)
inherit office-ext

DESCRIPTION="Mathematics Formula Editor Extension"
HOMEPAGE="http://extensions.libreoffice.org/extension-center/dmaths"
SRC_URI="http://extensions.libreoffice.org/extension-center/${PN}/releases/${PV}/${PN}addon.oxt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/ooo"
DEPEND="${RDEPEND}"
