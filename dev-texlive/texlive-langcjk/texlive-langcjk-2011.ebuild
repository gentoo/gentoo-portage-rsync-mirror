# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcjk/texlive-langcjk-2011.ebuild,v 1.13 2012/10/03 18:15:48 ulm Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="adobemapping arphic c90 cjkpunct cns ctex dnp garuda-c90 hyphen-chinese jsclasses norasi-c90 ptex thailatex uhc wadalab zhmetrics zhspacing collection-langcjk
"
TEXLIVE_MODULE_DOC_CONTENTS="arphic.doc c90.doc cjkpunct.doc cns.doc ctex.doc ptex.doc uhc.doc wadalab.doc zhmetrics.doc zhspacing.doc "
TEXLIVE_MODULE_SRC_CONTENTS="c90.source cjkpunct.source garuda-c90.source jsclasses.source norasi-c90.source ptex.source thailatex.source zhmetrics.source "
inherit  texlive-module
DESCRIPTION="TeXLive Chinese, Japanese, Korean"

LICENSE="GPL-2 BSD LPPL-1.3 TeX-other-free"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
>=app-text/texlive-core-2010[cjk]
>=dev-texlive/texlive-latex-2011
"
RDEPEND="${DEPEND} "
