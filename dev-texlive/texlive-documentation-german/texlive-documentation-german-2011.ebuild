# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-german/texlive-documentation-german-2011.ebuild,v 1.11 2012/10/03 18:10:33 ulm Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="kopka l2picfaq l2tabu latex-bib-ex latex-referenz latex-tabellen latex-tipps-und-tricks lshort-german pdf-forms-tutorial-de presentations pstricks-examples templates-fenn templates-sommer texlive-de voss-de collection-documentation-german
"
TEXLIVE_MODULE_DOC_CONTENTS="kopka.doc l2picfaq.doc l2tabu.doc latex-bib-ex.doc latex-referenz.doc latex-tabellen.doc latex-tipps-und-tricks.doc lshort-german.doc pdf-forms-tutorial-de.doc presentations.doc pstricks-examples.doc templates-fenn.doc templates-sommer.doc texlive-de.doc voss-de.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit  texlive-module
DESCRIPTION="TeXLive German documentation"

LICENSE="GPL-2 FDL-1.1 GPL-1 LPPL-1.3 TeX-other-free"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2011
"
RDEPEND="${DEPEND} "
