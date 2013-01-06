# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Install/Sub-Install-0.926.0.ebuild,v 1.7 2012/09/09 16:14:52 armin76 Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.926
inherit perl-module

DESCRIPTION="install subroutines into packages easily"

SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ~ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
