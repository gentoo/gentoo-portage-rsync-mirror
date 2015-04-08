# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-LaTeX/Pod-LaTeX-0.610.0.ebuild,v 1.4 2015/01/31 14:02:57 zlogene Exp $

EAPI=5

MODULE_AUTHOR=TJENNESS
MODULE_VERSION=0.61
inherit perl-module

DESCRIPTION="Convert Pod data to formatted LaTeX"

LICENSE="|| ( GPL-1+ Artistic )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	virtual/perl-Pod-Parser
	virtual/perl-if
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
"

SRC_TEST="do"
