# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-4.11.1.ebuild,v 1.1 2013/09/03 19:04:29 creffett Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE UML Modeller"
HOMEPAGE="
	http://www.kde.org/applications/development/umbrello
	http://umbrello.kde.org
"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
"
DEPEND="${RDEPEND}
	dev-libs/boost
"
