# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/keurocalc/keurocalc-1.2.1.ebuild,v 1.2 2014/02/07 16:00:16 kensington Exp $

EAPI=5

KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB es et fi fr ga gl hu it
ja ko nb nds nl pl pt pt_BR ru sk sl sr sr@Latn sv tr ug uk zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A universal currency converter and calculator"
HOMEPAGE="http://opensource.bureau-cornavin.com/keurocalc/index.html"
SRC_URI="http://opensource.bureau-cornavin.com/keurocalc/sources/${P}.tgz"

LICENSE="GPL-2+ FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

PATCHES=(
	"${FILESDIR}/${P}-desktopfile.patch"
	"${FILESDIR}/${P}-handbookdir.patch"
)
DOCS=( AUTHORS TODO )

src_prepare() {
	# bug 500560
	sed -e "s/PO_FILES //" -i po/*/CMakeLists.txt

	kde4-base_src_prepare
}
