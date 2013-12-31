# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcm-grub2/kcm-grub2-0.6.4.ebuild,v 1.2 2013/12/24 12:49:57 ago Exp $

EAPI=5

KDE_LINGUAS="ca ca@valencia cs da de el es et fi fr ga gl hu it lt nl pa pl pt
pt_BR ro ru sk sl sv uk tr zh_TW"
inherit kde4-base

DESCRIPTION="KCModule for configuring the GRUB2 bootloader."
HOMEPAGE="http://kde-apps.org/content/show.php?content=139643"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"

KEYWORDS="~amd64 x86"
SLOT="4"
IUSE="+hwinfo imagemagick packagekit"

COMMON_DEPEND="
	hwinfo? ( sys-apps/hwinfo )
	imagemagick? ( media-gfx/imagemagick )
	packagekit? ( app-admin/packagekit-qt4 )
"
DEPEND="${COMMON_DEPEND}
	dev-util/automoc
"
RDEPEND="${COMMON_DEPEND}
	$(add_kdebase_dep kcmshell)
"

src_configure() {
	local mycmakeargs=(
		"-DWITHQApt=OFF"
		$(cmake-utils_use_with packagekit QPackageKit)
		$(cmake-utils_use_with imagemagick ImageMagick)
		$(cmake-utils_use_with hwinfo HD)
	)
	cmake-utils_src_configure
}
