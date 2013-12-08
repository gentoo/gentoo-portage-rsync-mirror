# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-4.11.2.ebuild,v 1.2 2013/12/08 14:07:41 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdnssd)
	$(add_kdebase_dep khotkeys)
"
