# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langother/texlive-langother-2011.ebuild,v 1.11 2012/10/03 18:19:27 ulm Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="hyphen-afrikaans hyphen-armenian hyphen-coptic hyphen-esperanto hyphen-estonian hyphen-icelandic hyphen-indonesian hyphen-interlingua hyphen-irish hyphen-kurmanji hyphen-lao hyphen-romanian hyphen-serbian hyphen-slovenian hyphen-turkish hyphen-uppersorbian hyphen-welsh collection-langother
"
TEXLIVE_MODULE_DOC_CONTENTS=""
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit  texlive-module
DESCRIPTION="TeXLive Other hyphenation patterns"

LICENSE="GPL-2 GPL-1 LPPL-1.3 TeX-other-free"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
!<dev-texlive/texlive-basic-2009
"
RDEPEND="${DEPEND} "
