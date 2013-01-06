# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-genericextra/texlive-genericextra-2011.ebuild,v 1.11 2012/10/03 18:14:51 ulm Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="abbr abstyles barr borceux c-pascal colorsep dinat dirtree eijkhout encxvlna epigram fenixpar fltpoint fntproof iftex insbox lecturer librarian mathdots metatex mftoeps midnight multi navigator ofs pdf-trans shade systeme tabto-generic texapi upca xlop yax collection-genericextra
"
TEXLIVE_MODULE_DOC_CONTENTS="abbr.doc abstyles.doc barr.doc borceux.doc c-pascal.doc dinat.doc dirtree.doc encxvlna.doc fenixpar.doc fltpoint.doc fntproof.doc iftex.doc insbox.doc lecturer.doc librarian.doc mathdots.doc metatex.doc midnight.doc navigator.doc ofs.doc pdf-trans.doc shade.doc systeme.doc texapi.doc upca.doc xlop.doc yax.doc "
TEXLIVE_MODULE_SRC_CONTENTS="dirtree.source fltpoint.source mathdots.source mftoeps.source xlop.source "
inherit  texlive-module
DESCRIPTION="TeXLive Extra generic packages"

LICENSE="GPL-2 GPL-1 LPPL-1.3 public-domain TeX TeX-other-free"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
"
RDEPEND="${DEPEND} "
