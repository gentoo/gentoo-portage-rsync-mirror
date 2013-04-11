# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ktp-common-internals/ktp-common-internals-0.6.0.ebuild,v 1.1 2013/04/11 15:18:49 scarabeus Exp $

EAPI=4

KDE_LINGUAS="ca cs da de el es et fi fr ga gl hu it ja lt nb nds nl pl pt pt_BR
ru sk sr sr@ijekavian sr@ijekavianlatin sr@latin sv uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE Telepathy common library"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/stable/kde-telepathy/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-qt-0.9.3
	>=net-libs/telepathy-logger-qt-0.5.80
	!<net-im/ktp-text-ui-0.5.80
	!!<net-im/ktp-contact-list-0.4.0
"
RDEPEND="${DEPEND}"
