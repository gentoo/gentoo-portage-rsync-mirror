# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/capitalization/capitalization-0.30.0.ebuild,v 1.2 2011/09/03 21:05:10 tove Exp $

EAPI=4

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="no capitalization on method names"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/Devel-Symdump"
DEPEND="${RDEPEND}"

SRC_TEST="do"
