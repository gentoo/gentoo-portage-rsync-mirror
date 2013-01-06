# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-NoWarnings/Test-NoWarnings-1.40.0.ebuild,v 1.11 2012/09/01 11:57:04 grobian Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="Make sure you didn't emit any warnings while testing"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-perl/Test-Tester-0.107"
DEPEND="${RDEPEND}"

SRC_TEST="do"
