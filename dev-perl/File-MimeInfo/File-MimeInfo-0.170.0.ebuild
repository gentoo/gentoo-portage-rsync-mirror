# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MimeInfo/File-MimeInfo-0.170.0.ebuild,v 1.10 2014/02/22 08:54:48 zlogene Exp $

EAPI=4

MODULE_AUTHOR=MICHIELB
MODULE_VERSION=0.17
inherit perl-module

DESCRIPTION="Determine file type"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/File-BaseDir-0.03
	>=dev-perl/File-DesktopEntry-0.04
	x11-misc/shared-mime-info
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
