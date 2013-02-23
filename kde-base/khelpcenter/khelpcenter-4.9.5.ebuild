# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khelpcenter/khelpcenter-4.9.5.ebuild,v 1.6 2013/02/23 16:34:43 ago Exp $

EAPI=4

KDE_HANDBOOK="always"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Help Center"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdesu)
	>=www-misc/htdig-3.2.0_beta6-r1
"

KMEXTRA="
	doc/documentationnotfound/
	doc/glossary/
	doc/onlinehelp/
"
