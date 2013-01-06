# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Levenshtein/Text-Levenshtein-0.50.0.ebuild,v 1.3 2011/12/01 16:13:10 tove Exp $

EAPI=4

MODULE_AUTHOR=JGOLDBERG
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="An implementation of the Levenshtein edit distance"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"
