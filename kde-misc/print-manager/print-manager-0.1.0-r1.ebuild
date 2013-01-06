# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/print-manager/print-manager-0.1.0-r1.ebuild,v 1.2 2012/11/14 15:01:08 kensington Exp $

EAPI=4

KDE_SCM="git"
KDE_LINGUAS="cs da de et hu km nl pl pt pt_BR sk sv uk"
inherit kde4-base

DESCRIPTION="Manage print jobs and printers in KDE"
HOMEPAGE="https://projects.kde.org/projects/kde/kdeutils/print-manager"
[[ "${PV}" != "9999" ]] && SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
SRC_URI+=" http://dev.gentoo.org/~dilfridge/distfiles/${P}-cups16.patch.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	>=net-print/cups-1.6.0[dbus]
"
DEPEND="${RDEPEND}"

PATCHES=( "${WORKDIR}/${P}-cups16.patch" )

src_configure() {
	mycmakeargs=( -DCUPS_1_6=ON )
	kde4-base_src_configure
}
