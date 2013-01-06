# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audex/audex-0.74_beta1.ebuild,v 1.3 2012/05/02 17:59:13 johu Exp $

EAPI=4

KDE_LINGUAS="cs da de en_GB eo es fr ga it ja km lt mai nds nl pt pt_BR ru sv tr uk"
inherit kde4-base

MY_PV=${PV/_beta/b}
DESCRIPTION="KDE4 based CDDA extraction tool"
HOMEPAGE="http://kde.maniatek.com/audex/"
SRC_URI="http://kde.maniatek.com/${PN}/files/${PN}-${MY_PV}.tar.xz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	app-arch/xz-utils
	media-sound/cdparanoia
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

PATCHES=( "${FILESDIR}/${P}-gcc47.patch" )
