# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-mobipocket/kdegraphics-mobipocket-4.9.3.ebuild,v 1.4 2012/11/30 15:41:37 ago Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Library to support mobipocket ebooks"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep okular)"
RDEPEND=${DEPEND}
