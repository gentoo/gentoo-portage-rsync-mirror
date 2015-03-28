# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-meme/embassy-meme-4.7.650.ebuild,v 1.1 2015/03/28 17:17:41 jlec Exp $

EAPI=5

EBO_DESCRIPTION="wrappers for MEME - Multiple Em for Motif Elicitation"

PATCHES=( "${FILESDIR}"/${P}_fix-build-system.patch )
AUTOTOOLS_AUTORECONF=1
inherit emboss-r1

KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos"

RDEPEND+=" sci-biology/meme"
