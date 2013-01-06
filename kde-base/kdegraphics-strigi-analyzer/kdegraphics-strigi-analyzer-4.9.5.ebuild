# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-strigi-analyzer/kdegraphics-strigi-analyzer-4.9.5.ebuild,v 1.1 2013/01/05 20:18:30 creffett Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="kdegraphics: strigi plugins"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-misc/strigi
"
RDEPEND="${DEPEND}"
