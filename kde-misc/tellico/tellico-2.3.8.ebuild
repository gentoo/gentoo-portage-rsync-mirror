# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-2.3.8.ebuild,v 1.2 2013/07/11 15:36:09 kensington Exp $

EAPI=5

KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et eu fi fr ga gl hu
ia it ja kk lt mr ms nb nds nl nn pl pt pt_BR ro ru sk sl sv tr ug uk zh_CN
zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A collection manager for the KDE environment"
HOMEPAGE="http://tellico-project.org/"
SRC_URI="http://tellico-project.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="addressbook cddb debug pdf scanner taglib v4l xmp yaz"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/qjson
	$(add_kdebase_dep kdelibs 'semantic-desktop(+)')
	media-libs/qimageblitz
	dev-qt/qtdbus:4
	addressbook? ( $(add_kdebase_dep kdepimlibs) )
	cddb? ( $(add_kdebase_dep libkcddb) )
	pdf? ( app-text/poppler[qt4] )
	scanner? ( $(add_kdebase_dep libksane) )
	taglib? ( >=media-libs/taglib-1.5 )
	v4l? ( >=media-libs/libv4l-0.8.3 )
	xmp? ( >=media-libs/exempi-2 )
	yaz? ( >=dev-libs/yaz-2 )
"
RDEPEND="${DEPEND}"

# tests need network access and well-defined server responses
RESTRICT="test"

DOCS=( AUTHORS ChangeLog README )

src_prepare() {
	# KDE_LINGUAS is also used to install appropriate handbooks
	# since there is no en_US 'translation', it cannot be added
	# hence making this impossible to install
	mv doc/en_US doc/en || die "doc move failed"
	sed -i -e 's/en_US/en/' doc/CMakeLists.txt || die "sed failed"

	kde4-base_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable v4l WEBCAM)
		$(cmake-utils_use_with xmp Exempi)
		$(cmake-utils_use_with scanner KSane)
		$(cmake-utils_use_with cddb Kcddb)
		$(cmake-utils_use_with addressbook KdepimLibs)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with taglib)
		$(cmake-utils_use_with yaz)
	)

	kde4-base_src_configure
}
