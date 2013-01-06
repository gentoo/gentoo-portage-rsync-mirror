# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ktp-presence-applet/ktp-presence-applet-0.5.1.ebuild,v 1.1 2012/11/22 02:10:46 dastergon Exp $

EAPI=4

KDE_LINGUAS="ca cs da de el es et fi ga gl hu it ja lt nb nds nl pl pt
pt_BR sk sr sr@ijekavian sr@ijekavianlatin sr@latin sv uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE Telepathy presence applet"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/kde-telepathy/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-qt-0.9.3
"
RDEPEND="${DEPEND}
	>=net-im/ktp-contact-list-${PV}
"
