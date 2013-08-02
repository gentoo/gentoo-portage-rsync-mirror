# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-4.10.5.ebuild,v 1.5 2013/08/02 14:29:25 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdnssd)
	$(add_kdebase_dep khotkeys)
"
