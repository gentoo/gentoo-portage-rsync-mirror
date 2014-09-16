# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-dev-utils/kde-dev-utils-4.14.1.ebuild,v 1.1 2014/09/16 18:17:26 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE Development Utilities"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	!kde-base/kdesdk-misc:4
	!kde-base/kstartperf:4
	!kde-base/kuiviewer:4
"
