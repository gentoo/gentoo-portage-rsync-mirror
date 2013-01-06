# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-fontsrecommended/texlive-fontsrecommended-2011.ebuild,v 1.11 2012/10/03 18:13:27 ulm Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="avantgar bookman charter cm-super cmextra courier euro euro-ce eurosym fpl helvetic lm marvosym mathpazo ncntrsbk palatino pxfonts rsfs symbol tex-gyre times tipa txfonts utopia wasy wasysym zapfchan zapfding collection-fontsrecommended
"
TEXLIVE_MODULE_DOC_CONTENTS="charter.doc cm-super.doc euro.doc euro-ce.doc eurosym.doc fpl.doc lm.doc marvosym.doc mathpazo.doc pxfonts.doc rsfs.doc tex-gyre.doc tipa.doc txfonts.doc utopia.doc wasy.doc wasysym.doc "
TEXLIVE_MODULE_SRC_CONTENTS="euro.source fpl.source lm.source mathpazo.source wasysym.source "
inherit  texlive-module
DESCRIPTION="TeXLive Recommended fonts"

LICENSE="GPL-2 GPL-1 LPPL-1.3 public-domain TeX-other-free"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
!=dev-texlive/texlive-basic-2007*
!<dev-texlive/texlive-fontsextra-2010
"
RDEPEND="${DEPEND} "
