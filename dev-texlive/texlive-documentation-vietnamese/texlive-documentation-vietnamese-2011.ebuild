# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-vietnamese/texlive-documentation-vietnamese-2011.ebuild,v 1.10 2012/05/09 17:14:23 aballier Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="amsldoc-vn lshort-vietnamese ntheorem-vn collection-documentation-vietnamese
"
TEXLIVE_MODULE_DOC_CONTENTS="amsldoc-vn.doc lshort-vietnamese.doc ntheorem-vn.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit  texlive-module
DESCRIPTION="TeXLive Vietnamese documentation"

LICENSE="GPL-2 LGPL-2 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2011
"
RDEPEND="${DEPEND} "
