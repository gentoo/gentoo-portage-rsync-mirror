# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kunitconversion/kunitconversion-5.8.0.ebuild,v 1.1 2015/03/21 17:26:27 kensington Exp $

EAPI=5

inherit kde5

DESCRIPTION="Framework for converting units"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	$(add_frameworks_dep ki18n)
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
"
DEPEND="${RDEPEND}"
