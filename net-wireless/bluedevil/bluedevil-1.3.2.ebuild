# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluedevil/bluedevil-1.3.2.ebuild,v 1.4 2013/12/24 12:47:32 ago Exp $

EAPI=5

KDE_LINGUAS="ar bs ca ca@valencia cs da de el en_GB eo es et eu fa fi fr ga gl
hu it ja kk km ko lt mai mr ms nb nds nl pa pl pt pt_BR ro ru sk sl sr
sr@ijekavian sr@ijekavianlatin sr@latin sv th tr ug uk zh_CN zh_TW"
inherit kde4-base

MY_P=${PN}-v${PV}
DESCRIPTION="Bluetooth stack for KDE"
HOMEPAGE="http://projects.kde.org/projects/extragear/base/bluedevil"
SRC_URI="mirror://kde/stable/${PN}/${MY_P}.tar.xz"

LICENSE="GPL-2+"
KEYWORDS="~amd64 ~arm ppc ppc64 x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-libs/libbluedevil-1.9.3
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	!net-wireless/kbluetooth
	app-mobilephone/obexd[-server]
	app-mobilephone/obex-data-server
"
S=${WORKDIR}/${MY_P}
