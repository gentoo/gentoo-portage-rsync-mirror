# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline/Inline-0.470.0.ebuild,v 1.1 2011/08/30 13:08:55 tove Exp $

EAPI=4

MODULE_AUTHOR=SISYPHUS
MODULE_VERSION=0.47
inherit perl-module

DESCRIPTION="Write Perl subroutines in other languages"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/perl-Digest-MD5
	virtual/perl-File-Spec
	dev-perl/Parse-RecDescent"
DEPEND="${RDEPEND}"

SRC_TEST=do
