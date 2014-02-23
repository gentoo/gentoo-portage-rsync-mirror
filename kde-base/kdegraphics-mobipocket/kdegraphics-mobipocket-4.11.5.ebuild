# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-mobipocket/kdegraphics-mobipocket-4.11.5.ebuild,v 1.6 2014/02/23 09:08:45 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Library to support mobipocket ebooks"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep okular)"
RDEPEND=${DEPEND}
