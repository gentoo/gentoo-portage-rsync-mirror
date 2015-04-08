# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Emacs-PDE/Emacs-PDE-0.2.16-r1.ebuild,v 1.1 2013/09/04 13:28:08 idella4 Exp $

EAPI=5

MODULE_AUTHOR="YEWENBIN"

inherit perl-module elisp-common

DESCRIPTION="Perl Develop Environment in Emacs"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="virtual/emacs"
DEPEND="virtual/perl-Module-Build
		${RDEPEND}"
myconf="--elispdir=${D}${SITELISP}/pde"
