# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yakuake/yakuake-2.9.9-r1.ebuild,v 1.1 2012/10/26 14:26:03 creffett Exp $

EAPI=4

KDE_LINGUAS="ca ca@valencia cs da de el en_GB es et fi fr ga gl hr hu it km ko
nb nds nl nn pa pl pt pt_BR ro ru sk sr sr@ijekavian sr@ijekavianlatin sr@latin
sv th tr uk wa zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="$(add_kdebase_dep konsole)
	sys-devel/gettext"
RDEPEND="${DEPEND}"
