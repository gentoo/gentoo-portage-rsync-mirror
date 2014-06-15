# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kqtquickcharts/kqtquickcharts-4.13.2.ebuild,v 1.1 2014/06/15 16:56:21 kensington Exp $

EAPI=5

DECLARATIVE_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Qt Quick 1 plugin for beautiful and interactive charts"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="$(add_kdebase_dep plasma-workspace '' 4.11)"
