# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-4.13.3.ebuild,v 1.1 2014/07/16 17:40:36 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Cervisia - A KDE CVS frontend"
HOMEPAGE="http://www.kde.org/applications/development/cervisia"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	dev-vcs/cvs
"
