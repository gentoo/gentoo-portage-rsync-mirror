# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/partitionmanager/partitionmanager-1.1.0.ebuild,v 1.1 2014/07/13 12:26:58 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
KDE_LINGUAS="ar bg bs ca ca@valencia cs da de el en_GB es et fr gl it lt nb nds
nl pa pl pt pt_BR ro ru sk sl sr sr@ijekavian sr@ijekavianlatin sr@latin sv tr
uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE utility for management of partitions and file systems"
HOMEPAGE="http://partitionman.sourceforge.net/"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	dev-libs/libatasmart
	>=sys-block/parted-3
	sys-apps/util-linux
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_UDISKS2=ON
	)

	kde4-base_src_configure
}
