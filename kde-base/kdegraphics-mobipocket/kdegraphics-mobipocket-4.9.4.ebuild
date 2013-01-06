# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-mobipocket/kdegraphics-mobipocket-4.9.4.ebuild,v 1.2 2012/12/23 19:32:32 maekke Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Library to support mobipocket ebooks"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep okular)"
RDEPEND=${DEPEND}
