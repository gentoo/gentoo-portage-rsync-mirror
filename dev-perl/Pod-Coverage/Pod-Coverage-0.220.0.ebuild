# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Coverage/Pod-Coverage-0.220.0.ebuild,v 1.10 2014/01/20 20:40:50 vapier Exp $

EAPI=4

MODULE_AUTHOR=RCLAMP
MODULE_VERSION=0.22
inherit perl-module

DESCRIPTION="Checks if the documentation of a module is comprehensive"

SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=virtual/perl-PodParser-1.13
	>=dev-perl/Devel-Symdump-2.01
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
	)
"

SRC_TEST="do"
