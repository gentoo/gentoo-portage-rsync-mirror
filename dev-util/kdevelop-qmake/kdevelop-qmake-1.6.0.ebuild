# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-qmake"
inherit kde4-base

MY_PN="${KMNAME}"
S=${WORKDIR}/${MY_PN}
DESCRIPTION="Qt's qmake build system plugin for KDevelop"
HOMEPAGE="http://www.kdevelop.org/"
SRC_URI="http://quickgit.kde.org/?p=${MY_PN}.git&a=snapshot&h=${PV%%.0} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-util/kdevelop:4
	dev-util/kdevelop-pg-qt:4
"
RDEPEND="${DEPEND}"

src_install() {
	kde4-base_src_install
	rm "${D}/usr/share/apps/kdevappwizard/templates/qmake_qt4guiapp.tar.bz2"
}
