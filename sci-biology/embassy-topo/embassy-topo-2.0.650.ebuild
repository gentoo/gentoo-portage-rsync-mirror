# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-topo/embassy-topo-2.0.650.ebuild,v 1.1 2015/03/28 17:08:46 jlec Exp $

EAPI=5

EBO_DESCRIPTION="Transmembrane protein display"

PATCHES=( "${FILESDIR}"/${P}_fix-build-system.patch )
AUTOTOOLS_AUTORECONF=1
inherit emboss-r1

KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
