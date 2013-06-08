# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akonadiconsole/akonadiconsole-4.10.3.ebuild,v 1.6 2013/06/08 10:08:30 ago Exp $

EAPI=5

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Akonadi developer console"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)')
	$(add_kdebase_dep kdepim-common-libs)
	$(add_kdebase_dep nepomuk-core)
	$(add_kdebase_dep nepomuk-widgets)
	app-office/akonadi-server
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	akonadi_next/
	calendarsupport/
	messageviewer/
"
