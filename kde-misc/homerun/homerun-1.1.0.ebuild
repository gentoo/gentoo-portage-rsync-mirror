# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/homerun/homerun-1.1.0.ebuild,v 1.1 2013/07/15 21:33:02 johu Exp $

EAPI=5

DECLARATIVE_REQUIRED="always"
VIRTUALX_REQUIRED="test"
VIRTUALDBUS_TEST="true"
KDE_LINGUAS="cs da de el es fi lt mr nl pl pt pt_BR ru sk sl sv tr uk"
KDE_MINIMAL="4.10"
inherit kde4-base

DESCRIPTION="Application launcher for KDE Plasma desktop"
HOMEPAGE="https://projects.kde.org/projects/playground/base/homerun"
[[ ${PV} == *9999 ]] || SRC_URI="mirror://kde/stable/${PN}/src/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1 BSD"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkonq)
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="
	${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"

# Fails 2 out of 6, check later again.
# With virtualx/virtualdbus it hangs
RESTRICT="test"
