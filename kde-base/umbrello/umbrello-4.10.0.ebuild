# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-4.10.0.ebuild,v 1.1 2013/02/07 04:57:34 alexxy Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdesdk"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="KDE UML Modeller"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
"
DEPEND="${RDEPEND}
	dev-libs/boost
"
