# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Tags/Perl-Tags-0.280.0.ebuild,v 1.3 2011/08/09 19:04:01 xarthisius Exp $

EAPI=4

MODULE_AUTHOR=OSFAMERON
MODULE_VERSION=0.28
inherit perl-module

DESCRIPTION="Generate (possibly exuberant) Ctags style tags for Perl sourcecode"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="
	virtual/perl-File-Spec
	virtual/perl-File-Temp
	dev-perl/Module-Locate
	dev-perl/PPI
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
