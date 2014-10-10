# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audex/audex-0.78.ebuild,v 1.2 2014/10/10 15:20:40 ago Exp $

EAPI=5

KDE_LINGUAS="bs cs da de en_GB eo es et fi fr ga gl hu it ja km lt mai nds nl
pl pt pt_BR ru sk sv tr ug uk zh_CN"
inherit kde4-base

MY_PV=${PV/_beta/b}
DESCRIPTION="KDE based CDDA extraction tool"
HOMEPAGE="http://kde.maniatek.com/audex/"
SRC_URI="http://kde.maniatek.com/${PN}/files/${PN}-${MY_PV}.tar.xz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	app-arch/xz-utils
	media-sound/cdparanoia
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"
