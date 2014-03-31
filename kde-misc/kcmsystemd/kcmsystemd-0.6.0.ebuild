# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcmsystemd/kcmsystemd-0.6.0.ebuild,v 1.1 2014/03/31 19:43:16 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE control module for systemd"
HOMEPAGE="https://github.com/rthomsen/kcmsystemd"
SRC_URI="https://github.com/rthomsen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

IUSE="debug"
LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-libs/boost-1.45"

RDEPEND="${DEPEND}
	$(add_kdebase_dep kcmshell)
	sys-apps/systemd
"
