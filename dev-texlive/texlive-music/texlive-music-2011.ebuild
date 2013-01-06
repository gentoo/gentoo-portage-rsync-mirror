# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-music/texlive-music-2011.ebuild,v 1.10 2012/05/09 17:19:34 aballier Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="abc figbas gchords guitar harmony musixguit musixtex songbook collection-music
"
TEXLIVE_MODULE_DOC_CONTENTS="abc.doc gchords.doc guitar.doc harmony.doc musixguit.doc musixtex.doc songbook.doc "
TEXLIVE_MODULE_SRC_CONTENTS="abc.source guitar.source musixtex.source songbook.source "
inherit  texlive-module
DESCRIPTION="TeXLive Music typesetting"

LICENSE="GPL-2 GPL-1 LGPL-2.1 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2011
!<app-text/texlive-core-2011
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/musixtex/musixflx.lua texmf-dist/scripts/musixtex/musixtex.lua"
