# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/polkit-kde/polkit-kde-0.95.1-r1.ebuild,v 1.9 2013/01/11 21:17:06 dilfridge Exp $

EAPI=3

if [[ ${PV} = *9999* ]]; then
	KMNAME="extragear/base"
	KMMODULE="polkit-kde-1"
else
	KDE_LINGUAS="da en_GB et gl lt nl pt pt_BR sk sv uk zh_TW"
	MY_P="${P/kde/kde-1}"
	SRC_URI="mirror://kde/stable/apps/KDE4.x/admin/${MY_P}.tar.bz2"
fi
inherit kde4-base

DESCRIPTION="PolicyKit integration module for KDE."
HOMEPAGE="http://kde.org"

LICENSE="GPL-2"
KEYWORDS="amd64 ~arm ppc x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=sys-auth/polkit-qt-0.95.1
	!>=sys-auth/polkit-qt-0.99
	!sys-auth/polkit-kde-agent
"
RDEPEND="${DEPEND}"

[[ ${PV} = *9999* ]] || S="${WORKDIR}/${MY_P}"

PATCHES+=(
	"${FILESDIR}/${P}-gcc45.patch" # 314471 - fixed upstream for next version
	"${FILESDIR}/${P}-autostart-dir.patch" # 310999 - fixed upstream
)
