# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Duration/Time-Duration-1.60.0.ebuild,v 1.2 2011/09/03 21:04:46 tove Exp $

EAPI=4

MODULE_AUTHOR=AVIF
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="Rounded or exact English expression of durations"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-linux"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
