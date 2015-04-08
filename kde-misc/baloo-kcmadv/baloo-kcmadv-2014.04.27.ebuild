# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/baloo-kcmadv/baloo-kcmadv-2014.04.27.ebuild,v 1.2 2014/05/06 04:01:21 jmbsvicetto Exp $

EAPI=5
KDE_MINIMAL=4.13.0

inherit kde4-base

DESCRIPTION="Alternative configuration module for the Baloo search framework"
HOMEPAGE="https://gitorious.org/baloo-kcmadv"
EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}"
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

DEPEND="
	$(add_kdebase_dep baloo)
	$(add_kdebase_dep kfilemetadata)
	dev-libs/qjson
	dev-libs/xapian
"
RDEPEND="${DEPEND}"
